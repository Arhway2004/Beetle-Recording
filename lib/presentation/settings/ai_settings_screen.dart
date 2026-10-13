import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/ai/ai_provider.dart';
import '../../domain/models/enums.dart';
import '../../infrastructure/ai/gateway_client.dart';
import '../../infrastructure/ai/network_policy.dart';
import '../../infrastructure/storage/secure_store.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

/// Mac AI gateway configuration. The token is kept in platform secure storage.
class AiSettingsScreen extends ConsumerStatefulWidget {
  const AiSettingsScreen({super.key});

  @override
  ConsumerState<AiSettingsScreen> createState() => _AiSettingsScreenState();
}

class _AiSettingsScreenState extends ConsumerState<AiSettingsScreen> {
  final _form = GlobalKey<FormState>();
  final _url = TextEditingController();
  final _token = TextEditingController();
  final _fingerprint = TextEditingController();
  final _model = TextEditingController();
  final _timeout = TextEditingController();
  bool _enabled = false;
  bool _hasToken = false;
  bool _loaded = false;
  bool _testing = false;
  DateTime? _consentAt;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final row = await ref.read(settingsRepoProvider).provider(AiProviderKind.mac);
    final token = await ref.read(secretStoreProvider).read(SecretKeys.gatewayToken);
    setState(() {
      _url.text = row.baseUrl ?? '';
      _fingerprint.text = row.certSha256 ?? '';
      _model.text = row.model ?? '';
      _timeout.text = '${row.timeoutSeconds}';
      _enabled = row.enabled;
      _hasToken = token != null && token.isNotEmpty;
      _consentAt = row.consentGrantedAt;
      _loaded = true;
    });
  }

  Future<bool> _save() async {
    if (!_form.currentState!.validate()) return false;
    final settings = ref.read(settingsRepoProvider);
    final previous = await settings.provider(AiProviderKind.mac);
    final url = _url.text.trim();
    await settings.updateProvider(
      AiProviderKind.mac,
      enabled: _enabled,
      baseUrl: url,
      model: _model.text.trim(),
      certSha256: () => normalizeFingerprint(_fingerprint.text),
      timeoutSeconds: int.tryParse(_timeout.text) ?? 60,
    );
    // Consent is bound to a destination: a new address requires new consent.
    if (previous.baseUrl != url && previous.consentGrantedAt != null) {
      await settings.setConsent(AiProviderKind.mac, false);
      if (mounted) setState(() => _consentAt = null);
    }
    if (_token.text.trim().isNotEmpty) {
      await ref.read(secretStoreProvider).write(SecretKeys.gatewayToken, _token.text.trim());
      _token.clear();
      if (mounted) setState(() => _hasToken = true);
    }
    ref.invalidate(gatewayTokenProvider);
    ref.invalidate(aiProvidersProvider);
    return true;
  }

  Future<void> _test() async {
    final l = context.l10n;
    if (!await _save() || !mounted) return;
    setState(() => _testing = true);
    try {
      final token = await ref.read(secretStoreProvider).read(SecretKeys.gatewayToken);
      final client = GatewayClient(GatewayConfig(
        baseUrl: Uri.parse(_url.text.trim()),
        token: token ?? '',
        timeout: const Duration(seconds: 10),
        certSha256: normalizeFingerprint(_fingerprint.text),
      ));
      final h = await client.health();
      client.close();
      if (!mounted) return;
      showSnack(context, '${l.settingsConnectionOk} · Ollama: ${h.ollamaReachable ? 'OK' : '✕'} · ${h.models.join(', ')}');
    } on AiProviderException catch (e) {
      if (mounted) showSnack(context, '${l.unavailable(e.code)}\n${e.message}');
    } catch (e) {
      if (mounted) showSnack(context, '$e');
    } finally {
      if (mounted) setState(() => _testing = false);
    }
  }

  @override
  void dispose() {
    for (final c in [_url, _token, _fingerprint, _model, _timeout]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    if (!_loaded) return const Scaffold(body: LoadingView());
    final host = Uri.tryParse(_url.text.trim())?.host ?? '';
    final scope = host.isEmpty ? null : classifyHost(host);
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsMacGateway), actions: [
        TextButton(
          onPressed: () async {
            final saved = await _save();
            if (saved && mounted) showSnack(this.context, l.commonSaved);
          },
          child: Text(l.commonSave),
        ),
      ]),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(Insets.m), children: [
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(l.settingsEnabled),
            value: _enabled,
            onChanged: (v) => setState(() => _enabled = v),
          ),
          TextFormField(
            controller: _url,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: InputDecoration(labelText: l.settingsGatewayUrl, helperText: l.settingsGatewayUrlHelper),
            onChanged: (_) => setState(() {}),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return _enabled ? l.commonRequired : null;
              final u = Uri.tryParse(v.trim());
              return (u == null || u.host.isEmpty || !isTransportAllowed(u)) ? l.settingsGatewayUrlInvalid : null;
            },
          ),
          if (scope == HostScope.public) ...[
            const SizedBox(height: Insets.s),
            Text(l.assistantConsentPublicWarning, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
          formGapSmall,
          TextFormField(
            controller: _token,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              labelText: l.settingsGatewayToken,
              helperText: _hasToken ? l.settingsGatewayTokenSet : l.settingsGatewayTokenHelper,
              helperMaxLines: 2,
            ),
          ),
          formGapSmall,
          TextFormField(
            controller: _fingerprint,
            autocorrect: false,
            decoration: InputDecoration(
                labelText: l.settingsCertFingerprint, helperText: l.settingsCertFingerprintHelper, helperMaxLines: 2),
            validator: (v) =>
                (v == null || v.trim().isEmpty || normalizeFingerprint(v) != null) ? null : l.settingsCertFingerprintInvalid,
          ),
          formGapSmall,
          TextFormField(controller: _model, decoration: InputDecoration(labelText: l.settingsModel)),
          formGapSmall,
          TextFormField(
            controller: _timeout,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: l.settingsTimeout),
            validator: (v) {
              final n = int.tryParse(v ?? '');
              return (n == null || n < 5 || n > 600) ? l.commonInvalidNumber : null;
            },
          ),
          const SizedBox(height: Insets.l),
          FilledButton.icon(
            onPressed: _testing ? null : _test,
            icon: _testing
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.network_check),
            label: Text(l.settingsTestConnection),
          ),
          if (_consentAt != null) ...[
            const SizedBox(height: Insets.l),
            Text(l.settingsConsentGranted(Fmt.of(context).dateTime(_consentAt))),
            TextButton(
              onPressed: () async {
                await ref.read(settingsRepoProvider).setConsent(AiProviderKind.mac, false);
                ref.invalidate(aiProvidersProvider);
                setState(() => _consentAt = null);
              },
              child: Text(l.settingsRevokeConsent),
            ),
          ],
        ]),
      ),
    );
  }
}

const formGapSmall = SizedBox(height: Insets.m);

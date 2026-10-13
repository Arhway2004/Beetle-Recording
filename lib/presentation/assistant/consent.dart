import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../domain/models/enums.dart';
import '../../infrastructure/ai/network_policy.dart';
import '../common/labels.dart';

/// Asks for explicit consent before any breeding data is sent to the Mac
/// gateway. Returns true when consent exists or was just granted. Returns
/// true without asking when the Mac provider is not configured (the router
/// will then report it as unavailable instead).
Future<bool> ensureAiConsent(BuildContext context, WidgetRef ref) async {
  final settings = ref.read(settingsRepoProvider);
  final mac = await settings.provider(AiProviderKind.mac);
  if (!mac.enabled || mac.baseUrl == null || mac.baseUrl!.isEmpty) return true;
  if (mac.consentGrantedAt != null) return true;
  if (!context.mounted) return false;
  final uri = Uri.tryParse(mac.baseUrl!);
  final host = uri?.host ?? mac.baseUrl!;
  final isPublic = classifyHost(host) == HostScope.public;
  final l = context.l10n;
  final granted = await showAdaptiveDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog.adaptive(
      title: Text(l.assistantConsentTitle),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(l.assistantConsentBody(host)),
        if (isPublic) ...[
          const SizedBox(height: 12),
          Text(l.assistantConsentPublicWarning,
              style: TextStyle(color: Theme.of(ctx).colorScheme.error, fontWeight: FontWeight.w600)),
        ],
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.commonCancel)),
        TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l.assistantConsentAllow)),
      ],
    ),
  );
  if (granted != true) return false;
  await settings.setConsent(AiProviderKind.mac, true);
  ref.invalidate(aiProvidersProvider);
  return true;
}

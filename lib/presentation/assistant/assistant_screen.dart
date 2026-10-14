import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/ai/ai_orchestrator.dart';
import '../../domain/ai/ai_provider.dart';
import '../../domain/ai/breeding_tools.dart';
import '../../domain/models/enums.dart';
import '../common/labels.dart';
import '../common/widgets.dart';
import '../reminders/reminder_review_sheet.dart';
import '../shell/home_shell.dart';
import 'analysis_tile.dart';
import 'consent.dart';

class _Turn {
  _Turn(this.question);
  final String question;
  AssistantAnswer? answer;
  String? analysisId;
  String? error;
  bool get pending => answer == null && error == null;
}

class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final _turns = <_Turn>[];

  bool get _busy => _turns.isNotEmpty && _turns.last.pending;

  List<ChatMessage> _history() {
    final out = <ChatMessage>[];
    for (final t in _turns.where((t) => t.answer != null)) {
      out
        ..add(ChatMessage.user(t.question))
        ..add(ChatMessage.assistant(t.answer!.rawText));
    }
    return out.length > 6 ? out.sublist(out.length - 6) : out;
  }

  Future<void> _ask(String text) async {
    final q = text.trim();
    if (q.isEmpty || _busy) return;
    FocusManager.instance.primaryFocus?.unfocus(); // show the answer, not the keyboard
    final l = context.l10n;
    if (!await ensureAiConsent(context, ref)) return;
    final history = _history();
    final turn = _Turn(q);
    setState(() {
      _turns.add(turn);
      _input.clear();
    });
    _scrollToEnd();
    try {
      final orchestrator = await ref.read(orchestratorProvider.future);
      final answer = await orchestrator.ask(q,
          history: history, localeName: ref.read(localeProvider).languageCode);
      final id = await ref.read(aiMemoryRepoProvider).saveAnalysis(
            kind: AnalysisKind.chat,
            provider: answer.provider.name,
            model: answer.model,
            question: q,
            response: answer.rawText,
            sections: answer.sections,
            evidence: answer.evidence,
          );
      setState(() {
        turn.answer = answer;
        turn.analysisId = id;
      });
    } on NoAiProviderException catch (e) {
      final reasons =
          e.decision.statuses.map((s) => '• ${l.providerName(s.kind)}: ${l.unavailable(s.code)}').join('\n');
      setState(() => turn.error = '${l.assistantNoProvider}\n$reasons');
    } on ToolLoopExceeded {
      setState(() => turn.error = l.assistantToolLoop);
    } on AiProviderException catch (e) {
      setState(() => turn.error = l.assistantError(e.message));
      ref.invalidate(providerStatusesProvider);
    } catch (e) {
      setState(() => turn.error = l.assistantError('$e'));
    }
    _scrollToEnd();
  }

  void _scrollToEnd() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scroll.hasClients) {
          _scroll.animateTo(_scroll.position.maxScrollExtent,
              duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
        }
      });

  Future<void> _reviewDraft(ReminderDraft d) async {
    final beetle = await ref.read(beetleRepoProvider).beetleByCode(d.beetleCode);
    if (!mounted) return;
    await showDraftReviewSheet(context, ref, draft: d, beetleId: beetle?.id);
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final statuses = ref.watch(providerStatusesProvider);
    return Scaffold(
      appBar: topLevelAppBar(context, l.navAssistant, actions: [
        if (_turns.isNotEmpty)
          IconButton(
              icon: const Icon(Icons.add_comment_outlined),
              tooltip: l.assistantNewChat,
              onPressed: _busy ? null : () => setState(_turns.clear)),
      ], bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Insets.m),
            children: [
              ...?statuses.valueOrNull?.map((s) => Padding(
                    padding: const EdgeInsets.only(right: Insets.s, bottom: Insets.xs),
                    child: ActionChip(
                      avatar: Icon(s.available ? Icons.circle : Icons.circle_outlined,
                          size: 12, color: s.available ? Colors.green : Theme.of(context).colorScheme.outline),
                      label: Text('${l.providerName(s.kind)} · ${s.available ? (s.model ?? '') : l.unavailable(s.code)}'),
                      onPressed: () {
                        ref.invalidate(aiProvidersProvider);
                        if (!s.available && s.code != UnavailableCode.notBundled) context.go('${AppRoutes.settings}/ai');
                      },
                    ),
                  )),
              if (statuses.isLoading) const Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))),
            ],
          ),
        ),
      )),
      body: Column(children: [
        Expanded(
          child: _turns.isEmpty
              ? _EmptyAssistant(onExample: _ask)
              : ListView.builder(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: _scroll,
                  padding: const EdgeInsets.all(Insets.m),
                  itemCount: _turns.length,
                  itemBuilder: (_, i) => _TurnView(turn: _turns[i], onReviewDraft: _reviewDraft),
                ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Insets.m, Insets.s, Insets.s, Insets.s),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _input,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: _ask,
                  decoration: InputDecoration(hintText: l.assistantHint),
                ),
              ),
              IconButton.filled(
                onPressed: _busy ? null : () => _ask(_input.text),
                icon: const Icon(Icons.send),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

class _EmptyAssistant extends StatelessWidget {
  const _EmptyAssistant({required this.onExample});
  final ValueChanged<String> onExample;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return ListView(padding: const EdgeInsets.all(Insets.l), children: [
      EmptyState(icon: Icons.auto_awesome_outlined, title: l.assistantEmptyTitle, body: l.assistantEmptyBody),
      for (final q in [l.assistantExample1, l.assistantExample2, l.assistantExample3])
        Padding(
          padding: const EdgeInsets.only(bottom: Insets.s),
          child: OutlinedButton(onPressed: () => onExample(q), child: Text(q, textAlign: TextAlign.center)),
        ),
      const SizedBox(height: Insets.m),
      Text(l.assistantImageUnavailable, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelSmall),
    ]);
  }
}

class _TurnView extends ConsumerWidget {
  const _TurnView({required this.turn, required this.onReviewDraft});
  final _Turn turn;
  final ValueChanged<ReminderDraft> onReviewDraft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final t = Theme.of(context);
    final a = turn.answer;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(left: 48, bottom: Insets.s),
          padding: const EdgeInsets.all(Insets.m),
          decoration: BoxDecoration(color: t.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(Insets.radius)),
          child: Text(turn.question, style: TextStyle(color: t.colorScheme.onPrimaryContainer)),
        ),
      ),
      Card(
        margin: const EdgeInsets.only(right: 24, bottom: Insets.m),
        child: Padding(
          padding: const EdgeInsets.all(Insets.m),
          child: turn.pending
              ? Row(children: [
                  const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                  const SizedBox(width: Insets.m),
                  Text(l.assistantThinking),
                ])
              : turn.error != null
                  ? Text(turn.error!, style: TextStyle(color: t.colorScheme.error))
                  : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      LabeledSectionsView(sections: a!.sections),
                      const Divider(),
                      Wrap(spacing: Insets.s, runSpacing: Insets.xs, children: [
                        Pill(l.providerName(a.provider), icon: Icons.memory),
                        if (a.isFallback) Pill(l.assistantFallback(l.providerName(a.provider))),
                        if (a.provider == AiProviderKind.mobile) Pill(l.providerExperimental, icon: Icons.science_outlined),
                        Pill(l.assistantEvidence(a.evidence.length), icon: Icons.fact_check_outlined),
                        Pill(l.assistantToolsUsed(a.toolCalls.length), icon: Icons.manage_search),
                      ]),
                      for (final d in a.drafts)
                        Card(
                          margin: const EdgeInsets.only(top: Insets.m),
                          color: t.colorScheme.tertiaryContainer,
                          child: ListTile(
                            leading: const Icon(Icons.alarm_add_outlined),
                            title: Text('${l.assistantReminderDraft}\n${d.beetleCode} · ${d.title}'),
                            subtitle: Text(d.message),
                            trailing: TextButton(onPressed: () => onReviewDraft(d), child: Text(l.assistantReviewDraft)),
                          ),
                        ),
                      if (turn.analysisId != null) _Feedback(analysisId: turn.analysisId!),
                    ]),
        ),
      ),
    ]);
  }
}

class _Feedback extends ConsumerStatefulWidget {
  const _Feedback({required this.analysisId});
  final String analysisId;

  @override
  ConsumerState<_Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends ConsumerState<_Feedback> {
  AnalysisFeedback? _value;

  void _set(AnalysisFeedback f) {
    final next = _value == f ? null : f;
    setState(() => _value = next);
    ref.read(aiMemoryRepoProvider).setFeedback(widget.analysisId, next);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Row(children: [
      IconButton(
        tooltip: l.assistantFeedbackHelpful,
        icon: Icon(_value == AnalysisFeedback.helpful ? Icons.thumb_up : Icons.thumb_up_outlined, size: 18),
        onPressed: () => _set(AnalysisFeedback.helpful),
      ),
      IconButton(
        tooltip: l.assistantFeedbackNotHelpful,
        icon: Icon(_value == AnalysisFeedback.notHelpful ? Icons.thumb_down : Icons.thumb_down_outlined, size: 18),
        onPressed: () => _set(AnalysisFeedback.notHelpful),
      ),
    ]);
  }
}

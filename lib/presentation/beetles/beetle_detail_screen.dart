import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/models.dart';
import '../../domain/ai/ai_orchestrator.dart';
import '../../domain/ai/ai_provider.dart';
import '../../domain/growth/growth_metrics.dart';
import '../../domain/models/enums.dart';
import '../../domain/reminders/reminder_state.dart';
import '../assistant/analysis_tile.dart';
import '../assistant/consent.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/record_widgets.dart';
import '../common/widgets.dart';
import 'growth_roadmap_view.dart';

class BeetleDetailScreen extends ConsumerWidget {
  const BeetleDetailScreen({super.key, required this.beetleId});
  final String beetleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final beetle = ref.watch(beetleProvider(beetleId));
    return Scaffold(
      appBar: AppBar(
        title: Text(beetle.valueOrNull?.code ?? ''),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: l.commonEdit,
              onPressed: () => context.push(AppRoutes.editBeetle(beetleId))),
          PopupMenuButton<BeetleStatus>(
            tooltip: l.detailChangeStatus,
            icon: const Icon(Icons.more_vert),
            onSelected: (s) => ref.read(beetleRepoProvider).setStatus(beetleId, s),
            itemBuilder: (_) => [
              for (final s in BeetleStatus.values) PopupMenuItem(value: s, child: Text(l.beetleStatus(s))),
            ],
          ),
        ],
      ),
      body: AsyncView(
        value: beetle,
        data: (b) => b == null
            ? EmptyState(icon: Icons.search_off, title: l.beetlesEmpty)
            : _DetailBody(beetle: b),
      ),
    );
  }
}

class _DetailBody extends ConsumerStatefulWidget {
  const _DetailBody({required this.beetle});
  final BeetleSummary beetle;

  @override
  ConsumerState<_DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends ConsumerState<_DetailBody> {
  bool _interpreting = false;
  _Tab _tab = _Tab.overview;

  Future<void> _interpret() async {
    final l = context.l10n;
    if (!await ensureAiConsent(context, ref)) return;
    setState(() => _interpreting = true);
    try {
      final router = await ref.read(aiRouterProvider.future);
      final result = await ref.read(proactiveCareProvider).interpretWithAi(widget.beetle.id, router);
      if (!mounted) return;
      showSnack(
          context,
          [
            l.detailAiInterpretDone(result.stored),
            if (result.rejected > 0) l.detailAiInterpretRejected(result.rejected),
          ].join('\n'));
    } on NoAiProviderException catch (e) {
      if (!mounted) return;
      final reasons = e.decision.statuses.map((s) => '${l.providerName(s.kind)}: ${l.unavailable(s.code)}').join('\n');
      showSnack(context, '${l.assistantNoProvider}\n$reasons');
    } on AiProviderException catch (e) {
      if (mounted) showSnack(context, l.assistantError(e.message));
    } finally {
      if (mounted) setState(() => _interpreting = false);
    }
  }

  Future<void> _addPhoto(ImageSource source) async {
    final picker = ImagePicker();
    final x = await picker.pickImage(source: source, imageQuality: 85, maxWidth: 2400);
    if (x == null) return;
    await ref.read(photoStoreProvider).addPhoto(
        source: File(x.path), ownerType: PhotoOwnerType.beetle, ownerId: widget.beetle.id, beetleId: widget.beetle.id);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context);
    final b = widget.beetle;
    final fmt = Fmt.of(context);
    final weights = ref.watch(weightsProvider(b.id)).valueOrNull ?? const [];
    final metrics = GrowthMetrics.compute(
        weights.map((w) => WeightPoint(id: w.id, measuredAt: w.measuredAt, grams: w.weightGrams)));
    final reminders = (ref.watch(beetleRemindersProvider(b.id)).valueOrNull ?? const [])
        .where((r) => ReminderStateMachine.isOpen(r.status))
        .toList();
    final photos = ref.watch(photosProvider(b.id)).valueOrNull ?? const [];
    final analyses = ref.watch(analysesProvider(b.id)).valueOrNull ?? const [];
    final history = ref.watch(timelineProvider((beetleId: b.id, type: null, limit: 200)));
    final docs = ref.watch(documentsDirProvider);

    Widget fact(String label, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(width: 96, child: Text(label, style: t.textTheme.bodySmall?.copyWith(color: t.colorScheme.onSurfaceVariant))),
            Expanded(child: Text(value)),
          ]),
        );

    final latestPhoto = photos.isEmpty ? null : photos.first;
    Widget photoFile(PhotoAttachmentRow p, {BoxFit fit = BoxFit.cover}) => Image.file(
          File('${docs.path}/${p.relativePath}'),
          fit: fit,
          errorBuilder: (_, __, ___) => const ColoredBox(color: Colors.black12, child: Icon(Icons.broken_image_outlined)),
        );

    // ---- compact identity header
    final header = SectionCard(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Insets.radius),
          child: SizedBox(
            width: 72,
            height: 72,
            child: latestPhoto != null
                ? photoFile(latestPhoto)
                : ColoredBox(
                    color: t.colorScheme.secondaryContainer,
                    child: Icon(b.stage == null ? Icons.pest_control : stageIcon(b.stage!),
                        size: 36, color: t.colorScheme.onSecondaryContainer),
                  ),
          ),
        ),
        const SizedBox(width: Insets.m),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(b.code, style: t.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            Text('${b.speciesName}${b.speciesCommonName != null ? ' · ${b.speciesCommonName}' : ''}',
                style: t.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
            const SizedBox(height: Insets.s),
            Wrap(spacing: Insets.xs, runSpacing: Insets.xs, children: [
              Pill(l.stage(b.stage, b.l3Phase), icon: Icons.change_circle_outlined, color: t.colorScheme.primary),
              Pill(l.sex(b.sex)),
              Pill(l.beetleStatus(b.status),
                  color: b.status == BeetleStatus.active ? t.colorScheme.primary : t.colorScheme.outline),
            ]),
            const SizedBox(height: Insets.s),
            Text(
              b.latestWeightGrams == null
                  ? '${l.detailLatestWeight}: –'
                  : '${Fmt.grams(b.latestWeightGrams)} · ${fmt.date(b.latestWeightAt)}',
              style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ]),
        ),
      ]),
    );

    // ---- primary actions
    final actions = Row(children: [
      Expanded(
        child: FilledButton.icon(
          onPressed: () => _chooseRecordType(b.id),
          icon: const Icon(Icons.add),
          label: Text(l.detailAddRecord),
        ),
      ),
      const SizedBox(width: Insets.s),
      FilledButton.tonalIcon(
        onPressed: () => context.push(AppRoutes.newRecord(TimelineType.weight, beetleId: b.id)),
        icon: Icon(timelineIcon(TimelineType.weight), size: 18),
        label: Text(l.timelineType(TimelineType.weight)),
      ),
      const SizedBox(width: Insets.s),
      FilledButton.tonalIcon(
        onPressed: () => context.push(AppRoutes.newRecord(TimelineType.lifeStage, beetleId: b.id)),
        icon: Icon(timelineIcon(TimelineType.lifeStage), size: 18),
        label: Text(l.timelineType(TimelineType.lifeStage)),
      ),
    ]);

    // ---- overview tab
    final overview = <Widget>[
      SectionCard(
        title: l.detailGrowth,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (metrics.count < 2)
            Text(l.detailNeedTwoWeights, style: t.textTheme.bodySmall)
          else
            Wrap(spacing: Insets.l, runSpacing: Insets.s, children: [
              _Metric(l.detailChangeSincePrevious,
                  '${Fmt.signed(metrics.changeSincePrevious, unit: ' g')} (${Fmt.signed(metrics.percentChangeSincePrevious, unit: '%', digits: 1)})',
                  color: metrics.isLosingWeight ? Colors.orange.shade700 : null),
              _Metric(l.detailMaxWeight, Fmt.grams(metrics.max?.grams)),
              _Metric(l.detailAvgWeekly, Fmt.signed(metrics.avgWeeklyChange, unit: ' g')),
            ]),
          const SizedBox(height: Insets.m),
          WeightChart(series: {b.code: [for (final w in weights) (w.measuredAt, w.weightGrams)]}),
          const SizedBox(height: Insets.xs),
          Text(l.detailAvgNote, style: t.textTheme.labelSmall),
        ]),
      ),
      const SizedBox(height: Insets.m),
      OutlinedButton.icon(
        onPressed: _interpreting ? null : _interpret,
        icon: _interpreting
            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
            : const Icon(Icons.auto_awesome),
        label: Text(l.detailAiInterpret),
      ),
      const SizedBox(height: Insets.m),
      SectionCard(
        title: l.detailReminders,
        trailing: IconButton(
            icon: const Icon(Icons.add_alarm),
            tooltip: l.reminderNew,
            onPressed: () => context.push(AppRoutes.newReminder(beetleId: b.id))),
        padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
        child: reminders.isEmpty
            ? Padding(padding: const EdgeInsets.all(Insets.m), child: Text(l.dashboardNoUpcoming))
            : Column(children: [
                for (final r in reminders) ReminderTile(reminder: r, onTap: () => context.go(AppRoutes.reminders)),
              ]),
      ),
      const SizedBox(height: Insets.m),
      _LineageCard(beetle: b),
      const SizedBox(height: Insets.m),
      SectionCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          fact(l.detailContainer, Fmt.liters(b.containerLiters)),
          fact(l.detailSubstrate, [b.substrateType, b.substrateBrand].whereType<String>().join(' · ').ifEmpty('–')),
          fact(l.detailAcquired, fmt.date(b.acquiredAt)),
          if (b.hatchDate != null) fact(l.detailHatch, fmt.date(b.hatchDate)),
          if (b.hatchDate == null && b.estimatedHatchDate != null)
            fact(l.detailHatch, l.detailEstimatedHatch(fmt.date(b.estimatedHatchDate), b.hatchUncertaintyDays ?? 0)),
          if (b.notes != null) ...[const Divider(height: Insets.l), Text(b.notes!)],
        ]),
      ),
      if (analyses.isNotEmpty) ...[
        const SizedBox(height: Insets.m),
        SectionCard(
          title: l.detailAiAnalyses,
          padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
          child: Column(children: [for (final a in analyses.take(10)) AnalysisTile(analysis: a)]),
        ),
      ],
    ];

    // ---- records tab
    final records = <Widget>[
      SectionCard(
        title: l.detailHistory,
        trailing: TextButton.icon(
          onPressed: () => context.push(AppRoutes.pastRecords(b.id)),
          icon: const Icon(Icons.history_edu, size: 18),
          label: Text(l.pastRecordsShortcut),
        ),
        padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
        child: AsyncView(
          value: history,
          onRetry: () => ref.invalidate(timelineProvider((beetleId: b.id, type: null, limit: 200))),
          data: (entries) => entries.isEmpty
              ? Padding(padding: const EdgeInsets.all(Insets.m), child: Text(l.detailNoHistory))
              : Column(children: [
                  for (final e in entries)
                    TimelineTile(
                      entry: e,
                      showBeetle: false,
                      onDelete: () async {
                        if (await confirmDialog(context,
                            title: l.commonDeleteConfirmTitle, message: l.commonDeleteRecordMessage, destructive: true)) {
                          await ref.read(beetleRepoProvider).deleteRecord(e.type, e.id);
                        }
                      },
                    ),
                ]),
        ),
      ),
    ];

    // ---- photos tab: tap to preview, visible ⋯ menu for actions
    final photoTab = <Widget>[
      SectionCard(
        title: l.detailPhotos,
        trailing: PopupMenuButton<ImageSource>(
          icon: const Icon(Icons.add_a_photo_outlined),
          tooltip: l.detailAddPhoto,
          onSelected: _addPhoto,
          itemBuilder: (_) => [
            PopupMenuItem(value: ImageSource.camera, child: Text(l.photoFromCamera)),
            PopupMenuItem(value: ImageSource.gallery, child: Text(l.photoFromGallery)),
          ],
        ),
        child: photos.isEmpty
            ? Text(l.detailNoPhotos)
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    for (final p in photos)
                      Stack(fit: StackFit.expand, children: [
                        Semantics(
                          button: true,
                          label: fmt.dateTime(p.takenAt),
                          child: GestureDetector(
                            onTap: () => _previewPhoto(photoFile(p, fit: BoxFit.contain), fmt.dateTime(p.takenAt)),
                            child: ClipRRect(borderRadius: BorderRadius.circular(8), child: photoFile(p)),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: Material(
                            color: Colors.black45,
                            shape: const CircleBorder(),
                            child: PopupMenuButton<String>(
                              tooltip: l.photoActions,
                              iconColor: Colors.white,
                              iconSize: 18,
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.more_horiz),
                              onSelected: (_) async {
                                if (await confirmDialog(context,
                                    title: l.photoDelete, message: fmt.dateTime(p.takenAt), destructive: true)) {
                                  await ref.read(photoStoreProvider).deletePhoto(p.id);
                                }
                              },
                              itemBuilder: (_) => [PopupMenuItem(value: 'delete', child: Text(l.photoDelete))],
                            ),
                          ),
                        ),
                      ]),
                  ],
                ),
                const SizedBox(height: Insets.s),
                Text(l.assistantImageUnavailable, style: t.textTheme.labelSmall),
              ]),
      ),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(Insets.m, Insets.s, Insets.m, Insets.xl),
      children: [
        header,
        const SizedBox(height: Insets.m),
        SectionCard(
          title: l.roadmapTitle,
          child: AsyncView(
            value: ref.watch(roadmapProvider(b.id)),
            onRetry: () => ref
              ..invalidate(stageEventsProvider(b.id))
              ..invalidate(weightsProvider(b.id)),
            data: (r) => GrowthRoadmapView(roadmap: r),
          ),
        ),
        const SizedBox(height: Insets.m),
        actions,
        const SizedBox(height: Insets.l),
        SegmentedButton<_Tab>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(value: _Tab.overview, label: Text(l.detailTabOverview)),
            ButtonSegment(value: _Tab.records, label: Text(l.detailTabRecords)),
            ButtonSegment(
                value: _Tab.photos, label: Text(photos.isEmpty ? l.detailTabPhotos : '${l.detailTabPhotos} ${photos.length}')),
          ],
          selected: {_tab},
          onSelectionChanged: (v) => setState(() => _tab = v.first),
        ),
        const SizedBox(height: Insets.m),
        ...switch (_tab) {
          _Tab.overview => overview,
          _Tab.records => records,
          _Tab.photos => photoTab,
        },
      ],
    );
  }

  Future<void> _chooseRecordType(String beetleId) async {
    final l = context.l10n;
    final choice = await showModalBottomSheet<Object>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(l.chooseRecordType, style: Theme.of(ctx).textTheme.titleMedium),
          const SizedBox(height: Insets.s),
          for (final type in TimelineType.values.where((t) => t != TimelineType.temperature))
            ListTile(
                leading: Icon(timelineIcon(type)), title: Text(l.timelineType(type)), onTap: () => Navigator.pop(ctx, type)),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history_edu),
            title: Text(l.pastRecordsTitle),
            onTap: () => Navigator.pop(ctx, 'past'),
          ),
        ]),
      ),
    );
    if (!mounted || choice == null) return;
    await context.push(choice is TimelineType
        ? AppRoutes.newRecord(choice, beetleId: beetleId)
        : AppRoutes.pastRecords(beetleId));
  }

  void _previewPhoto(Widget image, String caption) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog.fullscreen(
        backgroundColor: Colors.black,
        child: Stack(children: [
          Positioned.fill(child: InteractiveViewer(maxScale: 5, child: Center(child: image))),
          SafeArea(
            child: Row(children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                tooltip: MaterialLocalizations.of(ctx).closeButtonTooltip,
                onPressed: () => Navigator.pop(ctx),
              ),
              Expanded(child: Text(caption, style: const TextStyle(color: Colors.white))),
            ]),
          ),
        ]),
      ),
    );
  }
}

enum _Tab { overview, records, photos }

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value, {this.color});
  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: t.textTheme.labelSmall?.copyWith(color: t.colorScheme.onSurfaceVariant)),
      Text(value, style: t.textTheme.titleMedium?.copyWith(color: color, fontWeight: FontWeight.w600)),
    ]);
  }
}

extension on String {
  String ifEmpty(String fallback) => isEmpty ? fallback : this;
}

/// Sire and dam (tappable when they are in the collection) and offspring.
class _LineageCard extends ConsumerWidget {
  const _LineageCard({required this.beetle});
  final BeetleSummary beetle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final b = beetle;
    final offspring = ref.watch(offspringProvider(b.id)).valueOrNull ?? const <BeetleSummary>[];

    Widget parent(IconData icon, String label, String? id, String? code, String? note) => ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: Icon(icon),
          title: Text(label),
          subtitle: Text(code ?? note ?? l.parentUnknown),
          trailing: id != null ? const Icon(Icons.chevron_right) : null,
          onTap: id != null ? () => context.push(AppRoutes.beetle(id)) : null,
        );

    return SectionCard(
      title: l.parentsSection,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        parent(Icons.male, l.fieldSire, b.sireId, b.sireCode, b.sireNote),
        parent(Icons.female, l.fieldDam, b.damId, b.damCode, b.damNote),
        if (offspring.isNotEmpty) ...[
          const Divider(height: Insets.l),
          Text(l.offspringSection(offspring.length), style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: Insets.s),
          Wrap(spacing: Insets.s, runSpacing: Insets.s, children: [
            for (final c in offspring)
              ActionChip(label: Text(c.code), onPressed: () => context.push(AppRoutes.beetle(c.id))),
          ]),
        ],
      ]),
    );
  }
}

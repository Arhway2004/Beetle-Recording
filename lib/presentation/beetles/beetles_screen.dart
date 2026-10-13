import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/models.dart';
import '../../domain/models/enums.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/record_widgets.dart';
import '../common/widgets.dart';
import '../shell/home_shell.dart';

class BeetlesScreen extends ConsumerStatefulWidget {
  const BeetlesScreen({super.key});

  @override
  ConsumerState<BeetlesScreen> createState() => _BeetlesScreenState();
}

class _BeetlesScreenState extends ConsumerState<BeetlesScreen> {
  String? _speciesId;
  Sex? _sex;
  LifeStage? _stage;
  BeetleStatus? _status = BeetleStatus.active;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final species = ref.watch(speciesProvider).valueOrNull ?? const [];
    final filter = BeetleFilter(speciesId: _speciesId, sex: _sex, stage: _stage, status: _status, query: _query);
    return Scaffold(
      appBar: topLevelAppBar(context, l.navBeetles),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.newBeetle),
        tooltip: l.dashboardAddBeetle,
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Insets.m, Insets.s, Insets.m, 0),
          child: TextField(
            decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: l.beetlesSearchHint),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Insets.m, vertical: Insets.s),
            children: [
              _FilterMenu<String>(
                label: l.filterSpecies,
                value: _speciesId,
                options: {for (final s in species) s.id: s.code},
                onChanged: (v) => setState(() => _speciesId = v),
              ),
              _FilterMenu<Sex>(
                label: l.filterSex,
                value: _sex,
                options: {for (final s in Sex.values) s: l.sex(s)},
                onChanged: (v) => setState(() => _sex = v),
              ),
              _FilterMenu<LifeStage>(
                label: l.filterStage,
                value: _stage,
                options: {for (final s in LifeStage.values) s: l.stage(s)},
                onChanged: (v) => setState(() => _stage = v),
              ),
              _FilterMenu<BeetleStatus>(
                label: l.filterStatus,
                value: _status,
                options: {for (final s in BeetleStatus.values) s: l.beetleStatus(s)},
                onChanged: (v) => setState(() => _status = v),
              ),
            ],
          ),
        ),
        Expanded(
          child: AsyncView(
            value: ref.watch(beetlesProvider),
            onRetry: () => ref.invalidate(beetlesProvider),
            data: (all) {
              if (all.isEmpty) {
                return EmptyState(
                  icon: Icons.bug_report_outlined,
                  title: l.dashboardEmptyTitle,
                  body: l.dashboardEmptyBody,
                  action: FilledButton(
                      onPressed: () => context.push(AppRoutes.newBeetle), child: Text(l.dashboardAddBeetle)),
                );
              }
              final list = all.where(filter.matches).toList();
              if (list.isEmpty) return EmptyState(icon: Icons.filter_alt_off_outlined, title: l.beetlesEmpty);
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(Insets.m, 0, Insets.m, 96),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: Insets.s),
                itemBuilder: (_, i) => BeetleCard(beetle: list[i]),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class _FilterMenu<T> extends StatelessWidget {
  const _FilterMenu({required this.label, required this.value, required this.options, required this.onChanged});
  final String label;
  final T? value;
  final Map<T, String> options;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Insets.s),
      child: PopupMenuButton<Object>(
        onSelected: (v) => onChanged(v == _all ? null : v as T),
        itemBuilder: (_) => [
          PopupMenuItem(value: _all, child: Text(context.l10n.commonAll)),
          for (final e in options.entries) PopupMenuItem(value: e.key, child: Text(e.value)),
        ],
        child: Chip(
          avatar: Icon(value == null ? Icons.filter_list : Icons.check, size: 16),
          label: Text(value == null ? label : '$label: ${options[value]}'),
        ),
      ),
    );
  }

  static const _all = Object();
}

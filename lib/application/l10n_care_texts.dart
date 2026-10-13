import '../domain/proactive/care_rules.dart';
import '../l10n/gen/app_localizations.dart';

String _num(double v) => v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 1);

/// Rule-engine wording backed by the app's localizations.
class L10nCareTexts implements CareTexts {
  L10nCareTexts(this.l);
  final AppLocalizations l;

  @override
  CareText weightChange(
      {required String code, required double percent, required double fromG, required double toG}) {
    final pct = '${percent >= 0 ? '+' : ''}${percent.toStringAsFixed(1)}';
    return CareText(
      title: l.ruleWeightChangeTitle(code, pct),
      message: l.ruleWeightChangeMessage(code),
      reason: l.ruleWeightChangeReason(_num(fromG), _num(toG), pct),
      recommendation: percent < 0 ? l.ruleWeightLossRecommendation : l.ruleWeightGainRecommendation,
    );
  }

  @override
  CareText measurementOverdue({required String code, required int? daysSince}) => CareText(
        title: l.ruleOverdueTitle(code),
        message: l.ruleOverdueMessage,
        reason: daysSince == null ? l.ruleOverdueReasonNever : l.ruleOverdueReasonDays(daysSince),
        recommendation: l.ruleOverdueRecommendation,
      );

  @override
  CareText substrateInspection({required String code, required int daysSinceChange}) => CareText(
        title: l.ruleSubstrateTitle(code),
        message: l.ruleSubstrateMessage,
        reason: l.ruleSubstrateReason(daysSinceChange),
        recommendation: l.ruleSubstrateRecommendation,
      );

  @override
  CareText temperatureOutOfRange(
      {required String sensor, required double celsius, double? minC, double? maxC}) {
    final c = celsius.toStringAsFixed(1);
    final range = '${minC?.toStringAsFixed(1) ?? '–'} ~ ${maxC?.toStringAsFixed(1) ?? '–'} °C';
    return CareText(
      title: _clip(l.ruleTempTitle(sensor), 80),
      message: l.ruleTempMessage(sensor, c),
      reason: l.ruleTempReason(c, range),
      recommendation: l.ruleTempRecommendation,
    );
  }

  @override
  CareText possiblePrepupa({required String code}) => CareText(
        title: l.rulePrepupaTitle(code),
        message: l.rulePrepupaMessage,
        reason: l.rulePrepupaReason,
        recommendation: l.rulePrepupaRecommendation,
      );

  @override
  CareText emergenceWindow({required String code, required int minDays, required int maxDays}) =>
      CareText(
        title: l.ruleEmergenceTitle(code),
        message: l.ruleEmergenceMessage(minDays, maxDays),
        reason: l.ruleEmergenceReason(minDays, maxDays),
        recommendation: l.ruleEmergenceRecommendation,
      );

  static String _clip(String s, int max) {
    final r = s.runes.toList();
    return r.length <= max ? s : String.fromCharCodes(r.take(max));
  }
}

import 'package:flutter/widgets.dart';

import '../../data/repositories/models.dart';
import '../../domain/ai/ai_provider.dart';
import '../../domain/ai/labeled_answer.dart';
import '../../domain/models/enums.dart';
import '../../l10n/gen/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension EnumLabels on AppLocalizations {
  String parentError(ParentError e) => switch (e) {
        ParentError.self => parentErrorSelf,
        ParentError.sameParent => parentErrorSame,
        ParentError.notFound => parentErrorNotFound,
        ParentError.wrongSex => parentErrorWrongSex,
        ParentError.cycle => parentErrorCycle,
        ParentError.sexConflictsWithOffspring => parentErrorSexConflict,
      };

  String sex(Sex s) => switch (s) {
        Sex.male => sexMale,
        Sex.female => sexFemale,
        Sex.unknown => sexUnknown,
      };

  String stage(LifeStage? s, [L3Phase? phase]) {
    final base = switch (s) {
      null => stageUnset,
      LifeStage.l1 => stageL1,
      LifeStage.l2 => stageL2,
      LifeStage.l3 => stageL3,
      LifeStage.prepupa => stagePrepupa,
      LifeStage.pupa => stagePupa,
      LifeStage.adult => stageAdult,
    };
    return (s == LifeStage.l3 && phase != null) ? '$base · ${l3Phase(phase)}' : base;
  }

  String l3Phase(L3Phase p) => switch (p) {
        L3Phase.early => l3Early,
        L3Phase.middle => l3Middle,
        L3Phase.late => l3Late,
      };

  String beetleStatus(BeetleStatus s) => switch (s) {
        BeetleStatus.active => statusActive,
        BeetleStatus.deceased => statusDeceased,
        BeetleStatus.transferred => statusTransferred,
        BeetleStatus.archived => statusArchived,
      };

  String observation(ObservationCategory c) => switch (c) {
        ObservationCategory.general => obsGeneral,
        ObservationCategory.colorChange => obsColorChange,
        ObservationCategory.activity => obsActivity,
        ObservationCategory.feeding => obsFeeding,
        ObservationCategory.pupalChamber => obsPupalChamber,
        ObservationCategory.molt => obsMolt,
        ObservationCategory.health => obsHealth,
        ObservationCategory.behavior => obsBehavior,
      };

  String reminderStatus(ReminderStatus s) => switch (s) {
        ReminderStatus.suggested => reminderStatusSuggested,
        ReminderStatus.confirmed => reminderStatusConfirmed,
        ReminderStatus.scheduled => reminderStatusScheduled,
        ReminderStatus.completed => reminderStatusCompleted,
        ReminderStatus.cancelled => reminderStatusCancelled,
        ReminderStatus.expired => reminderStatusExpired,
      };

  String severity(Severity s) => switch (s) {
        Severity.info => severityInfo,
        Severity.observation => severityObservation,
        Severity.warning => severityWarning,
        Severity.alert => severityAlert,
      };

  String confidence(Confidence c) => confidenceLabel(switch (c) {
        Confidence.low => confidenceLow,
        Confidence.medium => confidenceMedium,
        Confidence.high => confidenceHigh,
      });

  String basis(SuggestionBasis? b) => switch (b) {
        SuggestionBasis.measured => basisMeasured,
        SuggestionBasis.calculated => basisCalculated,
        SuggestionBasis.aiInference || null => basisAiInference,
      };

  String source(ReminderSource s) => switch (s) {
        ReminderSource.user => sourceUser,
        ReminderSource.rule => sourceRule,
        ReminderSource.ai => sourceAi,
      };

  String eventType(String wire) => switch (CareEventType.fromWire(wire)) {
        CareEventType.significantWeightChange => eventSignificantWeightChange,
        CareEventType.weightLoss => eventWeightLoss,
        CareEventType.measurementOverdue => eventMeasurementOverdue,
        CareEventType.substrateInspection => eventSubstrateInspection,
        CareEventType.containerReview => eventContainerReview,
        CareEventType.temperatureOutOfRange => eventTemperatureOutOfRange,
        CareEventType.possiblePrepupa => eventPossiblePrepupa,
        CareEventType.possiblePupation => eventPossiblePupation,
        CareEventType.expectedEmergenceWindow => eventExpectedEmergenceWindow,
        CareEventType.outdatedReminder => eventOutdatedReminder,
        CareEventType.generalObservation => eventGeneralObservation,
        CareEventType.custom || null => eventCustom,
      };

  String timelineType(TimelineType t) => switch (t) {
        TimelineType.weight => recordWeight,
        TimelineType.observation => recordObservation,
        TimelineType.substrate => recordSubstrate,
        TimelineType.container => recordContainer,
        TimelineType.lifeStage => recordLifeStage,
        TimelineType.temperature => recordTemperature,
      };

  String claim(ClaimKind k) => switch (k) {
        ClaimKind.verified => claimVerified,
        ClaimKind.calculated => claimCalculated,
        ClaimKind.observation => claimObservation,
        ClaimKind.hypothesis => claimHypothesis,
        ClaimKind.recommendation => claimRecommendation,
        ClaimKind.unknown => claimUnknown,
        ClaimKind.unclassified => claimUnclassified,
      };

  String providerName(AiProviderKind k) =>
      k == AiProviderKind.mac ? assistantProviderMac : assistantProviderMobile;

  String unavailable(UnavailableCode? c) => switch (c) {
        UnavailableCode.disabled => unavailableDisabled,
        UnavailableCode.notConfigured => unavailableNotConfigured,
        UnavailableCode.consentRequired => unavailableConsent,
        UnavailableCode.unreachable || null => unavailableUnreachable,
        UnavailableCode.unauthorized => unavailableUnauthorized,
        UnavailableCode.insecureTransport => unavailableInsecure,
        UnavailableCode.modelMissing => unavailableModelMissing,
        UnavailableCode.notBundled => unavailableNotBundled,
      };

  String outcome(PredictionOutcome o) => switch (o) {
        PredictionOutcome.notApplicable => outcomeNotApplicable,
        PredictionOutcome.pending => outcomePending,
        PredictionOutcome.correct => outcomeCorrect,
        PredictionOutcome.incorrect => outcomeIncorrect,
      };
}

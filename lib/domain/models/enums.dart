/// Domain enumerations shared by the data, domain and presentation layers.
///
/// Enum values are persisted by [Enum.name] (Drift `textEnum`), so renaming a value
/// is a breaking schema change and requires a migration.
library;

enum Sex { male, female, unknown }

/// Developmental stage. Stages are only ever set from explicit user records
/// ([LifeStageEvent]); they are never inferred from weight.
enum LifeStage { l1, l2, l3, prepupa, pupa, adult }

/// Optional observational label within L3. Purely descriptive.
enum L3Phase { early, middle, late }

enum BeetleStatus { active, deceased, transferred, archived }

enum ObservationCategory {
  general,
  colorChange,
  activity,
  feeding,
  pupalChamber,
  molt,
  health,
  behavior,
}

enum SensorKind { manual, bluetooth, wifi }

enum TemperatureSource { manual, sensor }

enum ReminderStatus { suggested, confirmed, scheduled, completed, cancelled, expired }

enum ReminderSource { user, rule, ai }

/// What a suggestion is grounded in; see `ai-suggestion.v1.schema.json`.
enum SuggestionBasis {
  measured('measured'),
  calculated('calculated'),
  aiInference('ai_inference');

  const SuggestionBasis(this.wire);
  final String wire;

  static SuggestionBasis? fromWire(String? value) {
    for (final b in values) {
      if (b.wire == value) return b;
    }
    return null;
  }
}

enum Severity { info, observation, warning, alert }

enum Confidence { low, medium, high }

/// Care event types. Wire names match the JSON schema enum exactly.
enum CareEventType {
  significantWeightChange('significant_weight_change'),
  weightLoss('weight_loss'),
  measurementOverdue('measurement_overdue'),
  substrateInspection('substrate_inspection'),
  containerReview('container_review'),
  temperatureOutOfRange('temperature_out_of_range'),
  possiblePrepupa('possible_prepupa'),
  possiblePupation('possible_pupation'),
  expectedEmergenceWindow('expected_emergence_window'),
  outdatedReminder('outdated_reminder'),
  generalObservation('general_observation'),
  custom('custom');

  const CareEventType(this.wire);
  final String wire;

  /// `custom` is app-internal (user-created reminders) and not part of the AI schema.
  static List<CareEventType> get aiSchemaValues =>
      values.where((e) => e != CareEventType.custom).toList();

  static CareEventType? fromWire(String? value) {
    for (final e in values) {
      if (e.wire == value) return e;
    }
    return null;
  }
}

enum PhotoOwnerType { beetle, weight, observation, substrate, container, lifeStage }

enum AnalysisKind { chat, proactive, vision }

enum AnalysisFeedback { helpful, notHelpful }

enum PredictionOutcome { notApplicable, pending, correct, incorrect }

enum AiProviderKind { mac, mobile }

enum AiRoutingPreference { auto, mac, mobile }

enum RecordType {
  beetle,
  weight,
  observation,
  temperature,
  substrate,
  container,
  lifeStage,
  photo,
  reminder,
}

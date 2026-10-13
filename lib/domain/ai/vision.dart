/// Multimodal (image) analysis interface, kept separate from text providers:
/// a text-only model must never be presented as able to see photos.
library;

enum VisionTask { describeColor, physicalFeatures, compareOverTime, suggestObservations }

class VisionStatus {
  const VisionStatus({required this.available, required this.validated, this.reason, this.model});
  final bool available;

  /// True only after the model has been evaluated on real beetle photos.
  final bool validated;
  final String? reason;
  final String? model;
}

class VisionObservation {
  const VisionObservation({required this.description, required this.photoIds});
  final String description;
  final List<String> photoIds;
}

abstract class VisionProvider {
  Future<VisionStatus> status();

  /// Observational output only. Implementations must not diagnose prepupation
  /// or health problems from a single photograph.
  Future<List<VisionObservation>> analyze({
    required VisionTask task,
    required List<String> photoPaths,
    required List<String> photoIds,
  });
}

/// The only vision provider in this release: explicitly unavailable.
class UnavailableVisionProvider implements VisionProvider {
  const UnavailableVisionProvider();

  @override
  Future<VisionStatus> status() async => const VisionStatus(
        available: false,
        validated: false,
        reason: 'No validated multimodal model is integrated yet.',
      );

  @override
  Future<List<VisionObservation>> analyze({
    required VisionTask task,
    required List<String> photoPaths,
    required List<String> photoIds,
  }) =>
      throw UnsupportedError('Image analysis is unavailable in this build.');
}

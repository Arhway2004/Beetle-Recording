import '../models/enums.dart';
import 'ai_provider.dart';

sealed class RouteDecision {
  const RouteDecision();
}

class RoutedTo extends RouteDecision {
  const RoutedTo(this.provider, this.status, {this.isFallback = false});
  final AiProvider provider;
  final ProviderStatus status;
  final bool isFallback;
}

/// No provider can serve the request. The UI must show [statuses] and must not
/// fabricate an answer.
class NoProviderAvailable extends RouteDecision {
  const NoProviderAvailable(this.required, this.statuses);
  final Set<AiCapability> required;
  final List<ProviderStatus> statuses;
}

/// Chooses the language-model provider. Calculations never go through here:
/// they are always done by the deterministic engine (tools, rule engine).
///
/// * `mac`: only the Mac gateway.
/// * `mobile`: only on-device.
/// * `auto`: Mac first; fall back to mobile only if it supports every required
///   capability.
class AiRouter {
  AiRouter({required this.providers, required this.preference});

  final Map<AiProviderKind, AiProvider> providers;
  final AiRoutingPreference preference;

  List<AiProviderKind> get _order => switch (preference) {
        AiRoutingPreference.mac => [AiProviderKind.mac],
        AiRoutingPreference.mobile => [AiProviderKind.mobile],
        AiRoutingPreference.auto => [AiProviderKind.mac, AiProviderKind.mobile],
      };

  Future<RouteDecision> select(Set<AiCapability> required) async {
    final statuses = <ProviderStatus>[];
    for (final (i, kind) in _order.indexed) {
      final provider = providers[kind];
      if (provider == null) continue;
      final status = await provider.status();
      statuses.add(status);
      if (status.supports(required)) {
        return RoutedTo(provider, status, isFallback: i > 0);
      }
    }
    return NoProviderAvailable(required, statuses);
  }
}

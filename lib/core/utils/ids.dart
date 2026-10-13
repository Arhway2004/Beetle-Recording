import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Stable, globally unique record ID (UUID v4). Used as the primary key on the
/// device and, in a future sync, on the server.
String newId() => _uuid.v4();

/// Current instant in UTC. All timestamps are persisted in UTC.
DateTime nowUtc() => DateTime.now().toUtc();

/// Beetle codes look like `DHH-001`: species code, dash, zero-padded sequence.
final RegExp beetleCodePattern = RegExp(r'^[A-Z][A-Z0-9]{1,7}-[0-9]{3,6}$');
final RegExp speciesCodePattern = RegExp(r'^[A-Z][A-Z0-9]{1,7}$');

String formatBeetleCode(String speciesCode, int sequence) =>
    '$speciesCode-${sequence.toString().padLeft(3, '0')}';

/// Parses the numeric sequence of a beetle code with the given prefix, or null.
int? parseBeetleSequence(String code, String speciesCode) {
  final prefix = '$speciesCode-';
  if (!code.startsWith(prefix)) return null;
  return int.tryParse(code.substring(prefix.length));
}

/// Deterministic positive 31-bit notification ID derived from a reminder ID
/// (FNV-1a). Stable across app restarts so OS notifications can be reconciled.
int notificationIdFor(String reminderId) {
  var hash = 0x811c9dc5;
  for (final unit in reminderId.codeUnits) {
    hash ^= unit;
    hash = (hash * 0x01000193) & 0xFFFFFFFF;
  }
  return hash & 0x7FFFFFFF;
}

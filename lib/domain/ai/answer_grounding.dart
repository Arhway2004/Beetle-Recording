import 'dart:convert';

/// Checks that measured or calculated quantities in an AI answer actually
/// came from the records the tools returned. Small models in particular
/// sometimes "fill in" a plausible weight after a failed lookup; such numbers
/// are flagged instead of being shown as facts.
class AnswerGrounding {
  AnswerGrounding(Iterable<String> toolResultsJson, {String question = ''}) {
    for (final j in toolResultsJson) {
      try {
        _collect(jsonDecode(j));
      } on FormatException {
        _numbersInText(j);
      }
    }
    _numbersInText(question);
  }

  final _known = <double>{};

  /// A number followed by a unit: weights, percentages, temperatures,
  /// volumes, durations. Bare numbers (dates, counts, codes) are not checked.
  static final _quantity = RegExp(
      r'([-+]?\d+(?:[.,]\d+)?)\s*(?:grams?|g|克|percent|%|％|°C|℃|degrees?|°|liters?|litres?|L|升|ml|毫升|天|days?|周|weeks?|个月|months?)(?![A-Za-z])');
  static final _number = RegExp(r'[-+]?\d+(?:\.\d+)?');

  void _collect(Object? v) {
    switch (v) {
      case final num n:
        _known.add(n.toDouble());
      case final String s:
        _numbersInText(s);
      case final List<Object?> l:
        l.forEach(_collect);
      case final Map<Object?, Object?> m:
        m.values.forEach(_collect);
    }
  }

  void _numbersInText(String s) {
    for (final m in _number.allMatches(s)) {
      final v = double.tryParse(m.group(0)!);
      if (v != null) _known.add(v);
    }
  }

  /// The quantities in [text] that match no value from the records, at the
  /// precision the answer states them (0.18 matches 0.183; 0.12 does not).
  List<String> unsupported(String text) => [
        for (final m in _quantity.allMatches(text))
          if (!_isKnown(m.group(1)!.replaceAll(',', '.'))) m.group(0)!.trim(),
      ];

  bool _isKnown(String claim) {
    final x = double.tryParse(claim);
    if (x == null) return true;
    final decimals = claim.contains('.') ? claim.split('.').last.length : 0;
    final scale = _pow10(decimals);
    for (final v in _known) {
      for (final candidate in [v, -v]) {
        if ((candidate * scale).round() == (x * scale).round()) return true;
      }
    }
    return false;
  }

  static double _pow10(int n) {
    var r = 1.0;
    for (var i = 0; i < n; i++) {
      r *= 10;
    }
    return r;
  }
}

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Locale-aware formatting. Values are stored in UTC and shown in local time.
class Fmt {
  Fmt(this.locale);
  factory Fmt.of(BuildContext context) => Fmt(Localizations.localeOf(context).toLanguageTag());

  final String locale;

  String date(DateTime? d) => d == null ? '–' : DateFormat.yMMMd(locale).format(d.toLocal());
  String dateTime(DateTime? d) =>
      d == null ? '–' : DateFormat.yMMMd(locale).add_Hm().format(d.toLocal());
  String shortDate(DateTime d) => DateFormat.Md(locale).format(d.toLocal());

  static String number(double? v, {int digits = 1}) {
    if (v == null) return '–';
    final fixed = v.toStringAsFixed(digits);
    return fixed.contains('.') ? fixed.replaceFirst(RegExp(r'\.?0+$'), '') : fixed;
  }

  static String grams(double? v) => v == null ? '–' : '${number(v, digits: 2)} g';
  static String liters(double? v) => v == null ? '–' : '${number(v, digits: 2)} L';
  static String celsius(double? v) => v == null ? '–' : '${number(v)}°C';
  static String signed(double? v, {String unit = '', int digits = 2}) =>
      v == null ? '–' : '${v > 0 ? '+' : ''}${number(v, digits: digits)}$unit';
}

/// Parses user numeric input, accepting a comma as decimal separator.
double? parseDecimal(String? s) {
  if (s == null || s.trim().isEmpty) return null;
  return double.tryParse(s.trim().replaceAll(',', '.'));
}

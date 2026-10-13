import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import 'labels.dart';

/// Date (and optionally time) picker field.
class DateTimeField extends StatelessWidget {
  const DateTimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.withTime = true,
    this.allowClear = false,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final bool withTime;
  final bool allowClear;
  final DateTime? firstDate;
  final DateTime? lastDate;

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final initial = value?.toLocal() ?? now;
    final d = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(now.year + 5),
    );
    if (d == null || !context.mounted) return;
    var result = DateTime(d.year, d.month, d.day, initial.hour, initial.minute);
    if (withTime) {
      final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initial));
      if (t != null) result = DateTime(d.year, d.month, d.day, t.hour, t.minute);
    }
    onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    final fmt = Fmt.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _pick(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: allowClear && value != null
              ? IconButton(icon: const Icon(Icons.clear), onPressed: () => onChanged(null))
              : const Icon(Icons.calendar_today_outlined),
        ),
        child: Text(value == null ? context.l10n.commonNotSet : (withTime ? fmt.dateTime(value) : fmt.date(value))),
      ),
    );
  }
}

/// Numeric text field with validation (decimal, optional positive constraint).
class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    required this.controller,
    required this.label,
    this.required = false,
    this.positive = true,
    this.helper,
    this.min,
    this.max,
  });

  final TextEditingController controller;
  final String label;
  final bool required;
  final bool positive;
  final String? helper;
  final double? min;
  final double? max;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, helperText: helper, helperMaxLines: 3),
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return required ? l.commonRequired : null;
        final n = parseDecimal(v);
        if (n == null || !n.isFinite) return l.commonInvalidNumber;
        if (positive && n <= 0) return l.commonMustBePositive;
        if ((min != null && n < min!) || (max != null && n > max!)) return l.commonInvalidNumber;
        return null;
      },
    );
  }
}

/// Picks photos from camera or gallery. Files are copied into app storage on save.
class PhotoPickerField extends StatefulWidget {
  const PhotoPickerField({super.key, required this.onChanged});
  final ValueChanged<List<File>> onChanged;

  @override
  State<PhotoPickerField> createState() => _PhotoPickerFieldState();
}

class _PhotoPickerFieldState extends State<PhotoPickerField> {
  final _files = <File>[];
  final _picker = ImagePicker();

  Future<void> _add(ImageSource source) async {
    try {
      final picked = source == ImageSource.camera
          ? [if (await _picker.pickImage(source: source, imageQuality: 85, maxWidth: 2400) case final x?) x]
          : await _picker.pickMultiImage(imageQuality: 85, maxWidth: 2400);
      if (picked.isEmpty) return;
      setState(() => _files.addAll(picked.map((x) => File(x.path))));
      widget.onChanged(List.unmodifiable(_files));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Wrap(spacing: Insets.s, children: [
        OutlinedButton.icon(
            onPressed: () => _add(ImageSource.camera),
            icon: const Icon(Icons.photo_camera_outlined),
            label: Text(l.photoFromCamera)),
        OutlinedButton.icon(
            onPressed: () => _add(ImageSource.gallery),
            icon: const Icon(Icons.photo_library_outlined),
            label: Text(l.photoFromGallery)),
      ]),
      if (_files.isNotEmpty) ...[
        const SizedBox(height: Insets.s),
        Text(l.photosSelected(_files.length), style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: Insets.s),
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _files.length,
            separatorBuilder: (_, __) => const SizedBox(width: Insets.s),
            itemBuilder: (_, i) => Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(_files[i], width: 72, height: 72, fit: BoxFit.cover),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () {
                    setState(() => _files.removeAt(i));
                    widget.onChanged(List.unmodifiable(_files));
                  },
                  child: const CircleAvatar(radius: 10, child: Icon(Icons.close, size: 12)),
                ),
              ),
            ]),
          ),
        ),
      ],
    ]);
  }
}

/// Generic dropdown for enums / ids with labels.
class LabeledDropdown<T> extends StatelessWidget {
  const LabeledDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final String label;
  final T? value;
  final Map<T, String> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
        value: items.containsKey(value) ? value : null,
        isExpanded: true,
        decoration: InputDecoration(labelText: label),
        items: [
          for (final e in items.entries) DropdownMenuItem(value: e.key, child: Text(e.value, overflow: TextOverflow.ellipsis)),
        ],
        onChanged: onChanged,
        validator: validator,
      );
}

const formGap = SizedBox(height: Insets.m);

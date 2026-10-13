// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SpeciesTable extends Species with TableInfo<$SpeciesTable, SpeciesRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 8,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _scientificNameMeta = const VerificationMeta(
    'scientificName',
  );
  @override
  late final GeneratedColumn<String> scientificName = GeneratedColumn<String>(
    'scientific_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commonNameMeta = const VerificationMeta(
    'commonName',
  );
  @override
  late final GeneratedColumn<String> commonName = GeneratedColumn<String>(
    'common_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isBuiltinMeta = const VerificationMeta(
    'isBuiltin',
  );
  @override
  late final GeneratedColumn<bool> isBuiltin = GeneratedColumn<bool>(
    'is_builtin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_builtin" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _expectedPupaDaysMinMeta =
      const VerificationMeta('expectedPupaDaysMin');
  @override
  late final GeneratedColumn<int> expectedPupaDaysMin = GeneratedColumn<int>(
    'expected_pupa_days_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedPupaDaysMaxMeta =
      const VerificationMeta('expectedPupaDaysMax');
  @override
  late final GeneratedColumn<int> expectedPupaDaysMax = GeneratedColumn<int>(
    'expected_pupa_days_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    code,
    scientificName,
    commonName,
    isBuiltin,
    expectedPupaDaysMin,
    expectedPupaDaysMax,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'species';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeciesRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('scientific_name')) {
      context.handle(
        _scientificNameMeta,
        scientificName.isAcceptableOrUnknown(
          data['scientific_name']!,
          _scientificNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scientificNameMeta);
    }
    if (data.containsKey('common_name')) {
      context.handle(
        _commonNameMeta,
        commonName.isAcceptableOrUnknown(data['common_name']!, _commonNameMeta),
      );
    }
    if (data.containsKey('is_builtin')) {
      context.handle(
        _isBuiltinMeta,
        isBuiltin.isAcceptableOrUnknown(data['is_builtin']!, _isBuiltinMeta),
      );
    }
    if (data.containsKey('expected_pupa_days_min')) {
      context.handle(
        _expectedPupaDaysMinMeta,
        expectedPupaDaysMin.isAcceptableOrUnknown(
          data['expected_pupa_days_min']!,
          _expectedPupaDaysMinMeta,
        ),
      );
    }
    if (data.containsKey('expected_pupa_days_max')) {
      context.handle(
        _expectedPupaDaysMaxMeta,
        expectedPupaDaysMax.isAcceptableOrUnknown(
          data['expected_pupa_days_max']!,
          _expectedPupaDaysMaxMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpeciesRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeciesRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      code:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}code'],
          )!,
      scientificName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}scientific_name'],
          )!,
      commonName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_name'],
      ),
      isBuiltin:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_builtin'],
          )!,
      expectedPupaDaysMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_pupa_days_min'],
      ),
      expectedPupaDaysMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_pupa_days_max'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $SpeciesTable createAlias(String alias) {
    return $SpeciesTable(attachedDatabase, alias);
  }
}

class SpeciesRow extends DataClass implements Insertable<SpeciesRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String code;
  final String scientificName;
  final String? commonName;
  final bool isBuiltin;

  /// User-configured expected pupal duration. Null = unknown; no window is suggested.
  final int? expectedPupaDaysMin;
  final int? expectedPupaDaysMax;
  final String? notes;
  const SpeciesRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.code,
    required this.scientificName,
    this.commonName,
    required this.isBuiltin,
    this.expectedPupaDaysMin,
    this.expectedPupaDaysMax,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    map['code'] = Variable<String>(code);
    map['scientific_name'] = Variable<String>(scientificName);
    if (!nullToAbsent || commonName != null) {
      map['common_name'] = Variable<String>(commonName);
    }
    map['is_builtin'] = Variable<bool>(isBuiltin);
    if (!nullToAbsent || expectedPupaDaysMin != null) {
      map['expected_pupa_days_min'] = Variable<int>(expectedPupaDaysMin);
    }
    if (!nullToAbsent || expectedPupaDaysMax != null) {
      map['expected_pupa_days_max'] = Variable<int>(expectedPupaDaysMax);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SpeciesCompanion toCompanion(bool nullToAbsent) {
    return SpeciesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      code: Value(code),
      scientificName: Value(scientificName),
      commonName:
          commonName == null && nullToAbsent
              ? const Value.absent()
              : Value(commonName),
      isBuiltin: Value(isBuiltin),
      expectedPupaDaysMin:
          expectedPupaDaysMin == null && nullToAbsent
              ? const Value.absent()
              : Value(expectedPupaDaysMin),
      expectedPupaDaysMax:
          expectedPupaDaysMax == null && nullToAbsent
              ? const Value.absent()
              : Value(expectedPupaDaysMax),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory SpeciesRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeciesRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      code: serializer.fromJson<String>(json['code']),
      scientificName: serializer.fromJson<String>(json['scientificName']),
      commonName: serializer.fromJson<String?>(json['commonName']),
      isBuiltin: serializer.fromJson<bool>(json['isBuiltin']),
      expectedPupaDaysMin: serializer.fromJson<int?>(
        json['expectedPupaDaysMin'],
      ),
      expectedPupaDaysMax: serializer.fromJson<int?>(
        json['expectedPupaDaysMax'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'code': serializer.toJson<String>(code),
      'scientificName': serializer.toJson<String>(scientificName),
      'commonName': serializer.toJson<String?>(commonName),
      'isBuiltin': serializer.toJson<bool>(isBuiltin),
      'expectedPupaDaysMin': serializer.toJson<int?>(expectedPupaDaysMin),
      'expectedPupaDaysMax': serializer.toJson<int?>(expectedPupaDaysMax),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  SpeciesRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    String? code,
    String? scientificName,
    Value<String?> commonName = const Value.absent(),
    bool? isBuiltin,
    Value<int?> expectedPupaDaysMin = const Value.absent(),
    Value<int?> expectedPupaDaysMax = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => SpeciesRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    code: code ?? this.code,
    scientificName: scientificName ?? this.scientificName,
    commonName: commonName.present ? commonName.value : this.commonName,
    isBuiltin: isBuiltin ?? this.isBuiltin,
    expectedPupaDaysMin:
        expectedPupaDaysMin.present
            ? expectedPupaDaysMin.value
            : this.expectedPupaDaysMin,
    expectedPupaDaysMax:
        expectedPupaDaysMax.present
            ? expectedPupaDaysMax.value
            : this.expectedPupaDaysMax,
    notes: notes.present ? notes.value : this.notes,
  );
  SpeciesRow copyWithCompanion(SpeciesCompanion data) {
    return SpeciesRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      code: data.code.present ? data.code.value : this.code,
      scientificName:
          data.scientificName.present
              ? data.scientificName.value
              : this.scientificName,
      commonName:
          data.commonName.present ? data.commonName.value : this.commonName,
      isBuiltin: data.isBuiltin.present ? data.isBuiltin.value : this.isBuiltin,
      expectedPupaDaysMin:
          data.expectedPupaDaysMin.present
              ? data.expectedPupaDaysMin.value
              : this.expectedPupaDaysMin,
      expectedPupaDaysMax:
          data.expectedPupaDaysMax.present
              ? data.expectedPupaDaysMax.value
              : this.expectedPupaDaysMax,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('code: $code, ')
          ..write('scientificName: $scientificName, ')
          ..write('commonName: $commonName, ')
          ..write('isBuiltin: $isBuiltin, ')
          ..write('expectedPupaDaysMin: $expectedPupaDaysMin, ')
          ..write('expectedPupaDaysMax: $expectedPupaDaysMax, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    code,
    scientificName,
    commonName,
    isBuiltin,
    expectedPupaDaysMin,
    expectedPupaDaysMax,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeciesRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.code == this.code &&
          other.scientificName == this.scientificName &&
          other.commonName == this.commonName &&
          other.isBuiltin == this.isBuiltin &&
          other.expectedPupaDaysMin == this.expectedPupaDaysMin &&
          other.expectedPupaDaysMax == this.expectedPupaDaysMax &&
          other.notes == this.notes);
}

class SpeciesCompanion extends UpdateCompanion<SpeciesRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String> code;
  final Value<String> scientificName;
  final Value<String?> commonName;
  final Value<bool> isBuiltin;
  final Value<int?> expectedPupaDaysMin;
  final Value<int?> expectedPupaDaysMax;
  final Value<String?> notes;
  final Value<int> rowid;
  const SpeciesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.code = const Value.absent(),
    this.scientificName = const Value.absent(),
    this.commonName = const Value.absent(),
    this.isBuiltin = const Value.absent(),
    this.expectedPupaDaysMin = const Value.absent(),
    this.expectedPupaDaysMax = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpeciesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required String code,
    required String scientificName,
    this.commonName = const Value.absent(),
    this.isBuiltin = const Value.absent(),
    this.expectedPupaDaysMin = const Value.absent(),
    this.expectedPupaDaysMax = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       scientificName = Value(scientificName);
  static Insertable<SpeciesRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? code,
    Expression<String>? scientificName,
    Expression<String>? commonName,
    Expression<bool>? isBuiltin,
    Expression<int>? expectedPupaDaysMin,
    Expression<int>? expectedPupaDaysMax,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (code != null) 'code': code,
      if (scientificName != null) 'scientific_name': scientificName,
      if (commonName != null) 'common_name': commonName,
      if (isBuiltin != null) 'is_builtin': isBuiltin,
      if (expectedPupaDaysMin != null)
        'expected_pupa_days_min': expectedPupaDaysMin,
      if (expectedPupaDaysMax != null)
        'expected_pupa_days_max': expectedPupaDaysMax,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpeciesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String>? code,
    Value<String>? scientificName,
    Value<String?>? commonName,
    Value<bool>? isBuiltin,
    Value<int?>? expectedPupaDaysMin,
    Value<int?>? expectedPupaDaysMax,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return SpeciesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      code: code ?? this.code,
      scientificName: scientificName ?? this.scientificName,
      commonName: commonName ?? this.commonName,
      isBuiltin: isBuiltin ?? this.isBuiltin,
      expectedPupaDaysMin: expectedPupaDaysMin ?? this.expectedPupaDaysMin,
      expectedPupaDaysMax: expectedPupaDaysMax ?? this.expectedPupaDaysMax,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (scientificName.present) {
      map['scientific_name'] = Variable<String>(scientificName.value);
    }
    if (commonName.present) {
      map['common_name'] = Variable<String>(commonName.value);
    }
    if (isBuiltin.present) {
      map['is_builtin'] = Variable<bool>(isBuiltin.value);
    }
    if (expectedPupaDaysMin.present) {
      map['expected_pupa_days_min'] = Variable<int>(expectedPupaDaysMin.value);
    }
    if (expectedPupaDaysMax.present) {
      map['expected_pupa_days_max'] = Variable<int>(expectedPupaDaysMax.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('code: $code, ')
          ..write('scientificName: $scientificName, ')
          ..write('commonName: $commonName, ')
          ..write('isBuiltin: $isBuiltin, ')
          ..write('expectedPupaDaysMin: $expectedPupaDaysMin, ')
          ..write('expectedPupaDaysMax: $expectedPupaDaysMax, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TemperatureSensorsTable extends TemperatureSensors
    with TableInfo<$TemperatureSensorsTable, TemperatureSensorRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemperatureSensorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SensorKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('manual'),
      ).withConverter<SensorKind>($TemperatureSensorsTable.$converterkind);
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minThresholdCMeta = const VerificationMeta(
    'minThresholdC',
  );
  @override
  late final GeneratedColumn<double> minThresholdC = GeneratedColumn<double>(
    'min_threshold_c',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxThresholdCMeta = const VerificationMeta(
    'maxThresholdC',
  );
  @override
  late final GeneratedColumn<double> maxThresholdC = GeneratedColumn<double>(
    'max_threshold_c',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetCMeta = const VerificationMeta(
    'targetC',
  );
  @override
  late final GeneratedColumn<double> targetC = GeneratedColumn<double>(
    'target_c',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    name,
    location,
    kind,
    externalId,
    minThresholdC,
    maxThresholdC,
    targetC,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'temperature_sensors';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemperatureSensorRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    }
    if (data.containsKey('min_threshold_c')) {
      context.handle(
        _minThresholdCMeta,
        minThresholdC.isAcceptableOrUnknown(
          data['min_threshold_c']!,
          _minThresholdCMeta,
        ),
      );
    }
    if (data.containsKey('max_threshold_c')) {
      context.handle(
        _maxThresholdCMeta,
        maxThresholdC.isAcceptableOrUnknown(
          data['max_threshold_c']!,
          _maxThresholdCMeta,
        ),
      );
    }
    if (data.containsKey('target_c')) {
      context.handle(
        _targetCMeta,
        targetC.isAcceptableOrUnknown(data['target_c']!, _targetCMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemperatureSensorRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemperatureSensorRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      kind: $TemperatureSensorsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      ),
      minThresholdC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}min_threshold_c'],
      ),
      maxThresholdC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_threshold_c'],
      ),
      targetC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_c'],
      ),
    );
  }

  @override
  $TemperatureSensorsTable createAlias(String alias) {
    return $TemperatureSensorsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SensorKind, String, String> $converterkind =
      const EnumNameConverter<SensorKind>(SensorKind.values);
}

class TemperatureSensorRow extends DataClass
    implements Insertable<TemperatureSensorRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String name;
  final String? location;
  final SensorKind kind;

  /// Hardware identifier for future Bluetooth / Wi-Fi sensors.
  final String? externalId;

  /// User-configured thresholds. There are deliberately no defaults: suitable
  /// temperatures depend on species and life stage.
  final double? minThresholdC;
  final double? maxThresholdC;
  final double? targetC;
  const TemperatureSensorRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.name,
    this.location,
    required this.kind,
    this.externalId,
    this.minThresholdC,
    this.maxThresholdC,
    this.targetC,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    {
      map['kind'] = Variable<String>(
        $TemperatureSensorsTable.$converterkind.toSql(kind),
      );
    }
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    if (!nullToAbsent || minThresholdC != null) {
      map['min_threshold_c'] = Variable<double>(minThresholdC);
    }
    if (!nullToAbsent || maxThresholdC != null) {
      map['max_threshold_c'] = Variable<double>(maxThresholdC);
    }
    if (!nullToAbsent || targetC != null) {
      map['target_c'] = Variable<double>(targetC);
    }
    return map;
  }

  TemperatureSensorsCompanion toCompanion(bool nullToAbsent) {
    return TemperatureSensorsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      name: Value(name),
      location:
          location == null && nullToAbsent
              ? const Value.absent()
              : Value(location),
      kind: Value(kind),
      externalId:
          externalId == null && nullToAbsent
              ? const Value.absent()
              : Value(externalId),
      minThresholdC:
          minThresholdC == null && nullToAbsent
              ? const Value.absent()
              : Value(minThresholdC),
      maxThresholdC:
          maxThresholdC == null && nullToAbsent
              ? const Value.absent()
              : Value(maxThresholdC),
      targetC:
          targetC == null && nullToAbsent
              ? const Value.absent()
              : Value(targetC),
    );
  }

  factory TemperatureSensorRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemperatureSensorRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      name: serializer.fromJson<String>(json['name']),
      location: serializer.fromJson<String?>(json['location']),
      kind: $TemperatureSensorsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      externalId: serializer.fromJson<String?>(json['externalId']),
      minThresholdC: serializer.fromJson<double?>(json['minThresholdC']),
      maxThresholdC: serializer.fromJson<double?>(json['maxThresholdC']),
      targetC: serializer.fromJson<double?>(json['targetC']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'name': serializer.toJson<String>(name),
      'location': serializer.toJson<String?>(location),
      'kind': serializer.toJson<String>(
        $TemperatureSensorsTable.$converterkind.toJson(kind),
      ),
      'externalId': serializer.toJson<String?>(externalId),
      'minThresholdC': serializer.toJson<double?>(minThresholdC),
      'maxThresholdC': serializer.toJson<double?>(maxThresholdC),
      'targetC': serializer.toJson<double?>(targetC),
    };
  }

  TemperatureSensorRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    String? name,
    Value<String?> location = const Value.absent(),
    SensorKind? kind,
    Value<String?> externalId = const Value.absent(),
    Value<double?> minThresholdC = const Value.absent(),
    Value<double?> maxThresholdC = const Value.absent(),
    Value<double?> targetC = const Value.absent(),
  }) => TemperatureSensorRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    name: name ?? this.name,
    location: location.present ? location.value : this.location,
    kind: kind ?? this.kind,
    externalId: externalId.present ? externalId.value : this.externalId,
    minThresholdC:
        minThresholdC.present ? minThresholdC.value : this.minThresholdC,
    maxThresholdC:
        maxThresholdC.present ? maxThresholdC.value : this.maxThresholdC,
    targetC: targetC.present ? targetC.value : this.targetC,
  );
  TemperatureSensorRow copyWithCompanion(TemperatureSensorsCompanion data) {
    return TemperatureSensorRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      name: data.name.present ? data.name.value : this.name,
      location: data.location.present ? data.location.value : this.location,
      kind: data.kind.present ? data.kind.value : this.kind,
      externalId:
          data.externalId.present ? data.externalId.value : this.externalId,
      minThresholdC:
          data.minThresholdC.present
              ? data.minThresholdC.value
              : this.minThresholdC,
      maxThresholdC:
          data.maxThresholdC.present
              ? data.maxThresholdC.value
              : this.maxThresholdC,
      targetC: data.targetC.present ? data.targetC.value : this.targetC,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemperatureSensorRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('kind: $kind, ')
          ..write('externalId: $externalId, ')
          ..write('minThresholdC: $minThresholdC, ')
          ..write('maxThresholdC: $maxThresholdC, ')
          ..write('targetC: $targetC')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    name,
    location,
    kind,
    externalId,
    minThresholdC,
    maxThresholdC,
    targetC,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemperatureSensorRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.name == this.name &&
          other.location == this.location &&
          other.kind == this.kind &&
          other.externalId == this.externalId &&
          other.minThresholdC == this.minThresholdC &&
          other.maxThresholdC == this.maxThresholdC &&
          other.targetC == this.targetC);
}

class TemperatureSensorsCompanion
    extends UpdateCompanion<TemperatureSensorRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String> name;
  final Value<String?> location;
  final Value<SensorKind> kind;
  final Value<String?> externalId;
  final Value<double?> minThresholdC;
  final Value<double?> maxThresholdC;
  final Value<double?> targetC;
  final Value<int> rowid;
  const TemperatureSensorsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.name = const Value.absent(),
    this.location = const Value.absent(),
    this.kind = const Value.absent(),
    this.externalId = const Value.absent(),
    this.minThresholdC = const Value.absent(),
    this.maxThresholdC = const Value.absent(),
    this.targetC = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemperatureSensorsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required String name,
    this.location = const Value.absent(),
    this.kind = const Value.absent(),
    this.externalId = const Value.absent(),
    this.minThresholdC = const Value.absent(),
    this.maxThresholdC = const Value.absent(),
    this.targetC = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<TemperatureSensorRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? name,
    Expression<String>? location,
    Expression<String>? kind,
    Expression<String>? externalId,
    Expression<double>? minThresholdC,
    Expression<double>? maxThresholdC,
    Expression<double>? targetC,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      if (kind != null) 'kind': kind,
      if (externalId != null) 'external_id': externalId,
      if (minThresholdC != null) 'min_threshold_c': minThresholdC,
      if (maxThresholdC != null) 'max_threshold_c': maxThresholdC,
      if (targetC != null) 'target_c': targetC,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemperatureSensorsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String>? name,
    Value<String?>? location,
    Value<SensorKind>? kind,
    Value<String?>? externalId,
    Value<double?>? minThresholdC,
    Value<double?>? maxThresholdC,
    Value<double?>? targetC,
    Value<int>? rowid,
  }) {
    return TemperatureSensorsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      name: name ?? this.name,
      location: location ?? this.location,
      kind: kind ?? this.kind,
      externalId: externalId ?? this.externalId,
      minThresholdC: minThresholdC ?? this.minThresholdC,
      maxThresholdC: maxThresholdC ?? this.maxThresholdC,
      targetC: targetC ?? this.targetC,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $TemperatureSensorsTable.$converterkind.toSql(kind.value),
      );
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (minThresholdC.present) {
      map['min_threshold_c'] = Variable<double>(minThresholdC.value);
    }
    if (maxThresholdC.present) {
      map['max_threshold_c'] = Variable<double>(maxThresholdC.value);
    }
    if (targetC.present) {
      map['target_c'] = Variable<double>(targetC.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemperatureSensorsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('kind: $kind, ')
          ..write('externalId: $externalId, ')
          ..write('minThresholdC: $minThresholdC, ')
          ..write('maxThresholdC: $maxThresholdC, ')
          ..write('targetC: $targetC, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BeetlesTable extends Beetles with TableInfo<$BeetlesTable, BeetleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BeetlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sex, String> sex =
      GeneratedColumn<String>(
        'sex',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('unknown'),
      ).withConverter<Sex>($BeetlesTable.$convertersex);
  @override
  late final GeneratedColumnWithTypeConverter<BeetleStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('active'),
      ).withConverter<BeetleStatus>($BeetlesTable.$converterstatus);
  static const VerificationMeta _acquiredAtMeta = const VerificationMeta(
    'acquiredAt',
  );
  @override
  late final GeneratedColumn<DateTime> acquiredAt = GeneratedColumn<DateTime>(
    'acquired_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hatchDateMeta = const VerificationMeta(
    'hatchDate',
  );
  @override
  late final GeneratedColumn<DateTime> hatchDate = GeneratedColumn<DateTime>(
    'hatch_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedHatchDateMeta =
      const VerificationMeta('estimatedHatchDate');
  @override
  late final GeneratedColumn<DateTime> estimatedHatchDate =
      GeneratedColumn<DateTime>(
        'estimated_hatch_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _hatchUncertaintyDaysMeta =
      const VerificationMeta('hatchUncertaintyDays');
  @override
  late final GeneratedColumn<int> hatchUncertaintyDays = GeneratedColumn<int>(
    'hatch_uncertainty_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sensorIdMeta = const VerificationMeta(
    'sensorId',
  );
  @override
  late final GeneratedColumn<String> sensorId = GeneratedColumn<String>(
    'sensor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES temperature_sensors (id)',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sireIdMeta = const VerificationMeta('sireId');
  @override
  late final GeneratedColumn<String> sireId = GeneratedColumn<String>(
    'sire_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _damIdMeta = const VerificationMeta('damId');
  @override
  late final GeneratedColumn<String> damId = GeneratedColumn<String>(
    'dam_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _sireNoteMeta = const VerificationMeta(
    'sireNote',
  );
  @override
  late final GeneratedColumn<String> sireNote = GeneratedColumn<String>(
    'sire_note',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _damNoteMeta = const VerificationMeta(
    'damNote',
  );
  @override
  late final GeneratedColumn<String> damNote = GeneratedColumn<String>(
    'dam_note',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    code,
    speciesId,
    sex,
    status,
    acquiredAt,
    hatchDate,
    estimatedHatchDate,
    hatchUncertaintyDays,
    sensorId,
    notes,
    sireId,
    damId,
    sireNote,
    damNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'beetles';
  @override
  VerificationContext validateIntegrity(
    Insertable<BeetleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('acquired_at')) {
      context.handle(
        _acquiredAtMeta,
        acquiredAt.isAcceptableOrUnknown(data['acquired_at']!, _acquiredAtMeta),
      );
    }
    if (data.containsKey('hatch_date')) {
      context.handle(
        _hatchDateMeta,
        hatchDate.isAcceptableOrUnknown(data['hatch_date']!, _hatchDateMeta),
      );
    }
    if (data.containsKey('estimated_hatch_date')) {
      context.handle(
        _estimatedHatchDateMeta,
        estimatedHatchDate.isAcceptableOrUnknown(
          data['estimated_hatch_date']!,
          _estimatedHatchDateMeta,
        ),
      );
    }
    if (data.containsKey('hatch_uncertainty_days')) {
      context.handle(
        _hatchUncertaintyDaysMeta,
        hatchUncertaintyDays.isAcceptableOrUnknown(
          data['hatch_uncertainty_days']!,
          _hatchUncertaintyDaysMeta,
        ),
      );
    }
    if (data.containsKey('sensor_id')) {
      context.handle(
        _sensorIdMeta,
        sensorId.isAcceptableOrUnknown(data['sensor_id']!, _sensorIdMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('sire_id')) {
      context.handle(
        _sireIdMeta,
        sireId.isAcceptableOrUnknown(data['sire_id']!, _sireIdMeta),
      );
    }
    if (data.containsKey('dam_id')) {
      context.handle(
        _damIdMeta,
        damId.isAcceptableOrUnknown(data['dam_id']!, _damIdMeta),
      );
    }
    if (data.containsKey('sire_note')) {
      context.handle(
        _sireNoteMeta,
        sireNote.isAcceptableOrUnknown(data['sire_note']!, _sireNoteMeta),
      );
    }
    if (data.containsKey('dam_note')) {
      context.handle(
        _damNoteMeta,
        damNote.isAcceptableOrUnknown(data['dam_note']!, _damNoteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BeetleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BeetleRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      code:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}code'],
          )!,
      speciesId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}species_id'],
          )!,
      sex: $BeetlesTable.$convertersex.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sex'],
        )!,
      ),
      status: $BeetlesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      acquiredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acquired_at'],
      ),
      hatchDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}hatch_date'],
      ),
      estimatedHatchDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}estimated_hatch_date'],
      ),
      hatchUncertaintyDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hatch_uncertainty_days'],
      ),
      sensorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensor_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      sireId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sire_id'],
      ),
      damId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dam_id'],
      ),
      sireNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sire_note'],
      ),
      damNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dam_note'],
      ),
    );
  }

  @override
  $BeetlesTable createAlias(String alias) {
    return $BeetlesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Sex, String, String> $convertersex =
      const EnumNameConverter<Sex>(Sex.values);
  static JsonTypeConverter2<BeetleStatus, String, String> $converterstatus =
      const EnumNameConverter<BeetleStatus>(BeetleStatus.values);
}

class BeetleRow extends DataClass implements Insertable<BeetleRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String code;
  final String speciesId;
  final Sex sex;
  final BeetleStatus status;
  final DateTime? acquiredAt;
  final DateTime? hatchDate;
  final DateTime? estimatedHatchDate;
  final int? hatchUncertaintyDays;
  final String? sensorId;
  final String? notes;
  final String? sireId;
  final String? damId;
  final String? sireNote;
  final String? damNote;
  const BeetleRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.code,
    required this.speciesId,
    required this.sex,
    required this.status,
    this.acquiredAt,
    this.hatchDate,
    this.estimatedHatchDate,
    this.hatchUncertaintyDays,
    this.sensorId,
    this.notes,
    this.sireId,
    this.damId,
    this.sireNote,
    this.damNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    map['code'] = Variable<String>(code);
    map['species_id'] = Variable<String>(speciesId);
    {
      map['sex'] = Variable<String>($BeetlesTable.$convertersex.toSql(sex));
    }
    {
      map['status'] = Variable<String>(
        $BeetlesTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || acquiredAt != null) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt);
    }
    if (!nullToAbsent || hatchDate != null) {
      map['hatch_date'] = Variable<DateTime>(hatchDate);
    }
    if (!nullToAbsent || estimatedHatchDate != null) {
      map['estimated_hatch_date'] = Variable<DateTime>(estimatedHatchDate);
    }
    if (!nullToAbsent || hatchUncertaintyDays != null) {
      map['hatch_uncertainty_days'] = Variable<int>(hatchUncertaintyDays);
    }
    if (!nullToAbsent || sensorId != null) {
      map['sensor_id'] = Variable<String>(sensorId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || sireId != null) {
      map['sire_id'] = Variable<String>(sireId);
    }
    if (!nullToAbsent || damId != null) {
      map['dam_id'] = Variable<String>(damId);
    }
    if (!nullToAbsent || sireNote != null) {
      map['sire_note'] = Variable<String>(sireNote);
    }
    if (!nullToAbsent || damNote != null) {
      map['dam_note'] = Variable<String>(damNote);
    }
    return map;
  }

  BeetlesCompanion toCompanion(bool nullToAbsent) {
    return BeetlesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      code: Value(code),
      speciesId: Value(speciesId),
      sex: Value(sex),
      status: Value(status),
      acquiredAt:
          acquiredAt == null && nullToAbsent
              ? const Value.absent()
              : Value(acquiredAt),
      hatchDate:
          hatchDate == null && nullToAbsent
              ? const Value.absent()
              : Value(hatchDate),
      estimatedHatchDate:
          estimatedHatchDate == null && nullToAbsent
              ? const Value.absent()
              : Value(estimatedHatchDate),
      hatchUncertaintyDays:
          hatchUncertaintyDays == null && nullToAbsent
              ? const Value.absent()
              : Value(hatchUncertaintyDays),
      sensorId:
          sensorId == null && nullToAbsent
              ? const Value.absent()
              : Value(sensorId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      sireId:
          sireId == null && nullToAbsent ? const Value.absent() : Value(sireId),
      damId:
          damId == null && nullToAbsent ? const Value.absent() : Value(damId),
      sireNote:
          sireNote == null && nullToAbsent
              ? const Value.absent()
              : Value(sireNote),
      damNote:
          damNote == null && nullToAbsent
              ? const Value.absent()
              : Value(damNote),
    );
  }

  factory BeetleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BeetleRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      code: serializer.fromJson<String>(json['code']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      sex: $BeetlesTable.$convertersex.fromJson(
        serializer.fromJson<String>(json['sex']),
      ),
      status: $BeetlesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      acquiredAt: serializer.fromJson<DateTime?>(json['acquiredAt']),
      hatchDate: serializer.fromJson<DateTime?>(json['hatchDate']),
      estimatedHatchDate: serializer.fromJson<DateTime?>(
        json['estimatedHatchDate'],
      ),
      hatchUncertaintyDays: serializer.fromJson<int?>(
        json['hatchUncertaintyDays'],
      ),
      sensorId: serializer.fromJson<String?>(json['sensorId']),
      notes: serializer.fromJson<String?>(json['notes']),
      sireId: serializer.fromJson<String?>(json['sireId']),
      damId: serializer.fromJson<String?>(json['damId']),
      sireNote: serializer.fromJson<String?>(json['sireNote']),
      damNote: serializer.fromJson<String?>(json['damNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'code': serializer.toJson<String>(code),
      'speciesId': serializer.toJson<String>(speciesId),
      'sex': serializer.toJson<String>($BeetlesTable.$convertersex.toJson(sex)),
      'status': serializer.toJson<String>(
        $BeetlesTable.$converterstatus.toJson(status),
      ),
      'acquiredAt': serializer.toJson<DateTime?>(acquiredAt),
      'hatchDate': serializer.toJson<DateTime?>(hatchDate),
      'estimatedHatchDate': serializer.toJson<DateTime?>(estimatedHatchDate),
      'hatchUncertaintyDays': serializer.toJson<int?>(hatchUncertaintyDays),
      'sensorId': serializer.toJson<String?>(sensorId),
      'notes': serializer.toJson<String?>(notes),
      'sireId': serializer.toJson<String?>(sireId),
      'damId': serializer.toJson<String?>(damId),
      'sireNote': serializer.toJson<String?>(sireNote),
      'damNote': serializer.toJson<String?>(damNote),
    };
  }

  BeetleRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    String? code,
    String? speciesId,
    Sex? sex,
    BeetleStatus? status,
    Value<DateTime?> acquiredAt = const Value.absent(),
    Value<DateTime?> hatchDate = const Value.absent(),
    Value<DateTime?> estimatedHatchDate = const Value.absent(),
    Value<int?> hatchUncertaintyDays = const Value.absent(),
    Value<String?> sensorId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> sireId = const Value.absent(),
    Value<String?> damId = const Value.absent(),
    Value<String?> sireNote = const Value.absent(),
    Value<String?> damNote = const Value.absent(),
  }) => BeetleRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    code: code ?? this.code,
    speciesId: speciesId ?? this.speciesId,
    sex: sex ?? this.sex,
    status: status ?? this.status,
    acquiredAt: acquiredAt.present ? acquiredAt.value : this.acquiredAt,
    hatchDate: hatchDate.present ? hatchDate.value : this.hatchDate,
    estimatedHatchDate:
        estimatedHatchDate.present
            ? estimatedHatchDate.value
            : this.estimatedHatchDate,
    hatchUncertaintyDays:
        hatchUncertaintyDays.present
            ? hatchUncertaintyDays.value
            : this.hatchUncertaintyDays,
    sensorId: sensorId.present ? sensorId.value : this.sensorId,
    notes: notes.present ? notes.value : this.notes,
    sireId: sireId.present ? sireId.value : this.sireId,
    damId: damId.present ? damId.value : this.damId,
    sireNote: sireNote.present ? sireNote.value : this.sireNote,
    damNote: damNote.present ? damNote.value : this.damNote,
  );
  BeetleRow copyWithCompanion(BeetlesCompanion data) {
    return BeetleRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      code: data.code.present ? data.code.value : this.code,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      sex: data.sex.present ? data.sex.value : this.sex,
      status: data.status.present ? data.status.value : this.status,
      acquiredAt:
          data.acquiredAt.present ? data.acquiredAt.value : this.acquiredAt,
      hatchDate: data.hatchDate.present ? data.hatchDate.value : this.hatchDate,
      estimatedHatchDate:
          data.estimatedHatchDate.present
              ? data.estimatedHatchDate.value
              : this.estimatedHatchDate,
      hatchUncertaintyDays:
          data.hatchUncertaintyDays.present
              ? data.hatchUncertaintyDays.value
              : this.hatchUncertaintyDays,
      sensorId: data.sensorId.present ? data.sensorId.value : this.sensorId,
      notes: data.notes.present ? data.notes.value : this.notes,
      sireId: data.sireId.present ? data.sireId.value : this.sireId,
      damId: data.damId.present ? data.damId.value : this.damId,
      sireNote: data.sireNote.present ? data.sireNote.value : this.sireNote,
      damNote: data.damNote.present ? data.damNote.value : this.damNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BeetleRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('code: $code, ')
          ..write('speciesId: $speciesId, ')
          ..write('sex: $sex, ')
          ..write('status: $status, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('hatchDate: $hatchDate, ')
          ..write('estimatedHatchDate: $estimatedHatchDate, ')
          ..write('hatchUncertaintyDays: $hatchUncertaintyDays, ')
          ..write('sensorId: $sensorId, ')
          ..write('notes: $notes, ')
          ..write('sireId: $sireId, ')
          ..write('damId: $damId, ')
          ..write('sireNote: $sireNote, ')
          ..write('damNote: $damNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    code,
    speciesId,
    sex,
    status,
    acquiredAt,
    hatchDate,
    estimatedHatchDate,
    hatchUncertaintyDays,
    sensorId,
    notes,
    sireId,
    damId,
    sireNote,
    damNote,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BeetleRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.code == this.code &&
          other.speciesId == this.speciesId &&
          other.sex == this.sex &&
          other.status == this.status &&
          other.acquiredAt == this.acquiredAt &&
          other.hatchDate == this.hatchDate &&
          other.estimatedHatchDate == this.estimatedHatchDate &&
          other.hatchUncertaintyDays == this.hatchUncertaintyDays &&
          other.sensorId == this.sensorId &&
          other.notes == this.notes &&
          other.sireId == this.sireId &&
          other.damId == this.damId &&
          other.sireNote == this.sireNote &&
          other.damNote == this.damNote);
}

class BeetlesCompanion extends UpdateCompanion<BeetleRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String> code;
  final Value<String> speciesId;
  final Value<Sex> sex;
  final Value<BeetleStatus> status;
  final Value<DateTime?> acquiredAt;
  final Value<DateTime?> hatchDate;
  final Value<DateTime?> estimatedHatchDate;
  final Value<int?> hatchUncertaintyDays;
  final Value<String?> sensorId;
  final Value<String?> notes;
  final Value<String?> sireId;
  final Value<String?> damId;
  final Value<String?> sireNote;
  final Value<String?> damNote;
  final Value<int> rowid;
  const BeetlesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.code = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.sex = const Value.absent(),
    this.status = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.hatchDate = const Value.absent(),
    this.estimatedHatchDate = const Value.absent(),
    this.hatchUncertaintyDays = const Value.absent(),
    this.sensorId = const Value.absent(),
    this.notes = const Value.absent(),
    this.sireId = const Value.absent(),
    this.damId = const Value.absent(),
    this.sireNote = const Value.absent(),
    this.damNote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BeetlesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required String code,
    required String speciesId,
    this.sex = const Value.absent(),
    this.status = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.hatchDate = const Value.absent(),
    this.estimatedHatchDate = const Value.absent(),
    this.hatchUncertaintyDays = const Value.absent(),
    this.sensorId = const Value.absent(),
    this.notes = const Value.absent(),
    this.sireId = const Value.absent(),
    this.damId = const Value.absent(),
    this.sireNote = const Value.absent(),
    this.damNote = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       speciesId = Value(speciesId);
  static Insertable<BeetleRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? code,
    Expression<String>? speciesId,
    Expression<String>? sex,
    Expression<String>? status,
    Expression<DateTime>? acquiredAt,
    Expression<DateTime>? hatchDate,
    Expression<DateTime>? estimatedHatchDate,
    Expression<int>? hatchUncertaintyDays,
    Expression<String>? sensorId,
    Expression<String>? notes,
    Expression<String>? sireId,
    Expression<String>? damId,
    Expression<String>? sireNote,
    Expression<String>? damNote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (code != null) 'code': code,
      if (speciesId != null) 'species_id': speciesId,
      if (sex != null) 'sex': sex,
      if (status != null) 'status': status,
      if (acquiredAt != null) 'acquired_at': acquiredAt,
      if (hatchDate != null) 'hatch_date': hatchDate,
      if (estimatedHatchDate != null)
        'estimated_hatch_date': estimatedHatchDate,
      if (hatchUncertaintyDays != null)
        'hatch_uncertainty_days': hatchUncertaintyDays,
      if (sensorId != null) 'sensor_id': sensorId,
      if (notes != null) 'notes': notes,
      if (sireId != null) 'sire_id': sireId,
      if (damId != null) 'dam_id': damId,
      if (sireNote != null) 'sire_note': sireNote,
      if (damNote != null) 'dam_note': damNote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BeetlesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String>? code,
    Value<String>? speciesId,
    Value<Sex>? sex,
    Value<BeetleStatus>? status,
    Value<DateTime?>? acquiredAt,
    Value<DateTime?>? hatchDate,
    Value<DateTime?>? estimatedHatchDate,
    Value<int?>? hatchUncertaintyDays,
    Value<String?>? sensorId,
    Value<String?>? notes,
    Value<String?>? sireId,
    Value<String?>? damId,
    Value<String?>? sireNote,
    Value<String?>? damNote,
    Value<int>? rowid,
  }) {
    return BeetlesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      code: code ?? this.code,
      speciesId: speciesId ?? this.speciesId,
      sex: sex ?? this.sex,
      status: status ?? this.status,
      acquiredAt: acquiredAt ?? this.acquiredAt,
      hatchDate: hatchDate ?? this.hatchDate,
      estimatedHatchDate: estimatedHatchDate ?? this.estimatedHatchDate,
      hatchUncertaintyDays: hatchUncertaintyDays ?? this.hatchUncertaintyDays,
      sensorId: sensorId ?? this.sensorId,
      notes: notes ?? this.notes,
      sireId: sireId ?? this.sireId,
      damId: damId ?? this.damId,
      sireNote: sireNote ?? this.sireNote,
      damNote: damNote ?? this.damNote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(
        $BeetlesTable.$convertersex.toSql(sex.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $BeetlesTable.$converterstatus.toSql(status.value),
      );
    }
    if (acquiredAt.present) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt.value);
    }
    if (hatchDate.present) {
      map['hatch_date'] = Variable<DateTime>(hatchDate.value);
    }
    if (estimatedHatchDate.present) {
      map['estimated_hatch_date'] = Variable<DateTime>(
        estimatedHatchDate.value,
      );
    }
    if (hatchUncertaintyDays.present) {
      map['hatch_uncertainty_days'] = Variable<int>(hatchUncertaintyDays.value);
    }
    if (sensorId.present) {
      map['sensor_id'] = Variable<String>(sensorId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (sireId.present) {
      map['sire_id'] = Variable<String>(sireId.value);
    }
    if (damId.present) {
      map['dam_id'] = Variable<String>(damId.value);
    }
    if (sireNote.present) {
      map['sire_note'] = Variable<String>(sireNote.value);
    }
    if (damNote.present) {
      map['dam_note'] = Variable<String>(damNote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BeetlesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('code: $code, ')
          ..write('speciesId: $speciesId, ')
          ..write('sex: $sex, ')
          ..write('status: $status, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('hatchDate: $hatchDate, ')
          ..write('estimatedHatchDate: $estimatedHatchDate, ')
          ..write('hatchUncertaintyDays: $hatchUncertaintyDays, ')
          ..write('sensorId: $sensorId, ')
          ..write('notes: $notes, ')
          ..write('sireId: $sireId, ')
          ..write('damId: $damId, ')
          ..write('sireNote: $sireNote, ')
          ..write('damNote: $damNote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeightRecordsTable extends WeightRecords
    with TableInfo<$WeightRecordsTable, WeightRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _beetleIdMeta = const VerificationMeta(
    'beetleId',
  );
  @override
  late final GeneratedColumn<String> beetleId = GeneratedColumn<String>(
    'beetle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _measuredAtMeta = const VerificationMeta(
    'measuredAt',
  );
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
    'measured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightGramsMeta = const VerificationMeta(
    'weightGrams',
  );
  @override
  late final GeneratedColumn<double> weightGrams = GeneratedColumn<double>(
    'weight_grams',
    aliasedName,
    false,
    check: () => ComparableExpr(weightGrams).isBiggerThanValue(0),
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    measuredAt,
    weightGrams,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('beetle_id')) {
      context.handle(
        _beetleIdMeta,
        beetleId.isAcceptableOrUnknown(data['beetle_id']!, _beetleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_beetleIdMeta);
    }
    if (data.containsKey('measured_at')) {
      context.handle(
        _measuredAtMeta,
        measuredAt.isAcceptableOrUnknown(data['measured_at']!, _measuredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('weight_grams')) {
      context.handle(
        _weightGramsMeta,
        weightGrams.isAcceptableOrUnknown(
          data['weight_grams']!,
          _weightGramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weightGramsMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightRecordRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      beetleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}beetle_id'],
          )!,
      measuredAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}measured_at'],
          )!,
      weightGrams:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}weight_grams'],
          )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $WeightRecordsTable createAlias(String alias) {
    return $WeightRecordsTable(attachedDatabase, alias);
  }
}

class WeightRecordRow extends DataClass implements Insertable<WeightRecordRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String beetleId;
  final DateTime measuredAt;
  final double weightGrams;
  final String? notes;
  const WeightRecordRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.beetleId,
    required this.measuredAt,
    required this.weightGrams,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    map['beetle_id'] = Variable<String>(beetleId);
    map['measured_at'] = Variable<DateTime>(measuredAt);
    map['weight_grams'] = Variable<double>(weightGrams);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WeightRecordsCompanion toCompanion(bool nullToAbsent) {
    return WeightRecordsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      beetleId: Value(beetleId),
      measuredAt: Value(measuredAt),
      weightGrams: Value(weightGrams),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory WeightRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightRecordRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      beetleId: serializer.fromJson<String>(json['beetleId']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
      weightGrams: serializer.fromJson<double>(json['weightGrams']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'beetleId': serializer.toJson<String>(beetleId),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'weightGrams': serializer.toJson<double>(weightGrams),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WeightRecordRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    String? beetleId,
    DateTime? measuredAt,
    double? weightGrams,
    Value<String?> notes = const Value.absent(),
  }) => WeightRecordRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    beetleId: beetleId ?? this.beetleId,
    measuredAt: measuredAt ?? this.measuredAt,
    weightGrams: weightGrams ?? this.weightGrams,
    notes: notes.present ? notes.value : this.notes,
  );
  WeightRecordRow copyWithCompanion(WeightRecordsCompanion data) {
    return WeightRecordRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      beetleId: data.beetleId.present ? data.beetleId.value : this.beetleId,
      measuredAt:
          data.measuredAt.present ? data.measuredAt.value : this.measuredAt,
      weightGrams:
          data.weightGrams.present ? data.weightGrams.value : this.weightGrams,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightRecordRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('weightGrams: $weightGrams, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    measuredAt,
    weightGrams,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightRecordRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.beetleId == this.beetleId &&
          other.measuredAt == this.measuredAt &&
          other.weightGrams == this.weightGrams &&
          other.notes == this.notes);
}

class WeightRecordsCompanion extends UpdateCompanion<WeightRecordRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String> beetleId;
  final Value<DateTime> measuredAt;
  final Value<double> weightGrams;
  final Value<String?> notes;
  final Value<int> rowid;
  const WeightRecordsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.weightGrams = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeightRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required String beetleId,
    required DateTime measuredAt,
    required double weightGrams,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : beetleId = Value(beetleId),
       measuredAt = Value(measuredAt),
       weightGrams = Value(weightGrams);
  static Insertable<WeightRecordRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? beetleId,
    Expression<DateTime>? measuredAt,
    Expression<double>? weightGrams,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (beetleId != null) 'beetle_id': beetleId,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (weightGrams != null) 'weight_grams': weightGrams,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeightRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String>? beetleId,
    Value<DateTime>? measuredAt,
    Value<double>? weightGrams,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return WeightRecordsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      beetleId: beetleId ?? this.beetleId,
      measuredAt: measuredAt ?? this.measuredAt,
      weightGrams: weightGrams ?? this.weightGrams,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (beetleId.present) {
      map['beetle_id'] = Variable<String>(beetleId.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    if (weightGrams.present) {
      map['weight_grams'] = Variable<double>(weightGrams.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightRecordsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('weightGrams: $weightGrams, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ObservationRecordsTable extends ObservationRecords
    with TableInfo<$ObservationRecordsTable, ObservationRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObservationRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _beetleIdMeta = const VerificationMeta(
    'beetleId',
  );
  @override
  late final GeneratedColumn<String> beetleId = GeneratedColumn<String>(
    'beetle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _observedAtMeta = const VerificationMeta(
    'observedAt',
  );
  @override
  late final GeneratedColumn<DateTime> observedAt = GeneratedColumn<DateTime>(
    'observed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ObservationCategory, String>
  category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('general'),
  ).withConverter<ObservationCategory>(
    $ObservationRecordsTable.$convertercategory,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 4000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    observedAt,
    category,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'observation_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ObservationRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('beetle_id')) {
      context.handle(
        _beetleIdMeta,
        beetleId.isAcceptableOrUnknown(data['beetle_id']!, _beetleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_beetleIdMeta);
    }
    if (data.containsKey('observed_at')) {
      context.handle(
        _observedAtMeta,
        observedAt.isAcceptableOrUnknown(data['observed_at']!, _observedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_observedAtMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ObservationRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ObservationRecordRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      beetleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}beetle_id'],
          )!,
      observedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}observed_at'],
          )!,
      category: $ObservationRecordsTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
    );
  }

  @override
  $ObservationRecordsTable createAlias(String alias) {
    return $ObservationRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ObservationCategory, String, String>
  $convertercategory = const EnumNameConverter<ObservationCategory>(
    ObservationCategory.values,
  );
}

class ObservationRecordRow extends DataClass
    implements Insertable<ObservationRecordRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String beetleId;
  final DateTime observedAt;
  final ObservationCategory category;
  final String description;
  const ObservationRecordRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.beetleId,
    required this.observedAt,
    required this.category,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    map['beetle_id'] = Variable<String>(beetleId);
    map['observed_at'] = Variable<DateTime>(observedAt);
    {
      map['category'] = Variable<String>(
        $ObservationRecordsTable.$convertercategory.toSql(category),
      );
    }
    map['description'] = Variable<String>(description);
    return map;
  }

  ObservationRecordsCompanion toCompanion(bool nullToAbsent) {
    return ObservationRecordsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      beetleId: Value(beetleId),
      observedAt: Value(observedAt),
      category: Value(category),
      description: Value(description),
    );
  }

  factory ObservationRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ObservationRecordRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      beetleId: serializer.fromJson<String>(json['beetleId']),
      observedAt: serializer.fromJson<DateTime>(json['observedAt']),
      category: $ObservationRecordsTable.$convertercategory.fromJson(
        serializer.fromJson<String>(json['category']),
      ),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'beetleId': serializer.toJson<String>(beetleId),
      'observedAt': serializer.toJson<DateTime>(observedAt),
      'category': serializer.toJson<String>(
        $ObservationRecordsTable.$convertercategory.toJson(category),
      ),
      'description': serializer.toJson<String>(description),
    };
  }

  ObservationRecordRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    String? beetleId,
    DateTime? observedAt,
    ObservationCategory? category,
    String? description,
  }) => ObservationRecordRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    beetleId: beetleId ?? this.beetleId,
    observedAt: observedAt ?? this.observedAt,
    category: category ?? this.category,
    description: description ?? this.description,
  );
  ObservationRecordRow copyWithCompanion(ObservationRecordsCompanion data) {
    return ObservationRecordRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      beetleId: data.beetleId.present ? data.beetleId.value : this.beetleId,
      observedAt:
          data.observedAt.present ? data.observedAt.value : this.observedAt,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ObservationRecordRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('observedAt: $observedAt, ')
          ..write('category: $category, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    observedAt,
    category,
    description,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ObservationRecordRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.beetleId == this.beetleId &&
          other.observedAt == this.observedAt &&
          other.category == this.category &&
          other.description == this.description);
}

class ObservationRecordsCompanion
    extends UpdateCompanion<ObservationRecordRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String> beetleId;
  final Value<DateTime> observedAt;
  final Value<ObservationCategory> category;
  final Value<String> description;
  final Value<int> rowid;
  const ObservationRecordsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.observedAt = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ObservationRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required String beetleId,
    required DateTime observedAt,
    this.category = const Value.absent(),
    required String description,
    this.rowid = const Value.absent(),
  }) : beetleId = Value(beetleId),
       observedAt = Value(observedAt),
       description = Value(description);
  static Insertable<ObservationRecordRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? beetleId,
    Expression<DateTime>? observedAt,
    Expression<String>? category,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (beetleId != null) 'beetle_id': beetleId,
      if (observedAt != null) 'observed_at': observedAt,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ObservationRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String>? beetleId,
    Value<DateTime>? observedAt,
    Value<ObservationCategory>? category,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return ObservationRecordsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      beetleId: beetleId ?? this.beetleId,
      observedAt: observedAt ?? this.observedAt,
      category: category ?? this.category,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (beetleId.present) {
      map['beetle_id'] = Variable<String>(beetleId.value);
    }
    if (observedAt.present) {
      map['observed_at'] = Variable<DateTime>(observedAt.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $ObservationRecordsTable.$convertercategory.toSql(category.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObservationRecordsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('observedAt: $observedAt, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TemperatureRecordsTable extends TemperatureRecords
    with TableInfo<$TemperatureRecordsTable, TemperatureRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemperatureRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _sensorIdMeta = const VerificationMeta(
    'sensorId',
  );
  @override
  late final GeneratedColumn<String> sensorId = GeneratedColumn<String>(
    'sensor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES temperature_sensors (id)',
    ),
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _celsiusMeta = const VerificationMeta(
    'celsius',
  );
  @override
  late final GeneratedColumn<double> celsius = GeneratedColumn<double>(
    'celsius',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TemperatureSource, String>
  source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  ).withConverter<TemperatureSource>($TemperatureRecordsTable.$convertersource);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    sensorId,
    recordedAt,
    celsius,
    source,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'temperature_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemperatureRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('sensor_id')) {
      context.handle(
        _sensorIdMeta,
        sensorId.isAcceptableOrUnknown(data['sensor_id']!, _sensorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sensorIdMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('celsius')) {
      context.handle(
        _celsiusMeta,
        celsius.isAcceptableOrUnknown(data['celsius']!, _celsiusMeta),
      );
    } else if (isInserting) {
      context.missing(_celsiusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemperatureRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemperatureRecordRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      sensorId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}sensor_id'],
          )!,
      recordedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}recorded_at'],
          )!,
      celsius:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}celsius'],
          )!,
      source: $TemperatureRecordsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $TemperatureRecordsTable createAlias(String alias) {
    return $TemperatureRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TemperatureSource, String, String>
  $convertersource = const EnumNameConverter<TemperatureSource>(
    TemperatureSource.values,
  );
}

class TemperatureRecordRow extends DataClass
    implements Insertable<TemperatureRecordRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String sensorId;
  final DateTime recordedAt;
  final double celsius;
  final TemperatureSource source;
  final String? notes;
  const TemperatureRecordRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.sensorId,
    required this.recordedAt,
    required this.celsius,
    required this.source,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    map['sensor_id'] = Variable<String>(sensorId);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['celsius'] = Variable<double>(celsius);
    {
      map['source'] = Variable<String>(
        $TemperatureRecordsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  TemperatureRecordsCompanion toCompanion(bool nullToAbsent) {
    return TemperatureRecordsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      sensorId: Value(sensorId),
      recordedAt: Value(recordedAt),
      celsius: Value(celsius),
      source: Value(source),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory TemperatureRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemperatureRecordRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      sensorId: serializer.fromJson<String>(json['sensorId']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      celsius: serializer.fromJson<double>(json['celsius']),
      source: $TemperatureRecordsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'sensorId': serializer.toJson<String>(sensorId),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'celsius': serializer.toJson<double>(celsius),
      'source': serializer.toJson<String>(
        $TemperatureRecordsTable.$convertersource.toJson(source),
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  TemperatureRecordRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    String? sensorId,
    DateTime? recordedAt,
    double? celsius,
    TemperatureSource? source,
    Value<String?> notes = const Value.absent(),
  }) => TemperatureRecordRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    sensorId: sensorId ?? this.sensorId,
    recordedAt: recordedAt ?? this.recordedAt,
    celsius: celsius ?? this.celsius,
    source: source ?? this.source,
    notes: notes.present ? notes.value : this.notes,
  );
  TemperatureRecordRow copyWithCompanion(TemperatureRecordsCompanion data) {
    return TemperatureRecordRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      sensorId: data.sensorId.present ? data.sensorId.value : this.sensorId,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      celsius: data.celsius.present ? data.celsius.value : this.celsius,
      source: data.source.present ? data.source.value : this.source,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemperatureRecordRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('sensorId: $sensorId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('celsius: $celsius, ')
          ..write('source: $source, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    sensorId,
    recordedAt,
    celsius,
    source,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemperatureRecordRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.sensorId == this.sensorId &&
          other.recordedAt == this.recordedAt &&
          other.celsius == this.celsius &&
          other.source == this.source &&
          other.notes == this.notes);
}

class TemperatureRecordsCompanion
    extends UpdateCompanion<TemperatureRecordRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String> sensorId;
  final Value<DateTime> recordedAt;
  final Value<double> celsius;
  final Value<TemperatureSource> source;
  final Value<String?> notes;
  final Value<int> rowid;
  const TemperatureRecordsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.sensorId = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.celsius = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemperatureRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required String sensorId,
    required DateTime recordedAt,
    required double celsius,
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sensorId = Value(sensorId),
       recordedAt = Value(recordedAt),
       celsius = Value(celsius);
  static Insertable<TemperatureRecordRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? sensorId,
    Expression<DateTime>? recordedAt,
    Expression<double>? celsius,
    Expression<String>? source,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (sensorId != null) 'sensor_id': sensorId,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (celsius != null) 'celsius': celsius,
      if (source != null) 'source': source,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemperatureRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String>? sensorId,
    Value<DateTime>? recordedAt,
    Value<double>? celsius,
    Value<TemperatureSource>? source,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return TemperatureRecordsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      sensorId: sensorId ?? this.sensorId,
      recordedAt: recordedAt ?? this.recordedAt,
      celsius: celsius ?? this.celsius,
      source: source ?? this.source,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (sensorId.present) {
      map['sensor_id'] = Variable<String>(sensorId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (celsius.present) {
      map['celsius'] = Variable<double>(celsius.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $TemperatureRecordsTable.$convertersource.toSql(source.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemperatureRecordsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('sensorId: $sensorId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('celsius: $celsius, ')
          ..write('source: $source, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubstrateChangesTable extends SubstrateChanges
    with TableInfo<$SubstrateChangesTable, SubstrateChangeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubstrateChangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _beetleIdMeta = const VerificationMeta(
    'beetleId',
  );
  @override
  late final GeneratedColumn<String> beetleId = GeneratedColumn<String>(
    'beetle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _substrateTypeMeta = const VerificationMeta(
    'substrateType',
  );
  @override
  late final GeneratedColumn<String> substrateType = GeneratedColumn<String>(
    'substrate_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _batchMeta = const VerificationMeta('batch');
  @override
  late final GeneratedColumn<String> batch = GeneratedColumn<String>(
    'batch',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityLitersMeta = const VerificationMeta(
    'quantityLiters',
  );
  @override
  late final GeneratedColumn<double> quantityLiters = GeneratedColumn<double>(
    'quantity_liters',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _beetleWeightGramsMeta = const VerificationMeta(
    'beetleWeightGrams',
  );
  @override
  late final GeneratedColumn<double> beetleWeightGrams =
      GeneratedColumn<double>(
        'beetle_weight_grams',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextPlannedAtMeta = const VerificationMeta(
    'nextPlannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextPlannedAt =
      GeneratedColumn<DateTime>(
        'next_planned_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    changedAt,
    substrateType,
    brand,
    batch,
    quantityLiters,
    beetleWeightGrams,
    condition,
    nextPlannedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'substrate_changes';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubstrateChangeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('beetle_id')) {
      context.handle(
        _beetleIdMeta,
        beetleId.isAcceptableOrUnknown(data['beetle_id']!, _beetleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_beetleIdMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    if (data.containsKey('substrate_type')) {
      context.handle(
        _substrateTypeMeta,
        substrateType.isAcceptableOrUnknown(
          data['substrate_type']!,
          _substrateTypeMeta,
        ),
      );
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('batch')) {
      context.handle(
        _batchMeta,
        batch.isAcceptableOrUnknown(data['batch']!, _batchMeta),
      );
    }
    if (data.containsKey('quantity_liters')) {
      context.handle(
        _quantityLitersMeta,
        quantityLiters.isAcceptableOrUnknown(
          data['quantity_liters']!,
          _quantityLitersMeta,
        ),
      );
    }
    if (data.containsKey('beetle_weight_grams')) {
      context.handle(
        _beetleWeightGramsMeta,
        beetleWeightGrams.isAcceptableOrUnknown(
          data['beetle_weight_grams']!,
          _beetleWeightGramsMeta,
        ),
      );
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    }
    if (data.containsKey('next_planned_at')) {
      context.handle(
        _nextPlannedAtMeta,
        nextPlannedAt.isAcceptableOrUnknown(
          data['next_planned_at']!,
          _nextPlannedAtMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubstrateChangeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubstrateChangeRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      beetleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}beetle_id'],
          )!,
      changedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}changed_at'],
          )!,
      substrateType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}substrate_type'],
      ),
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      batch: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch'],
      ),
      quantityLiters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_liters'],
      ),
      beetleWeightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}beetle_weight_grams'],
      ),
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      ),
      nextPlannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_planned_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $SubstrateChangesTable createAlias(String alias) {
    return $SubstrateChangesTable(attachedDatabase, alias);
  }
}

class SubstrateChangeRow extends DataClass
    implements Insertable<SubstrateChangeRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String beetleId;
  final DateTime changedAt;
  final String? substrateType;
  final String? brand;
  final String? batch;
  final double? quantityLiters;
  final double? beetleWeightGrams;
  final String? condition;
  final DateTime? nextPlannedAt;
  final String? notes;
  const SubstrateChangeRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.beetleId,
    required this.changedAt,
    this.substrateType,
    this.brand,
    this.batch,
    this.quantityLiters,
    this.beetleWeightGrams,
    this.condition,
    this.nextPlannedAt,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    map['beetle_id'] = Variable<String>(beetleId);
    map['changed_at'] = Variable<DateTime>(changedAt);
    if (!nullToAbsent || substrateType != null) {
      map['substrate_type'] = Variable<String>(substrateType);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || batch != null) {
      map['batch'] = Variable<String>(batch);
    }
    if (!nullToAbsent || quantityLiters != null) {
      map['quantity_liters'] = Variable<double>(quantityLiters);
    }
    if (!nullToAbsent || beetleWeightGrams != null) {
      map['beetle_weight_grams'] = Variable<double>(beetleWeightGrams);
    }
    if (!nullToAbsent || condition != null) {
      map['condition'] = Variable<String>(condition);
    }
    if (!nullToAbsent || nextPlannedAt != null) {
      map['next_planned_at'] = Variable<DateTime>(nextPlannedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SubstrateChangesCompanion toCompanion(bool nullToAbsent) {
    return SubstrateChangesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      beetleId: Value(beetleId),
      changedAt: Value(changedAt),
      substrateType:
          substrateType == null && nullToAbsent
              ? const Value.absent()
              : Value(substrateType),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      batch:
          batch == null && nullToAbsent ? const Value.absent() : Value(batch),
      quantityLiters:
          quantityLiters == null && nullToAbsent
              ? const Value.absent()
              : Value(quantityLiters),
      beetleWeightGrams:
          beetleWeightGrams == null && nullToAbsent
              ? const Value.absent()
              : Value(beetleWeightGrams),
      condition:
          condition == null && nullToAbsent
              ? const Value.absent()
              : Value(condition),
      nextPlannedAt:
          nextPlannedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(nextPlannedAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory SubstrateChangeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubstrateChangeRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      beetleId: serializer.fromJson<String>(json['beetleId']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      substrateType: serializer.fromJson<String?>(json['substrateType']),
      brand: serializer.fromJson<String?>(json['brand']),
      batch: serializer.fromJson<String?>(json['batch']),
      quantityLiters: serializer.fromJson<double?>(json['quantityLiters']),
      beetleWeightGrams: serializer.fromJson<double?>(
        json['beetleWeightGrams'],
      ),
      condition: serializer.fromJson<String?>(json['condition']),
      nextPlannedAt: serializer.fromJson<DateTime?>(json['nextPlannedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'beetleId': serializer.toJson<String>(beetleId),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'substrateType': serializer.toJson<String?>(substrateType),
      'brand': serializer.toJson<String?>(brand),
      'batch': serializer.toJson<String?>(batch),
      'quantityLiters': serializer.toJson<double?>(quantityLiters),
      'beetleWeightGrams': serializer.toJson<double?>(beetleWeightGrams),
      'condition': serializer.toJson<String?>(condition),
      'nextPlannedAt': serializer.toJson<DateTime?>(nextPlannedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  SubstrateChangeRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    String? beetleId,
    DateTime? changedAt,
    Value<String?> substrateType = const Value.absent(),
    Value<String?> brand = const Value.absent(),
    Value<String?> batch = const Value.absent(),
    Value<double?> quantityLiters = const Value.absent(),
    Value<double?> beetleWeightGrams = const Value.absent(),
    Value<String?> condition = const Value.absent(),
    Value<DateTime?> nextPlannedAt = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => SubstrateChangeRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    beetleId: beetleId ?? this.beetleId,
    changedAt: changedAt ?? this.changedAt,
    substrateType:
        substrateType.present ? substrateType.value : this.substrateType,
    brand: brand.present ? brand.value : this.brand,
    batch: batch.present ? batch.value : this.batch,
    quantityLiters:
        quantityLiters.present ? quantityLiters.value : this.quantityLiters,
    beetleWeightGrams:
        beetleWeightGrams.present
            ? beetleWeightGrams.value
            : this.beetleWeightGrams,
    condition: condition.present ? condition.value : this.condition,
    nextPlannedAt:
        nextPlannedAt.present ? nextPlannedAt.value : this.nextPlannedAt,
    notes: notes.present ? notes.value : this.notes,
  );
  SubstrateChangeRow copyWithCompanion(SubstrateChangesCompanion data) {
    return SubstrateChangeRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      beetleId: data.beetleId.present ? data.beetleId.value : this.beetleId,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      substrateType:
          data.substrateType.present
              ? data.substrateType.value
              : this.substrateType,
      brand: data.brand.present ? data.brand.value : this.brand,
      batch: data.batch.present ? data.batch.value : this.batch,
      quantityLiters:
          data.quantityLiters.present
              ? data.quantityLiters.value
              : this.quantityLiters,
      beetleWeightGrams:
          data.beetleWeightGrams.present
              ? data.beetleWeightGrams.value
              : this.beetleWeightGrams,
      condition: data.condition.present ? data.condition.value : this.condition,
      nextPlannedAt:
          data.nextPlannedAt.present
              ? data.nextPlannedAt.value
              : this.nextPlannedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubstrateChangeRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('changedAt: $changedAt, ')
          ..write('substrateType: $substrateType, ')
          ..write('brand: $brand, ')
          ..write('batch: $batch, ')
          ..write('quantityLiters: $quantityLiters, ')
          ..write('beetleWeightGrams: $beetleWeightGrams, ')
          ..write('condition: $condition, ')
          ..write('nextPlannedAt: $nextPlannedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    changedAt,
    substrateType,
    brand,
    batch,
    quantityLiters,
    beetleWeightGrams,
    condition,
    nextPlannedAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubstrateChangeRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.beetleId == this.beetleId &&
          other.changedAt == this.changedAt &&
          other.substrateType == this.substrateType &&
          other.brand == this.brand &&
          other.batch == this.batch &&
          other.quantityLiters == this.quantityLiters &&
          other.beetleWeightGrams == this.beetleWeightGrams &&
          other.condition == this.condition &&
          other.nextPlannedAt == this.nextPlannedAt &&
          other.notes == this.notes);
}

class SubstrateChangesCompanion extends UpdateCompanion<SubstrateChangeRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String> beetleId;
  final Value<DateTime> changedAt;
  final Value<String?> substrateType;
  final Value<String?> brand;
  final Value<String?> batch;
  final Value<double?> quantityLiters;
  final Value<double?> beetleWeightGrams;
  final Value<String?> condition;
  final Value<DateTime?> nextPlannedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const SubstrateChangesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.substrateType = const Value.absent(),
    this.brand = const Value.absent(),
    this.batch = const Value.absent(),
    this.quantityLiters = const Value.absent(),
    this.beetleWeightGrams = const Value.absent(),
    this.condition = const Value.absent(),
    this.nextPlannedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubstrateChangesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required String beetleId,
    required DateTime changedAt,
    this.substrateType = const Value.absent(),
    this.brand = const Value.absent(),
    this.batch = const Value.absent(),
    this.quantityLiters = const Value.absent(),
    this.beetleWeightGrams = const Value.absent(),
    this.condition = const Value.absent(),
    this.nextPlannedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : beetleId = Value(beetleId),
       changedAt = Value(changedAt);
  static Insertable<SubstrateChangeRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? beetleId,
    Expression<DateTime>? changedAt,
    Expression<String>? substrateType,
    Expression<String>? brand,
    Expression<String>? batch,
    Expression<double>? quantityLiters,
    Expression<double>? beetleWeightGrams,
    Expression<String>? condition,
    Expression<DateTime>? nextPlannedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (beetleId != null) 'beetle_id': beetleId,
      if (changedAt != null) 'changed_at': changedAt,
      if (substrateType != null) 'substrate_type': substrateType,
      if (brand != null) 'brand': brand,
      if (batch != null) 'batch': batch,
      if (quantityLiters != null) 'quantity_liters': quantityLiters,
      if (beetleWeightGrams != null) 'beetle_weight_grams': beetleWeightGrams,
      if (condition != null) 'condition': condition,
      if (nextPlannedAt != null) 'next_planned_at': nextPlannedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubstrateChangesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String>? beetleId,
    Value<DateTime>? changedAt,
    Value<String?>? substrateType,
    Value<String?>? brand,
    Value<String?>? batch,
    Value<double?>? quantityLiters,
    Value<double?>? beetleWeightGrams,
    Value<String?>? condition,
    Value<DateTime?>? nextPlannedAt,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return SubstrateChangesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      beetleId: beetleId ?? this.beetleId,
      changedAt: changedAt ?? this.changedAt,
      substrateType: substrateType ?? this.substrateType,
      brand: brand ?? this.brand,
      batch: batch ?? this.batch,
      quantityLiters: quantityLiters ?? this.quantityLiters,
      beetleWeightGrams: beetleWeightGrams ?? this.beetleWeightGrams,
      condition: condition ?? this.condition,
      nextPlannedAt: nextPlannedAt ?? this.nextPlannedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (beetleId.present) {
      map['beetle_id'] = Variable<String>(beetleId.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (substrateType.present) {
      map['substrate_type'] = Variable<String>(substrateType.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (batch.present) {
      map['batch'] = Variable<String>(batch.value);
    }
    if (quantityLiters.present) {
      map['quantity_liters'] = Variable<double>(quantityLiters.value);
    }
    if (beetleWeightGrams.present) {
      map['beetle_weight_grams'] = Variable<double>(beetleWeightGrams.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (nextPlannedAt.present) {
      map['next_planned_at'] = Variable<DateTime>(nextPlannedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubstrateChangesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('changedAt: $changedAt, ')
          ..write('substrateType: $substrateType, ')
          ..write('brand: $brand, ')
          ..write('batch: $batch, ')
          ..write('quantityLiters: $quantityLiters, ')
          ..write('beetleWeightGrams: $beetleWeightGrams, ')
          ..write('condition: $condition, ')
          ..write('nextPlannedAt: $nextPlannedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContainerChangesTable extends ContainerChanges
    with TableInfo<$ContainerChangesTable, ContainerChangeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContainerChangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _beetleIdMeta = const VerificationMeta(
    'beetleId',
  );
  @override
  late final GeneratedColumn<String> beetleId = GeneratedColumn<String>(
    'beetle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousVolumeLitersMeta =
      const VerificationMeta('previousVolumeLiters');
  @override
  late final GeneratedColumn<double> previousVolumeLiters =
      GeneratedColumn<double>(
        'previous_volume_liters',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _newVolumeLitersMeta = const VerificationMeta(
    'newVolumeLiters',
  );
  @override
  late final GeneratedColumn<double> newVolumeLiters = GeneratedColumn<double>(
    'new_volume_liters',
    aliasedName,
    false,
    check: () => ComparableExpr(newVolumeLiters).isBiggerThanValue(0),
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _beetleWeightGramsMeta = const VerificationMeta(
    'beetleWeightGrams',
  );
  @override
  late final GeneratedColumn<double> beetleWeightGrams =
      GeneratedColumn<double>(
        'beetle_weight_grams',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    changedAt,
    previousVolumeLiters,
    newVolumeLiters,
    beetleWeightGrams,
    condition,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'container_changes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContainerChangeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('beetle_id')) {
      context.handle(
        _beetleIdMeta,
        beetleId.isAcceptableOrUnknown(data['beetle_id']!, _beetleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_beetleIdMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    if (data.containsKey('previous_volume_liters')) {
      context.handle(
        _previousVolumeLitersMeta,
        previousVolumeLiters.isAcceptableOrUnknown(
          data['previous_volume_liters']!,
          _previousVolumeLitersMeta,
        ),
      );
    }
    if (data.containsKey('new_volume_liters')) {
      context.handle(
        _newVolumeLitersMeta,
        newVolumeLiters.isAcceptableOrUnknown(
          data['new_volume_liters']!,
          _newVolumeLitersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_newVolumeLitersMeta);
    }
    if (data.containsKey('beetle_weight_grams')) {
      context.handle(
        _beetleWeightGramsMeta,
        beetleWeightGrams.isAcceptableOrUnknown(
          data['beetle_weight_grams']!,
          _beetleWeightGramsMeta,
        ),
      );
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContainerChangeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContainerChangeRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      beetleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}beetle_id'],
          )!,
      changedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}changed_at'],
          )!,
      previousVolumeLiters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}previous_volume_liters'],
      ),
      newVolumeLiters:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}new_volume_liters'],
          )!,
      beetleWeightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}beetle_weight_grams'],
      ),
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ContainerChangesTable createAlias(String alias) {
    return $ContainerChangesTable(attachedDatabase, alias);
  }
}

class ContainerChangeRow extends DataClass
    implements Insertable<ContainerChangeRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String beetleId;
  final DateTime changedAt;
  final double? previousVolumeLiters;
  final double newVolumeLiters;
  final double? beetleWeightGrams;
  final String? condition;
  final String? notes;
  const ContainerChangeRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.beetleId,
    required this.changedAt,
    this.previousVolumeLiters,
    required this.newVolumeLiters,
    this.beetleWeightGrams,
    this.condition,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    map['beetle_id'] = Variable<String>(beetleId);
    map['changed_at'] = Variable<DateTime>(changedAt);
    if (!nullToAbsent || previousVolumeLiters != null) {
      map['previous_volume_liters'] = Variable<double>(previousVolumeLiters);
    }
    map['new_volume_liters'] = Variable<double>(newVolumeLiters);
    if (!nullToAbsent || beetleWeightGrams != null) {
      map['beetle_weight_grams'] = Variable<double>(beetleWeightGrams);
    }
    if (!nullToAbsent || condition != null) {
      map['condition'] = Variable<String>(condition);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ContainerChangesCompanion toCompanion(bool nullToAbsent) {
    return ContainerChangesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      beetleId: Value(beetleId),
      changedAt: Value(changedAt),
      previousVolumeLiters:
          previousVolumeLiters == null && nullToAbsent
              ? const Value.absent()
              : Value(previousVolumeLiters),
      newVolumeLiters: Value(newVolumeLiters),
      beetleWeightGrams:
          beetleWeightGrams == null && nullToAbsent
              ? const Value.absent()
              : Value(beetleWeightGrams),
      condition:
          condition == null && nullToAbsent
              ? const Value.absent()
              : Value(condition),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory ContainerChangeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContainerChangeRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      beetleId: serializer.fromJson<String>(json['beetleId']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      previousVolumeLiters: serializer.fromJson<double?>(
        json['previousVolumeLiters'],
      ),
      newVolumeLiters: serializer.fromJson<double>(json['newVolumeLiters']),
      beetleWeightGrams: serializer.fromJson<double?>(
        json['beetleWeightGrams'],
      ),
      condition: serializer.fromJson<String?>(json['condition']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'beetleId': serializer.toJson<String>(beetleId),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'previousVolumeLiters': serializer.toJson<double?>(previousVolumeLiters),
      'newVolumeLiters': serializer.toJson<double>(newVolumeLiters),
      'beetleWeightGrams': serializer.toJson<double?>(beetleWeightGrams),
      'condition': serializer.toJson<String?>(condition),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  ContainerChangeRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    String? beetleId,
    DateTime? changedAt,
    Value<double?> previousVolumeLiters = const Value.absent(),
    double? newVolumeLiters,
    Value<double?> beetleWeightGrams = const Value.absent(),
    Value<String?> condition = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => ContainerChangeRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    beetleId: beetleId ?? this.beetleId,
    changedAt: changedAt ?? this.changedAt,
    previousVolumeLiters:
        previousVolumeLiters.present
            ? previousVolumeLiters.value
            : this.previousVolumeLiters,
    newVolumeLiters: newVolumeLiters ?? this.newVolumeLiters,
    beetleWeightGrams:
        beetleWeightGrams.present
            ? beetleWeightGrams.value
            : this.beetleWeightGrams,
    condition: condition.present ? condition.value : this.condition,
    notes: notes.present ? notes.value : this.notes,
  );
  ContainerChangeRow copyWithCompanion(ContainerChangesCompanion data) {
    return ContainerChangeRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      beetleId: data.beetleId.present ? data.beetleId.value : this.beetleId,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      previousVolumeLiters:
          data.previousVolumeLiters.present
              ? data.previousVolumeLiters.value
              : this.previousVolumeLiters,
      newVolumeLiters:
          data.newVolumeLiters.present
              ? data.newVolumeLiters.value
              : this.newVolumeLiters,
      beetleWeightGrams:
          data.beetleWeightGrams.present
              ? data.beetleWeightGrams.value
              : this.beetleWeightGrams,
      condition: data.condition.present ? data.condition.value : this.condition,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContainerChangeRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('changedAt: $changedAt, ')
          ..write('previousVolumeLiters: $previousVolumeLiters, ')
          ..write('newVolumeLiters: $newVolumeLiters, ')
          ..write('beetleWeightGrams: $beetleWeightGrams, ')
          ..write('condition: $condition, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    changedAt,
    previousVolumeLiters,
    newVolumeLiters,
    beetleWeightGrams,
    condition,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContainerChangeRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.beetleId == this.beetleId &&
          other.changedAt == this.changedAt &&
          other.previousVolumeLiters == this.previousVolumeLiters &&
          other.newVolumeLiters == this.newVolumeLiters &&
          other.beetleWeightGrams == this.beetleWeightGrams &&
          other.condition == this.condition &&
          other.notes == this.notes);
}

class ContainerChangesCompanion extends UpdateCompanion<ContainerChangeRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String> beetleId;
  final Value<DateTime> changedAt;
  final Value<double?> previousVolumeLiters;
  final Value<double> newVolumeLiters;
  final Value<double?> beetleWeightGrams;
  final Value<String?> condition;
  final Value<String?> notes;
  final Value<int> rowid;
  const ContainerChangesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.previousVolumeLiters = const Value.absent(),
    this.newVolumeLiters = const Value.absent(),
    this.beetleWeightGrams = const Value.absent(),
    this.condition = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContainerChangesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required String beetleId,
    required DateTime changedAt,
    this.previousVolumeLiters = const Value.absent(),
    required double newVolumeLiters,
    this.beetleWeightGrams = const Value.absent(),
    this.condition = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : beetleId = Value(beetleId),
       changedAt = Value(changedAt),
       newVolumeLiters = Value(newVolumeLiters);
  static Insertable<ContainerChangeRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? beetleId,
    Expression<DateTime>? changedAt,
    Expression<double>? previousVolumeLiters,
    Expression<double>? newVolumeLiters,
    Expression<double>? beetleWeightGrams,
    Expression<String>? condition,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (beetleId != null) 'beetle_id': beetleId,
      if (changedAt != null) 'changed_at': changedAt,
      if (previousVolumeLiters != null)
        'previous_volume_liters': previousVolumeLiters,
      if (newVolumeLiters != null) 'new_volume_liters': newVolumeLiters,
      if (beetleWeightGrams != null) 'beetle_weight_grams': beetleWeightGrams,
      if (condition != null) 'condition': condition,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContainerChangesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String>? beetleId,
    Value<DateTime>? changedAt,
    Value<double?>? previousVolumeLiters,
    Value<double>? newVolumeLiters,
    Value<double?>? beetleWeightGrams,
    Value<String?>? condition,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return ContainerChangesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      beetleId: beetleId ?? this.beetleId,
      changedAt: changedAt ?? this.changedAt,
      previousVolumeLiters: previousVolumeLiters ?? this.previousVolumeLiters,
      newVolumeLiters: newVolumeLiters ?? this.newVolumeLiters,
      beetleWeightGrams: beetleWeightGrams ?? this.beetleWeightGrams,
      condition: condition ?? this.condition,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (beetleId.present) {
      map['beetle_id'] = Variable<String>(beetleId.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (previousVolumeLiters.present) {
      map['previous_volume_liters'] = Variable<double>(
        previousVolumeLiters.value,
      );
    }
    if (newVolumeLiters.present) {
      map['new_volume_liters'] = Variable<double>(newVolumeLiters.value);
    }
    if (beetleWeightGrams.present) {
      map['beetle_weight_grams'] = Variable<double>(beetleWeightGrams.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContainerChangesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('changedAt: $changedAt, ')
          ..write('previousVolumeLiters: $previousVolumeLiters, ')
          ..write('newVolumeLiters: $newVolumeLiters, ')
          ..write('beetleWeightGrams: $beetleWeightGrams, ')
          ..write('condition: $condition, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LifeStageEventsTable extends LifeStageEvents
    with TableInfo<$LifeStageEventsTable, LifeStageEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LifeStageEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _beetleIdMeta = const VerificationMeta(
    'beetleId',
  );
  @override
  late final GeneratedColumn<String> beetleId = GeneratedColumn<String>(
    'beetle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LifeStage, String> stage =
      GeneratedColumn<String>(
        'stage',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LifeStage>($LifeStageEventsTable.$converterstage);
  @override
  late final GeneratedColumnWithTypeConverter<L3Phase?, String> l3Phase =
      GeneratedColumn<String>(
        'l3_phase',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<L3Phase?>($LifeStageEventsTable.$converterl3Phasen);
  static const VerificationMeta _isEstimatedMeta = const VerificationMeta(
    'isEstimated',
  );
  @override
  late final GeneratedColumn<bool> isEstimated = GeneratedColumn<bool>(
    'is_estimated',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_estimated" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    occurredAt,
    stage,
    l3Phase,
    isEstimated,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'life_stage_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<LifeStageEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('beetle_id')) {
      context.handle(
        _beetleIdMeta,
        beetleId.isAcceptableOrUnknown(data['beetle_id']!, _beetleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_beetleIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('is_estimated')) {
      context.handle(
        _isEstimatedMeta,
        isEstimated.isAcceptableOrUnknown(
          data['is_estimated']!,
          _isEstimatedMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LifeStageEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LifeStageEventRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      beetleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}beetle_id'],
          )!,
      occurredAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}occurred_at'],
          )!,
      stage: $LifeStageEventsTable.$converterstage.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}stage'],
        )!,
      ),
      l3Phase: $LifeStageEventsTable.$converterl3Phasen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}l3_phase'],
        ),
      ),
      isEstimated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_estimated'],
          )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $LifeStageEventsTable createAlias(String alias) {
    return $LifeStageEventsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LifeStage, String, String> $converterstage =
      const EnumNameConverter<LifeStage>(LifeStage.values);
  static JsonTypeConverter2<L3Phase, String, String> $converterl3Phase =
      const EnumNameConverter<L3Phase>(L3Phase.values);
  static JsonTypeConverter2<L3Phase?, String?, String?> $converterl3Phasen =
      JsonTypeConverter2.asNullable($converterl3Phase);
}

class LifeStageEventRow extends DataClass
    implements Insertable<LifeStageEventRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String beetleId;
  final DateTime occurredAt;
  final LifeStage stage;
  final L3Phase? l3Phase;

  /// True when the user is unsure of the exact date of the transition.
  final bool isEstimated;
  final String? notes;
  const LifeStageEventRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.beetleId,
    required this.occurredAt,
    required this.stage,
    this.l3Phase,
    required this.isEstimated,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    map['beetle_id'] = Variable<String>(beetleId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    {
      map['stage'] = Variable<String>(
        $LifeStageEventsTable.$converterstage.toSql(stage),
      );
    }
    if (!nullToAbsent || l3Phase != null) {
      map['l3_phase'] = Variable<String>(
        $LifeStageEventsTable.$converterl3Phasen.toSql(l3Phase),
      );
    }
    map['is_estimated'] = Variable<bool>(isEstimated);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  LifeStageEventsCompanion toCompanion(bool nullToAbsent) {
    return LifeStageEventsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      beetleId: Value(beetleId),
      occurredAt: Value(occurredAt),
      stage: Value(stage),
      l3Phase:
          l3Phase == null && nullToAbsent
              ? const Value.absent()
              : Value(l3Phase),
      isEstimated: Value(isEstimated),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory LifeStageEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LifeStageEventRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      beetleId: serializer.fromJson<String>(json['beetleId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      stage: $LifeStageEventsTable.$converterstage.fromJson(
        serializer.fromJson<String>(json['stage']),
      ),
      l3Phase: $LifeStageEventsTable.$converterl3Phasen.fromJson(
        serializer.fromJson<String?>(json['l3Phase']),
      ),
      isEstimated: serializer.fromJson<bool>(json['isEstimated']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'beetleId': serializer.toJson<String>(beetleId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'stage': serializer.toJson<String>(
        $LifeStageEventsTable.$converterstage.toJson(stage),
      ),
      'l3Phase': serializer.toJson<String?>(
        $LifeStageEventsTable.$converterl3Phasen.toJson(l3Phase),
      ),
      'isEstimated': serializer.toJson<bool>(isEstimated),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  LifeStageEventRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    String? beetleId,
    DateTime? occurredAt,
    LifeStage? stage,
    Value<L3Phase?> l3Phase = const Value.absent(),
    bool? isEstimated,
    Value<String?> notes = const Value.absent(),
  }) => LifeStageEventRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    beetleId: beetleId ?? this.beetleId,
    occurredAt: occurredAt ?? this.occurredAt,
    stage: stage ?? this.stage,
    l3Phase: l3Phase.present ? l3Phase.value : this.l3Phase,
    isEstimated: isEstimated ?? this.isEstimated,
    notes: notes.present ? notes.value : this.notes,
  );
  LifeStageEventRow copyWithCompanion(LifeStageEventsCompanion data) {
    return LifeStageEventRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      beetleId: data.beetleId.present ? data.beetleId.value : this.beetleId,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      stage: data.stage.present ? data.stage.value : this.stage,
      l3Phase: data.l3Phase.present ? data.l3Phase.value : this.l3Phase,
      isEstimated:
          data.isEstimated.present ? data.isEstimated.value : this.isEstimated,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LifeStageEventRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('stage: $stage, ')
          ..write('l3Phase: $l3Phase, ')
          ..write('isEstimated: $isEstimated, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    occurredAt,
    stage,
    l3Phase,
    isEstimated,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LifeStageEventRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.beetleId == this.beetleId &&
          other.occurredAt == this.occurredAt &&
          other.stage == this.stage &&
          other.l3Phase == this.l3Phase &&
          other.isEstimated == this.isEstimated &&
          other.notes == this.notes);
}

class LifeStageEventsCompanion extends UpdateCompanion<LifeStageEventRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String> beetleId;
  final Value<DateTime> occurredAt;
  final Value<LifeStage> stage;
  final Value<L3Phase?> l3Phase;
  final Value<bool> isEstimated;
  final Value<String?> notes;
  final Value<int> rowid;
  const LifeStageEventsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.stage = const Value.absent(),
    this.l3Phase = const Value.absent(),
    this.isEstimated = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LifeStageEventsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required String beetleId,
    required DateTime occurredAt,
    required LifeStage stage,
    this.l3Phase = const Value.absent(),
    this.isEstimated = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : beetleId = Value(beetleId),
       occurredAt = Value(occurredAt),
       stage = Value(stage);
  static Insertable<LifeStageEventRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? beetleId,
    Expression<DateTime>? occurredAt,
    Expression<String>? stage,
    Expression<String>? l3Phase,
    Expression<bool>? isEstimated,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (beetleId != null) 'beetle_id': beetleId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (stage != null) 'stage': stage,
      if (l3Phase != null) 'l3_phase': l3Phase,
      if (isEstimated != null) 'is_estimated': isEstimated,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LifeStageEventsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String>? beetleId,
    Value<DateTime>? occurredAt,
    Value<LifeStage>? stage,
    Value<L3Phase?>? l3Phase,
    Value<bool>? isEstimated,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return LifeStageEventsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      beetleId: beetleId ?? this.beetleId,
      occurredAt: occurredAt ?? this.occurredAt,
      stage: stage ?? this.stage,
      l3Phase: l3Phase ?? this.l3Phase,
      isEstimated: isEstimated ?? this.isEstimated,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (beetleId.present) {
      map['beetle_id'] = Variable<String>(beetleId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(
        $LifeStageEventsTable.$converterstage.toSql(stage.value),
      );
    }
    if (l3Phase.present) {
      map['l3_phase'] = Variable<String>(
        $LifeStageEventsTable.$converterl3Phasen.toSql(l3Phase.value),
      );
    }
    if (isEstimated.present) {
      map['is_estimated'] = Variable<bool>(isEstimated.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LifeStageEventsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('stage: $stage, ')
          ..write('l3Phase: $l3Phase, ')
          ..write('isEstimated: $isEstimated, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotoAttachmentsTable extends PhotoAttachments
    with TableInfo<$PhotoAttachmentsTable, PhotoAttachmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoAttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PhotoOwnerType, String>
  ownerType = GeneratedColumn<String>(
    'owner_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<PhotoOwnerType>($PhotoAttachmentsTable.$converterownerType);
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _beetleIdMeta = const VerificationMeta(
    'beetleId',
  );
  @override
  late final GeneratedColumn<String> beetleId = GeneratedColumn<String>(
    'beetle_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 64,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    ownerType,
    ownerId,
    beetleId,
    relativePath,
    sha256,
    takenAt,
    caption,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotoAttachmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('beetle_id')) {
      context.handle(
        _beetleIdMeta,
        beetleId.isAcceptableOrUnknown(data['beetle_id']!, _beetleIdMeta),
      );
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhotoAttachmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoAttachmentRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      ownerType: $PhotoAttachmentsTable.$converterownerType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}owner_type'],
        )!,
      ),
      ownerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}owner_id'],
          )!,
      beetleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beetle_id'],
      ),
      relativePath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}relative_path'],
          )!,
      sha256:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}sha256'],
          )!,
      takenAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}taken_at'],
          )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
    );
  }

  @override
  $PhotoAttachmentsTable createAlias(String alias) {
    return $PhotoAttachmentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PhotoOwnerType, String, String>
  $converterownerType = const EnumNameConverter<PhotoOwnerType>(
    PhotoOwnerType.values,
  );
}

class PhotoAttachmentRow extends DataClass
    implements Insertable<PhotoAttachmentRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final PhotoOwnerType ownerType;

  /// ID of the record this photo belongs to (polymorphic, see [ownerType]).
  final String ownerId;
  final String? beetleId;

  /// Path relative to the app documents directory (e.g. `photos/<uuid>.jpg`).
  final String relativePath;
  final String sha256;
  final DateTime takenAt;
  final String? caption;
  const PhotoAttachmentRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.ownerType,
    required this.ownerId,
    this.beetleId,
    required this.relativePath,
    required this.sha256,
    required this.takenAt,
    this.caption,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    {
      map['owner_type'] = Variable<String>(
        $PhotoAttachmentsTable.$converterownerType.toSql(ownerType),
      );
    }
    map['owner_id'] = Variable<String>(ownerId);
    if (!nullToAbsent || beetleId != null) {
      map['beetle_id'] = Variable<String>(beetleId);
    }
    map['relative_path'] = Variable<String>(relativePath);
    map['sha256'] = Variable<String>(sha256);
    map['taken_at'] = Variable<DateTime>(takenAt);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    return map;
  }

  PhotoAttachmentsCompanion toCompanion(bool nullToAbsent) {
    return PhotoAttachmentsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      ownerType: Value(ownerType),
      ownerId: Value(ownerId),
      beetleId:
          beetleId == null && nullToAbsent
              ? const Value.absent()
              : Value(beetleId),
      relativePath: Value(relativePath),
      sha256: Value(sha256),
      takenAt: Value(takenAt),
      caption:
          caption == null && nullToAbsent
              ? const Value.absent()
              : Value(caption),
    );
  }

  factory PhotoAttachmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoAttachmentRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      ownerType: $PhotoAttachmentsTable.$converterownerType.fromJson(
        serializer.fromJson<String>(json['ownerType']),
      ),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      beetleId: serializer.fromJson<String?>(json['beetleId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      sha256: serializer.fromJson<String>(json['sha256']),
      takenAt: serializer.fromJson<DateTime>(json['takenAt']),
      caption: serializer.fromJson<String?>(json['caption']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'ownerType': serializer.toJson<String>(
        $PhotoAttachmentsTable.$converterownerType.toJson(ownerType),
      ),
      'ownerId': serializer.toJson<String>(ownerId),
      'beetleId': serializer.toJson<String?>(beetleId),
      'relativePath': serializer.toJson<String>(relativePath),
      'sha256': serializer.toJson<String>(sha256),
      'takenAt': serializer.toJson<DateTime>(takenAt),
      'caption': serializer.toJson<String?>(caption),
    };
  }

  PhotoAttachmentRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    PhotoOwnerType? ownerType,
    String? ownerId,
    Value<String?> beetleId = const Value.absent(),
    String? relativePath,
    String? sha256,
    DateTime? takenAt,
    Value<String?> caption = const Value.absent(),
  }) => PhotoAttachmentRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    ownerType: ownerType ?? this.ownerType,
    ownerId: ownerId ?? this.ownerId,
    beetleId: beetleId.present ? beetleId.value : this.beetleId,
    relativePath: relativePath ?? this.relativePath,
    sha256: sha256 ?? this.sha256,
    takenAt: takenAt ?? this.takenAt,
    caption: caption.present ? caption.value : this.caption,
  );
  PhotoAttachmentRow copyWithCompanion(PhotoAttachmentsCompanion data) {
    return PhotoAttachmentRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      ownerType: data.ownerType.present ? data.ownerType.value : this.ownerType,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      beetleId: data.beetleId.present ? data.beetleId.value : this.beetleId,
      relativePath:
          data.relativePath.present
              ? data.relativePath.value
              : this.relativePath,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      caption: data.caption.present ? data.caption.value : this.caption,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoAttachmentRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('beetleId: $beetleId, ')
          ..write('relativePath: $relativePath, ')
          ..write('sha256: $sha256, ')
          ..write('takenAt: $takenAt, ')
          ..write('caption: $caption')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    ownerType,
    ownerId,
    beetleId,
    relativePath,
    sha256,
    takenAt,
    caption,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoAttachmentRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.ownerType == this.ownerType &&
          other.ownerId == this.ownerId &&
          other.beetleId == this.beetleId &&
          other.relativePath == this.relativePath &&
          other.sha256 == this.sha256 &&
          other.takenAt == this.takenAt &&
          other.caption == this.caption);
}

class PhotoAttachmentsCompanion extends UpdateCompanion<PhotoAttachmentRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<PhotoOwnerType> ownerType;
  final Value<String> ownerId;
  final Value<String?> beetleId;
  final Value<String> relativePath;
  final Value<String> sha256;
  final Value<DateTime> takenAt;
  final Value<String?> caption;
  final Value<int> rowid;
  const PhotoAttachmentsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.ownerType = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.caption = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoAttachmentsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required PhotoOwnerType ownerType,
    required String ownerId,
    this.beetleId = const Value.absent(),
    required String relativePath,
    required String sha256,
    required DateTime takenAt,
    this.caption = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : ownerType = Value(ownerType),
       ownerId = Value(ownerId),
       relativePath = Value(relativePath),
       sha256 = Value(sha256),
       takenAt = Value(takenAt);
  static Insertable<PhotoAttachmentRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? ownerType,
    Expression<String>? ownerId,
    Expression<String>? beetleId,
    Expression<String>? relativePath,
    Expression<String>? sha256,
    Expression<DateTime>? takenAt,
    Expression<String>? caption,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (ownerType != null) 'owner_type': ownerType,
      if (ownerId != null) 'owner_id': ownerId,
      if (beetleId != null) 'beetle_id': beetleId,
      if (relativePath != null) 'relative_path': relativePath,
      if (sha256 != null) 'sha256': sha256,
      if (takenAt != null) 'taken_at': takenAt,
      if (caption != null) 'caption': caption,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoAttachmentsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<PhotoOwnerType>? ownerType,
    Value<String>? ownerId,
    Value<String?>? beetleId,
    Value<String>? relativePath,
    Value<String>? sha256,
    Value<DateTime>? takenAt,
    Value<String?>? caption,
    Value<int>? rowid,
  }) {
    return PhotoAttachmentsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      ownerType: ownerType ?? this.ownerType,
      ownerId: ownerId ?? this.ownerId,
      beetleId: beetleId ?? this.beetleId,
      relativePath: relativePath ?? this.relativePath,
      sha256: sha256 ?? this.sha256,
      takenAt: takenAt ?? this.takenAt,
      caption: caption ?? this.caption,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (ownerType.present) {
      map['owner_type'] = Variable<String>(
        $PhotoAttachmentsTable.$converterownerType.toSql(ownerType.value),
      );
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (beetleId.present) {
      map['beetle_id'] = Variable<String>(beetleId.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoAttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('beetleId: $beetleId, ')
          ..write('relativePath: $relativePath, ')
          ..write('sha256: $sha256, ')
          ..write('takenAt: $takenAt, ')
          ..write('caption: $caption, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiAnalysesTable extends AiAnalyses
    with TableInfo<$AiAnalysesTable, AiAnalysisRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiAnalysesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _beetleIdMeta = const VerificationMeta(
    'beetleId',
  );
  @override
  late final GeneratedColumn<String> beetleId = GeneratedColumn<String>(
    'beetle_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AnalysisKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AnalysisKind>($AiAnalysesTable.$converterkind);
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _responseMeta = const VerificationMeta(
    'response',
  );
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
    'response',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectionsJsonMeta = const VerificationMeta(
    'sectionsJson',
  );
  @override
  late final GeneratedColumn<String> sectionsJson = GeneratedColumn<String>(
    'sections_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AnalysisFeedback?, String>
  feedback = GeneratedColumn<String>(
    'feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<AnalysisFeedback?>($AiAnalysesTable.$converterfeedbackn);
  @override
  late final GeneratedColumnWithTypeConverter<PredictionOutcome, String>
  outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('notApplicable'),
  ).withConverter<PredictionOutcome>($AiAnalysesTable.$converteroutcome);
  static const VerificationMeta _outcomeNoteMeta = const VerificationMeta(
    'outcomeNote',
  );
  @override
  late final GeneratedColumn<String> outcomeNote = GeneratedColumn<String>(
    'outcome_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    kind,
    provider,
    model,
    question,
    response,
    sectionsJson,
    feedback,
    outcome,
    outcomeNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_analyses';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiAnalysisRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('beetle_id')) {
      context.handle(
        _beetleIdMeta,
        beetleId.isAcceptableOrUnknown(data['beetle_id']!, _beetleIdMeta),
      );
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    }
    if (data.containsKey('response')) {
      context.handle(
        _responseMeta,
        response.isAcceptableOrUnknown(data['response']!, _responseMeta),
      );
    } else if (isInserting) {
      context.missing(_responseMeta);
    }
    if (data.containsKey('sections_json')) {
      context.handle(
        _sectionsJsonMeta,
        sectionsJson.isAcceptableOrUnknown(
          data['sections_json']!,
          _sectionsJsonMeta,
        ),
      );
    }
    if (data.containsKey('outcome_note')) {
      context.handle(
        _outcomeNoteMeta,
        outcomeNote.isAcceptableOrUnknown(
          data['outcome_note']!,
          _outcomeNoteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiAnalysisRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiAnalysisRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      beetleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beetle_id'],
      ),
      kind: $AiAnalysesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      provider:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}provider'],
          )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      ),
      response:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}response'],
          )!,
      sectionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sections_json'],
      ),
      feedback: $AiAnalysesTable.$converterfeedbackn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}feedback'],
        ),
      ),
      outcome: $AiAnalysesTable.$converteroutcome.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}outcome'],
        )!,
      ),
      outcomeNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome_note'],
      ),
    );
  }

  @override
  $AiAnalysesTable createAlias(String alias) {
    return $AiAnalysesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AnalysisKind, String, String> $converterkind =
      const EnumNameConverter<AnalysisKind>(AnalysisKind.values);
  static JsonTypeConverter2<AnalysisFeedback, String, String>
  $converterfeedback = const EnumNameConverter<AnalysisFeedback>(
    AnalysisFeedback.values,
  );
  static JsonTypeConverter2<AnalysisFeedback?, String?, String?>
  $converterfeedbackn = JsonTypeConverter2.asNullable($converterfeedback);
  static JsonTypeConverter2<PredictionOutcome, String, String>
  $converteroutcome = const EnumNameConverter<PredictionOutcome>(
    PredictionOutcome.values,
  );
}

class AiAnalysisRow extends DataClass implements Insertable<AiAnalysisRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String? beetleId;
  final AnalysisKind kind;
  final String provider;
  final String? model;
  final String? question;
  final String response;

  /// JSON array of labeled sections (verified / calculated / observation / hypothesis /
  /// recommendation / unknown). Hypotheses are never promoted to facts.
  final String? sectionsJson;
  final AnalysisFeedback? feedback;
  final PredictionOutcome outcome;
  final String? outcomeNote;
  const AiAnalysisRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    this.beetleId,
    required this.kind,
    required this.provider,
    this.model,
    this.question,
    required this.response,
    this.sectionsJson,
    this.feedback,
    required this.outcome,
    this.outcomeNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    if (!nullToAbsent || beetleId != null) {
      map['beetle_id'] = Variable<String>(beetleId);
    }
    {
      map['kind'] = Variable<String>(
        $AiAnalysesTable.$converterkind.toSql(kind),
      );
    }
    map['provider'] = Variable<String>(provider);
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || question != null) {
      map['question'] = Variable<String>(question);
    }
    map['response'] = Variable<String>(response);
    if (!nullToAbsent || sectionsJson != null) {
      map['sections_json'] = Variable<String>(sectionsJson);
    }
    if (!nullToAbsent || feedback != null) {
      map['feedback'] = Variable<String>(
        $AiAnalysesTable.$converterfeedbackn.toSql(feedback),
      );
    }
    {
      map['outcome'] = Variable<String>(
        $AiAnalysesTable.$converteroutcome.toSql(outcome),
      );
    }
    if (!nullToAbsent || outcomeNote != null) {
      map['outcome_note'] = Variable<String>(outcomeNote);
    }
    return map;
  }

  AiAnalysesCompanion toCompanion(bool nullToAbsent) {
    return AiAnalysesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      beetleId:
          beetleId == null && nullToAbsent
              ? const Value.absent()
              : Value(beetleId),
      kind: Value(kind),
      provider: Value(provider),
      model:
          model == null && nullToAbsent ? const Value.absent() : Value(model),
      question:
          question == null && nullToAbsent
              ? const Value.absent()
              : Value(question),
      response: Value(response),
      sectionsJson:
          sectionsJson == null && nullToAbsent
              ? const Value.absent()
              : Value(sectionsJson),
      feedback:
          feedback == null && nullToAbsent
              ? const Value.absent()
              : Value(feedback),
      outcome: Value(outcome),
      outcomeNote:
          outcomeNote == null && nullToAbsent
              ? const Value.absent()
              : Value(outcomeNote),
    );
  }

  factory AiAnalysisRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiAnalysisRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      beetleId: serializer.fromJson<String?>(json['beetleId']),
      kind: $AiAnalysesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      provider: serializer.fromJson<String>(json['provider']),
      model: serializer.fromJson<String?>(json['model']),
      question: serializer.fromJson<String?>(json['question']),
      response: serializer.fromJson<String>(json['response']),
      sectionsJson: serializer.fromJson<String?>(json['sectionsJson']),
      feedback: $AiAnalysesTable.$converterfeedbackn.fromJson(
        serializer.fromJson<String?>(json['feedback']),
      ),
      outcome: $AiAnalysesTable.$converteroutcome.fromJson(
        serializer.fromJson<String>(json['outcome']),
      ),
      outcomeNote: serializer.fromJson<String?>(json['outcomeNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'beetleId': serializer.toJson<String?>(beetleId),
      'kind': serializer.toJson<String>(
        $AiAnalysesTable.$converterkind.toJson(kind),
      ),
      'provider': serializer.toJson<String>(provider),
      'model': serializer.toJson<String?>(model),
      'question': serializer.toJson<String?>(question),
      'response': serializer.toJson<String>(response),
      'sectionsJson': serializer.toJson<String?>(sectionsJson),
      'feedback': serializer.toJson<String?>(
        $AiAnalysesTable.$converterfeedbackn.toJson(feedback),
      ),
      'outcome': serializer.toJson<String>(
        $AiAnalysesTable.$converteroutcome.toJson(outcome),
      ),
      'outcomeNote': serializer.toJson<String?>(outcomeNote),
    };
  }

  AiAnalysisRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    Value<String?> beetleId = const Value.absent(),
    AnalysisKind? kind,
    String? provider,
    Value<String?> model = const Value.absent(),
    Value<String?> question = const Value.absent(),
    String? response,
    Value<String?> sectionsJson = const Value.absent(),
    Value<AnalysisFeedback?> feedback = const Value.absent(),
    PredictionOutcome? outcome,
    Value<String?> outcomeNote = const Value.absent(),
  }) => AiAnalysisRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    beetleId: beetleId.present ? beetleId.value : this.beetleId,
    kind: kind ?? this.kind,
    provider: provider ?? this.provider,
    model: model.present ? model.value : this.model,
    question: question.present ? question.value : this.question,
    response: response ?? this.response,
    sectionsJson: sectionsJson.present ? sectionsJson.value : this.sectionsJson,
    feedback: feedback.present ? feedback.value : this.feedback,
    outcome: outcome ?? this.outcome,
    outcomeNote: outcomeNote.present ? outcomeNote.value : this.outcomeNote,
  );
  AiAnalysisRow copyWithCompanion(AiAnalysesCompanion data) {
    return AiAnalysisRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      beetleId: data.beetleId.present ? data.beetleId.value : this.beetleId,
      kind: data.kind.present ? data.kind.value : this.kind,
      provider: data.provider.present ? data.provider.value : this.provider,
      model: data.model.present ? data.model.value : this.model,
      question: data.question.present ? data.question.value : this.question,
      response: data.response.present ? data.response.value : this.response,
      sectionsJson:
          data.sectionsJson.present
              ? data.sectionsJson.value
              : this.sectionsJson,
      feedback: data.feedback.present ? data.feedback.value : this.feedback,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      outcomeNote:
          data.outcomeNote.present ? data.outcomeNote.value : this.outcomeNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiAnalysisRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('kind: $kind, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('question: $question, ')
          ..write('response: $response, ')
          ..write('sectionsJson: $sectionsJson, ')
          ..write('feedback: $feedback, ')
          ..write('outcome: $outcome, ')
          ..write('outcomeNote: $outcomeNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    kind,
    provider,
    model,
    question,
    response,
    sectionsJson,
    feedback,
    outcome,
    outcomeNote,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiAnalysisRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.beetleId == this.beetleId &&
          other.kind == this.kind &&
          other.provider == this.provider &&
          other.model == this.model &&
          other.question == this.question &&
          other.response == this.response &&
          other.sectionsJson == this.sectionsJson &&
          other.feedback == this.feedback &&
          other.outcome == this.outcome &&
          other.outcomeNote == this.outcomeNote);
}

class AiAnalysesCompanion extends UpdateCompanion<AiAnalysisRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String?> beetleId;
  final Value<AnalysisKind> kind;
  final Value<String> provider;
  final Value<String?> model;
  final Value<String?> question;
  final Value<String> response;
  final Value<String?> sectionsJson;
  final Value<AnalysisFeedback?> feedback;
  final Value<PredictionOutcome> outcome;
  final Value<String?> outcomeNote;
  final Value<int> rowid;
  const AiAnalysesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.kind = const Value.absent(),
    this.provider = const Value.absent(),
    this.model = const Value.absent(),
    this.question = const Value.absent(),
    this.response = const Value.absent(),
    this.sectionsJson = const Value.absent(),
    this.feedback = const Value.absent(),
    this.outcome = const Value.absent(),
    this.outcomeNote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiAnalysesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    required AnalysisKind kind,
    required String provider,
    this.model = const Value.absent(),
    this.question = const Value.absent(),
    required String response,
    this.sectionsJson = const Value.absent(),
    this.feedback = const Value.absent(),
    this.outcome = const Value.absent(),
    this.outcomeNote = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : kind = Value(kind),
       provider = Value(provider),
       response = Value(response);
  static Insertable<AiAnalysisRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? beetleId,
    Expression<String>? kind,
    Expression<String>? provider,
    Expression<String>? model,
    Expression<String>? question,
    Expression<String>? response,
    Expression<String>? sectionsJson,
    Expression<String>? feedback,
    Expression<String>? outcome,
    Expression<String>? outcomeNote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (beetleId != null) 'beetle_id': beetleId,
      if (kind != null) 'kind': kind,
      if (provider != null) 'provider': provider,
      if (model != null) 'model': model,
      if (question != null) 'question': question,
      if (response != null) 'response': response,
      if (sectionsJson != null) 'sections_json': sectionsJson,
      if (feedback != null) 'feedback': feedback,
      if (outcome != null) 'outcome': outcome,
      if (outcomeNote != null) 'outcome_note': outcomeNote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiAnalysesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String?>? beetleId,
    Value<AnalysisKind>? kind,
    Value<String>? provider,
    Value<String?>? model,
    Value<String?>? question,
    Value<String>? response,
    Value<String?>? sectionsJson,
    Value<AnalysisFeedback?>? feedback,
    Value<PredictionOutcome>? outcome,
    Value<String?>? outcomeNote,
    Value<int>? rowid,
  }) {
    return AiAnalysesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      beetleId: beetleId ?? this.beetleId,
      kind: kind ?? this.kind,
      provider: provider ?? this.provider,
      model: model ?? this.model,
      question: question ?? this.question,
      response: response ?? this.response,
      sectionsJson: sectionsJson ?? this.sectionsJson,
      feedback: feedback ?? this.feedback,
      outcome: outcome ?? this.outcome,
      outcomeNote: outcomeNote ?? this.outcomeNote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (beetleId.present) {
      map['beetle_id'] = Variable<String>(beetleId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $AiAnalysesTable.$converterkind.toSql(kind.value),
      );
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (sectionsJson.present) {
      map['sections_json'] = Variable<String>(sectionsJson.value);
    }
    if (feedback.present) {
      map['feedback'] = Variable<String>(
        $AiAnalysesTable.$converterfeedbackn.toSql(feedback.value),
      );
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(
        $AiAnalysesTable.$converteroutcome.toSql(outcome.value),
      );
    }
    if (outcomeNote.present) {
      map['outcome_note'] = Variable<String>(outcomeNote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiAnalysesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('kind: $kind, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('question: $question, ')
          ..write('response: $response, ')
          ..write('sectionsJson: $sectionsJson, ')
          ..write('feedback: $feedback, ')
          ..write('outcome: $outcome, ')
          ..write('outcomeNote: $outcomeNote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, ReminderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _beetleIdMeta = const VerificationMeta(
    'beetleId',
  );
  @override
  late final GeneratedColumn<String> beetleId = GeneratedColumn<String>(
    'beetle_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _sensorIdMeta = const VerificationMeta(
    'sensorId',
  );
  @override
  late final GeneratedColumn<String> sensorId = GeneratedColumn<String>(
    'sensor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES temperature_sensors (id)',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReminderStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReminderStatus>($RemindersTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<ReminderSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReminderSource>($RemindersTable.$convertersource);
  static const VerificationMeta _basisMeta = const VerificationMeta('basis');
  @override
  late final GeneratedColumn<String> basis = GeneratedColumn<String>(
    'basis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Severity?, String> severity =
      GeneratedColumn<String>(
        'severity',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Severity?>($RemindersTable.$converterseverityn);
  @override
  late final GeneratedColumnWithTypeConverter<Confidence?, String> confidence =
      GeneratedColumn<String>(
        'confidence',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Confidence?>($RemindersTable.$converterconfidencen);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recommendationMeta = const VerificationMeta(
    'recommendation',
  );
  @override
  late final GeneratedColumn<String> recommendation = GeneratedColumn<String>(
    'recommendation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dedupeKeyMeta = const VerificationMeta(
    'dedupeKey',
  );
  @override
  late final GeneratedColumn<String> dedupeKey = GeneratedColumn<String>(
    'dedupe_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodStartMeta = const VerificationMeta(
    'periodStart',
  );
  @override
  late final GeneratedColumn<DateTime> periodStart = GeneratedColumn<DateTime>(
    'period_start',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodEndMeta = const VerificationMeta(
    'periodEnd',
  );
  @override
  late final GeneratedColumn<DateTime> periodEnd = GeneratedColumn<DateTime>(
    'period_end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
    'notification_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _analysisIdMeta = const VerificationMeta(
    'analysisId',
  );
  @override
  late final GeneratedColumn<String> analysisId = GeneratedColumn<String>(
    'analysis_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ai_analyses (id)',
    ),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _postponedCountMeta = const VerificationMeta(
    'postponedCount',
  );
  @override
  late final GeneratedColumn<int> postponedCount = GeneratedColumn<int>(
    'postponed_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    sensorId,
    eventType,
    title,
    message,
    dueAt,
    status,
    source,
    basis,
    severity,
    confidence,
    reason,
    recommendation,
    dedupeKey,
    periodStart,
    periodEnd,
    notificationId,
    analysisId,
    completedAt,
    postponedCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('beetle_id')) {
      context.handle(
        _beetleIdMeta,
        beetleId.isAcceptableOrUnknown(data['beetle_id']!, _beetleIdMeta),
      );
    }
    if (data.containsKey('sensor_id')) {
      context.handle(
        _sensorIdMeta,
        sensorId.isAcceptableOrUnknown(data['sensor_id']!, _sensorIdMeta),
      );
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('basis')) {
      context.handle(
        _basisMeta,
        basis.isAcceptableOrUnknown(data['basis']!, _basisMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('recommendation')) {
      context.handle(
        _recommendationMeta,
        recommendation.isAcceptableOrUnknown(
          data['recommendation']!,
          _recommendationMeta,
        ),
      );
    }
    if (data.containsKey('dedupe_key')) {
      context.handle(
        _dedupeKeyMeta,
        dedupeKey.isAcceptableOrUnknown(data['dedupe_key']!, _dedupeKeyMeta),
      );
    }
    if (data.containsKey('period_start')) {
      context.handle(
        _periodStartMeta,
        periodStart.isAcceptableOrUnknown(
          data['period_start']!,
          _periodStartMeta,
        ),
      );
    }
    if (data.containsKey('period_end')) {
      context.handle(
        _periodEndMeta,
        periodEnd.isAcceptableOrUnknown(data['period_end']!, _periodEndMeta),
      );
    }
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    }
    if (data.containsKey('analysis_id')) {
      context.handle(
        _analysisIdMeta,
        analysisId.isAcceptableOrUnknown(data['analysis_id']!, _analysisIdMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('postponed_count')) {
      context.handle(
        _postponedCountMeta,
        postponedCount.isAcceptableOrUnknown(
          data['postponed_count']!,
          _postponedCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      beetleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beetle_id'],
      ),
      sensorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensor_id'],
      ),
      eventType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}event_type'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      message:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}message'],
          )!,
      dueAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}due_at'],
          )!,
      status: $RemindersTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      source: $RemindersTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      basis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}basis'],
      ),
      severity: $RemindersTable.$converterseverityn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}severity'],
        ),
      ),
      confidence: $RemindersTable.$converterconfidencen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}confidence'],
        ),
      ),
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      recommendation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommendation'],
      ),
      dedupeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dedupe_key'],
      ),
      periodStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_start'],
      ),
      periodEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_end'],
      ),
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_id'],
      ),
      analysisId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}analysis_id'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      postponedCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}postponed_count'],
          )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReminderStatus, String, String> $converterstatus =
      const EnumNameConverter<ReminderStatus>(ReminderStatus.values);
  static JsonTypeConverter2<ReminderSource, String, String> $convertersource =
      const EnumNameConverter<ReminderSource>(ReminderSource.values);
  static JsonTypeConverter2<Severity, String, String> $converterseverity =
      const EnumNameConverter<Severity>(Severity.values);
  static JsonTypeConverter2<Severity?, String?, String?> $converterseverityn =
      JsonTypeConverter2.asNullable($converterseverity);
  static JsonTypeConverter2<Confidence, String, String> $converterconfidence =
      const EnumNameConverter<Confidence>(Confidence.values);
  static JsonTypeConverter2<Confidence?, String?, String?>
  $converterconfidencen = JsonTypeConverter2.asNullable($converterconfidence);
}

class ReminderRow extends DataClass implements Insertable<ReminderRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String? beetleId;
  final String? sensorId;

  /// [CareEventType.wire].
  final String eventType;
  final String title;
  final String message;
  final DateTime dueAt;
  final ReminderStatus status;
  final ReminderSource source;
  final String? basis;
  final Severity? severity;
  final Confidence? confidence;
  final String? reason;
  final String? recommendation;

  /// Identifies "same beetle + event + observation period" to prevent duplicates.
  final String? dedupeKey;
  final DateTime? periodStart;
  final DateTime? periodEnd;
  final int? notificationId;
  final String? analysisId;
  final DateTime? completedAt;
  final int postponedCount;
  const ReminderRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    this.beetleId,
    this.sensorId,
    required this.eventType,
    required this.title,
    required this.message,
    required this.dueAt,
    required this.status,
    required this.source,
    this.basis,
    this.severity,
    this.confidence,
    this.reason,
    this.recommendation,
    this.dedupeKey,
    this.periodStart,
    this.periodEnd,
    this.notificationId,
    this.analysisId,
    this.completedAt,
    required this.postponedCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    if (!nullToAbsent || beetleId != null) {
      map['beetle_id'] = Variable<String>(beetleId);
    }
    if (!nullToAbsent || sensorId != null) {
      map['sensor_id'] = Variable<String>(sensorId);
    }
    map['event_type'] = Variable<String>(eventType);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    map['due_at'] = Variable<DateTime>(dueAt);
    {
      map['status'] = Variable<String>(
        $RemindersTable.$converterstatus.toSql(status),
      );
    }
    {
      map['source'] = Variable<String>(
        $RemindersTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || basis != null) {
      map['basis'] = Variable<String>(basis);
    }
    if (!nullToAbsent || severity != null) {
      map['severity'] = Variable<String>(
        $RemindersTable.$converterseverityn.toSql(severity),
      );
    }
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<String>(
        $RemindersTable.$converterconfidencen.toSql(confidence),
      );
    }
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || recommendation != null) {
      map['recommendation'] = Variable<String>(recommendation);
    }
    if (!nullToAbsent || dedupeKey != null) {
      map['dedupe_key'] = Variable<String>(dedupeKey);
    }
    if (!nullToAbsent || periodStart != null) {
      map['period_start'] = Variable<DateTime>(periodStart);
    }
    if (!nullToAbsent || periodEnd != null) {
      map['period_end'] = Variable<DateTime>(periodEnd);
    }
    if (!nullToAbsent || notificationId != null) {
      map['notification_id'] = Variable<int>(notificationId);
    }
    if (!nullToAbsent || analysisId != null) {
      map['analysis_id'] = Variable<String>(analysisId);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['postponed_count'] = Variable<int>(postponedCount);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      beetleId:
          beetleId == null && nullToAbsent
              ? const Value.absent()
              : Value(beetleId),
      sensorId:
          sensorId == null && nullToAbsent
              ? const Value.absent()
              : Value(sensorId),
      eventType: Value(eventType),
      title: Value(title),
      message: Value(message),
      dueAt: Value(dueAt),
      status: Value(status),
      source: Value(source),
      basis:
          basis == null && nullToAbsent ? const Value.absent() : Value(basis),
      severity:
          severity == null && nullToAbsent
              ? const Value.absent()
              : Value(severity),
      confidence:
          confidence == null && nullToAbsent
              ? const Value.absent()
              : Value(confidence),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
      recommendation:
          recommendation == null && nullToAbsent
              ? const Value.absent()
              : Value(recommendation),
      dedupeKey:
          dedupeKey == null && nullToAbsent
              ? const Value.absent()
              : Value(dedupeKey),
      periodStart:
          periodStart == null && nullToAbsent
              ? const Value.absent()
              : Value(periodStart),
      periodEnd:
          periodEnd == null && nullToAbsent
              ? const Value.absent()
              : Value(periodEnd),
      notificationId:
          notificationId == null && nullToAbsent
              ? const Value.absent()
              : Value(notificationId),
      analysisId:
          analysisId == null && nullToAbsent
              ? const Value.absent()
              : Value(analysisId),
      completedAt:
          completedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(completedAt),
      postponedCount: Value(postponedCount),
    );
  }

  factory ReminderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      beetleId: serializer.fromJson<String?>(json['beetleId']),
      sensorId: serializer.fromJson<String?>(json['sensorId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      dueAt: serializer.fromJson<DateTime>(json['dueAt']),
      status: $RemindersTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      source: $RemindersTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      basis: serializer.fromJson<String?>(json['basis']),
      severity: $RemindersTable.$converterseverityn.fromJson(
        serializer.fromJson<String?>(json['severity']),
      ),
      confidence: $RemindersTable.$converterconfidencen.fromJson(
        serializer.fromJson<String?>(json['confidence']),
      ),
      reason: serializer.fromJson<String?>(json['reason']),
      recommendation: serializer.fromJson<String?>(json['recommendation']),
      dedupeKey: serializer.fromJson<String?>(json['dedupeKey']),
      periodStart: serializer.fromJson<DateTime?>(json['periodStart']),
      periodEnd: serializer.fromJson<DateTime?>(json['periodEnd']),
      notificationId: serializer.fromJson<int?>(json['notificationId']),
      analysisId: serializer.fromJson<String?>(json['analysisId']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      postponedCount: serializer.fromJson<int>(json['postponedCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'beetleId': serializer.toJson<String?>(beetleId),
      'sensorId': serializer.toJson<String?>(sensorId),
      'eventType': serializer.toJson<String>(eventType),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'dueAt': serializer.toJson<DateTime>(dueAt),
      'status': serializer.toJson<String>(
        $RemindersTable.$converterstatus.toJson(status),
      ),
      'source': serializer.toJson<String>(
        $RemindersTable.$convertersource.toJson(source),
      ),
      'basis': serializer.toJson<String?>(basis),
      'severity': serializer.toJson<String?>(
        $RemindersTable.$converterseverityn.toJson(severity),
      ),
      'confidence': serializer.toJson<String?>(
        $RemindersTable.$converterconfidencen.toJson(confidence),
      ),
      'reason': serializer.toJson<String?>(reason),
      'recommendation': serializer.toJson<String?>(recommendation),
      'dedupeKey': serializer.toJson<String?>(dedupeKey),
      'periodStart': serializer.toJson<DateTime?>(periodStart),
      'periodEnd': serializer.toJson<DateTime?>(periodEnd),
      'notificationId': serializer.toJson<int?>(notificationId),
      'analysisId': serializer.toJson<String?>(analysisId),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'postponedCount': serializer.toJson<int>(postponedCount),
    };
  }

  ReminderRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    Value<String?> beetleId = const Value.absent(),
    Value<String?> sensorId = const Value.absent(),
    String? eventType,
    String? title,
    String? message,
    DateTime? dueAt,
    ReminderStatus? status,
    ReminderSource? source,
    Value<String?> basis = const Value.absent(),
    Value<Severity?> severity = const Value.absent(),
    Value<Confidence?> confidence = const Value.absent(),
    Value<String?> reason = const Value.absent(),
    Value<String?> recommendation = const Value.absent(),
    Value<String?> dedupeKey = const Value.absent(),
    Value<DateTime?> periodStart = const Value.absent(),
    Value<DateTime?> periodEnd = const Value.absent(),
    Value<int?> notificationId = const Value.absent(),
    Value<String?> analysisId = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    int? postponedCount,
  }) => ReminderRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    beetleId: beetleId.present ? beetleId.value : this.beetleId,
    sensorId: sensorId.present ? sensorId.value : this.sensorId,
    eventType: eventType ?? this.eventType,
    title: title ?? this.title,
    message: message ?? this.message,
    dueAt: dueAt ?? this.dueAt,
    status: status ?? this.status,
    source: source ?? this.source,
    basis: basis.present ? basis.value : this.basis,
    severity: severity.present ? severity.value : this.severity,
    confidence: confidence.present ? confidence.value : this.confidence,
    reason: reason.present ? reason.value : this.reason,
    recommendation:
        recommendation.present ? recommendation.value : this.recommendation,
    dedupeKey: dedupeKey.present ? dedupeKey.value : this.dedupeKey,
    periodStart: periodStart.present ? periodStart.value : this.periodStart,
    periodEnd: periodEnd.present ? periodEnd.value : this.periodEnd,
    notificationId:
        notificationId.present ? notificationId.value : this.notificationId,
    analysisId: analysisId.present ? analysisId.value : this.analysisId,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    postponedCount: postponedCount ?? this.postponedCount,
  );
  ReminderRow copyWithCompanion(RemindersCompanion data) {
    return ReminderRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      beetleId: data.beetleId.present ? data.beetleId.value : this.beetleId,
      sensorId: data.sensorId.present ? data.sensorId.value : this.sensorId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      status: data.status.present ? data.status.value : this.status,
      source: data.source.present ? data.source.value : this.source,
      basis: data.basis.present ? data.basis.value : this.basis,
      severity: data.severity.present ? data.severity.value : this.severity,
      confidence:
          data.confidence.present ? data.confidence.value : this.confidence,
      reason: data.reason.present ? data.reason.value : this.reason,
      recommendation:
          data.recommendation.present
              ? data.recommendation.value
              : this.recommendation,
      dedupeKey: data.dedupeKey.present ? data.dedupeKey.value : this.dedupeKey,
      periodStart:
          data.periodStart.present ? data.periodStart.value : this.periodStart,
      periodEnd: data.periodEnd.present ? data.periodEnd.value : this.periodEnd,
      notificationId:
          data.notificationId.present
              ? data.notificationId.value
              : this.notificationId,
      analysisId:
          data.analysisId.present ? data.analysisId.value : this.analysisId,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      postponedCount:
          data.postponedCount.present
              ? data.postponedCount.value
              : this.postponedCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('sensorId: $sensorId, ')
          ..write('eventType: $eventType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('dueAt: $dueAt, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('basis: $basis, ')
          ..write('severity: $severity, ')
          ..write('confidence: $confidence, ')
          ..write('reason: $reason, ')
          ..write('recommendation: $recommendation, ')
          ..write('dedupeKey: $dedupeKey, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('notificationId: $notificationId, ')
          ..write('analysisId: $analysisId, ')
          ..write('completedAt: $completedAt, ')
          ..write('postponedCount: $postponedCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    sensorId,
    eventType,
    title,
    message,
    dueAt,
    status,
    source,
    basis,
    severity,
    confidence,
    reason,
    recommendation,
    dedupeKey,
    periodStart,
    periodEnd,
    notificationId,
    analysisId,
    completedAt,
    postponedCount,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.beetleId == this.beetleId &&
          other.sensorId == this.sensorId &&
          other.eventType == this.eventType &&
          other.title == this.title &&
          other.message == this.message &&
          other.dueAt == this.dueAt &&
          other.status == this.status &&
          other.source == this.source &&
          other.basis == this.basis &&
          other.severity == this.severity &&
          other.confidence == this.confidence &&
          other.reason == this.reason &&
          other.recommendation == this.recommendation &&
          other.dedupeKey == this.dedupeKey &&
          other.periodStart == this.periodStart &&
          other.periodEnd == this.periodEnd &&
          other.notificationId == this.notificationId &&
          other.analysisId == this.analysisId &&
          other.completedAt == this.completedAt &&
          other.postponedCount == this.postponedCount);
}

class RemindersCompanion extends UpdateCompanion<ReminderRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String?> beetleId;
  final Value<String?> sensorId;
  final Value<String> eventType;
  final Value<String> title;
  final Value<String> message;
  final Value<DateTime> dueAt;
  final Value<ReminderStatus> status;
  final Value<ReminderSource> source;
  final Value<String?> basis;
  final Value<Severity?> severity;
  final Value<Confidence?> confidence;
  final Value<String?> reason;
  final Value<String?> recommendation;
  final Value<String?> dedupeKey;
  final Value<DateTime?> periodStart;
  final Value<DateTime?> periodEnd;
  final Value<int?> notificationId;
  final Value<String?> analysisId;
  final Value<DateTime?> completedAt;
  final Value<int> postponedCount;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.sensorId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.basis = const Value.absent(),
    this.severity = const Value.absent(),
    this.confidence = const Value.absent(),
    this.reason = const Value.absent(),
    this.recommendation = const Value.absent(),
    this.dedupeKey = const Value.absent(),
    this.periodStart = const Value.absent(),
    this.periodEnd = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.analysisId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.postponedCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.sensorId = const Value.absent(),
    required String eventType,
    required String title,
    required String message,
    required DateTime dueAt,
    required ReminderStatus status,
    required ReminderSource source,
    this.basis = const Value.absent(),
    this.severity = const Value.absent(),
    this.confidence = const Value.absent(),
    this.reason = const Value.absent(),
    this.recommendation = const Value.absent(),
    this.dedupeKey = const Value.absent(),
    this.periodStart = const Value.absent(),
    this.periodEnd = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.analysisId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.postponedCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : eventType = Value(eventType),
       title = Value(title),
       message = Value(message),
       dueAt = Value(dueAt),
       status = Value(status),
       source = Value(source);
  static Insertable<ReminderRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? beetleId,
    Expression<String>? sensorId,
    Expression<String>? eventType,
    Expression<String>? title,
    Expression<String>? message,
    Expression<DateTime>? dueAt,
    Expression<String>? status,
    Expression<String>? source,
    Expression<String>? basis,
    Expression<String>? severity,
    Expression<String>? confidence,
    Expression<String>? reason,
    Expression<String>? recommendation,
    Expression<String>? dedupeKey,
    Expression<DateTime>? periodStart,
    Expression<DateTime>? periodEnd,
    Expression<int>? notificationId,
    Expression<String>? analysisId,
    Expression<DateTime>? completedAt,
    Expression<int>? postponedCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (beetleId != null) 'beetle_id': beetleId,
      if (sensorId != null) 'sensor_id': sensorId,
      if (eventType != null) 'event_type': eventType,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (dueAt != null) 'due_at': dueAt,
      if (status != null) 'status': status,
      if (source != null) 'source': source,
      if (basis != null) 'basis': basis,
      if (severity != null) 'severity': severity,
      if (confidence != null) 'confidence': confidence,
      if (reason != null) 'reason': reason,
      if (recommendation != null) 'recommendation': recommendation,
      if (dedupeKey != null) 'dedupe_key': dedupeKey,
      if (periodStart != null) 'period_start': periodStart,
      if (periodEnd != null) 'period_end': periodEnd,
      if (notificationId != null) 'notification_id': notificationId,
      if (analysisId != null) 'analysis_id': analysisId,
      if (completedAt != null) 'completed_at': completedAt,
      if (postponedCount != null) 'postponed_count': postponedCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String?>? beetleId,
    Value<String?>? sensorId,
    Value<String>? eventType,
    Value<String>? title,
    Value<String>? message,
    Value<DateTime>? dueAt,
    Value<ReminderStatus>? status,
    Value<ReminderSource>? source,
    Value<String?>? basis,
    Value<Severity?>? severity,
    Value<Confidence?>? confidence,
    Value<String?>? reason,
    Value<String?>? recommendation,
    Value<String?>? dedupeKey,
    Value<DateTime?>? periodStart,
    Value<DateTime?>? periodEnd,
    Value<int?>? notificationId,
    Value<String?>? analysisId,
    Value<DateTime?>? completedAt,
    Value<int>? postponedCount,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      beetleId: beetleId ?? this.beetleId,
      sensorId: sensorId ?? this.sensorId,
      eventType: eventType ?? this.eventType,
      title: title ?? this.title,
      message: message ?? this.message,
      dueAt: dueAt ?? this.dueAt,
      status: status ?? this.status,
      source: source ?? this.source,
      basis: basis ?? this.basis,
      severity: severity ?? this.severity,
      confidence: confidence ?? this.confidence,
      reason: reason ?? this.reason,
      recommendation: recommendation ?? this.recommendation,
      dedupeKey: dedupeKey ?? this.dedupeKey,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      notificationId: notificationId ?? this.notificationId,
      analysisId: analysisId ?? this.analysisId,
      completedAt: completedAt ?? this.completedAt,
      postponedCount: postponedCount ?? this.postponedCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (beetleId.present) {
      map['beetle_id'] = Variable<String>(beetleId.value);
    }
    if (sensorId.present) {
      map['sensor_id'] = Variable<String>(sensorId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $RemindersTable.$converterstatus.toSql(status.value),
      );
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $RemindersTable.$convertersource.toSql(source.value),
      );
    }
    if (basis.present) {
      map['basis'] = Variable<String>(basis.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(
        $RemindersTable.$converterseverityn.toSql(severity.value),
      );
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(
        $RemindersTable.$converterconfidencen.toSql(confidence.value),
      );
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (recommendation.present) {
      map['recommendation'] = Variable<String>(recommendation.value);
    }
    if (dedupeKey.present) {
      map['dedupe_key'] = Variable<String>(dedupeKey.value);
    }
    if (periodStart.present) {
      map['period_start'] = Variable<DateTime>(periodStart.value);
    }
    if (periodEnd.present) {
      map['period_end'] = Variable<DateTime>(periodEnd.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (analysisId.present) {
      map['analysis_id'] = Variable<String>(analysisId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (postponedCount.present) {
      map['postponed_count'] = Variable<int>(postponedCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('sensorId: $sensorId, ')
          ..write('eventType: $eventType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('dueAt: $dueAt, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('basis: $basis, ')
          ..write('severity: $severity, ')
          ..write('confidence: $confidence, ')
          ..write('reason: $reason, ')
          ..write('recommendation: $recommendation, ')
          ..write('dedupeKey: $dedupeKey, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('notificationId: $notificationId, ')
          ..write('analysisId: $analysisId, ')
          ..write('completedAt: $completedAt, ')
          ..write('postponedCount: $postponedCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EvidenceReferencesTable extends EvidenceReferences
    with TableInfo<$EvidenceReferencesTable, EvidenceReferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvidenceReferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _analysisIdMeta = const VerificationMeta(
    'analysisId',
  );
  @override
  late final GeneratedColumn<String> analysisId = GeneratedColumn<String>(
    'analysis_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ai_analyses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reminderIdMeta = const VerificationMeta(
    'reminderId',
  );
  @override
  late final GeneratedColumn<String> reminderId = GeneratedColumn<String>(
    'reminder_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reminders (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecordType, String> recordType =
      GeneratedColumn<String>(
        'record_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RecordType>(
        $EvidenceReferencesTable.$converterrecordType,
      );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    analysisId,
    reminderId,
    recordType,
    recordId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evidence_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvidenceReferenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('analysis_id')) {
      context.handle(
        _analysisIdMeta,
        analysisId.isAcceptableOrUnknown(data['analysis_id']!, _analysisIdMeta),
      );
    }
    if (data.containsKey('reminder_id')) {
      context.handle(
        _reminderIdMeta,
        reminderId.isAcceptableOrUnknown(data['reminder_id']!, _reminderIdMeta),
      );
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvidenceReferenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvidenceReferenceRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      analysisId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}analysis_id'],
      ),
      reminderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_id'],
      ),
      recordType: $EvidenceReferencesTable.$converterrecordType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}record_type'],
        )!,
      ),
      recordId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}record_id'],
          )!,
    );
  }

  @override
  $EvidenceReferencesTable createAlias(String alias) {
    return $EvidenceReferencesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecordType, String, String> $converterrecordType =
      const EnumNameConverter<RecordType>(RecordType.values);
}

class EvidenceReferenceRow extends DataClass
    implements Insertable<EvidenceReferenceRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String? analysisId;
  final String? reminderId;
  final RecordType recordType;
  final String recordId;
  const EvidenceReferenceRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    this.analysisId,
    this.reminderId,
    required this.recordType,
    required this.recordId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    if (!nullToAbsent || analysisId != null) {
      map['analysis_id'] = Variable<String>(analysisId);
    }
    if (!nullToAbsent || reminderId != null) {
      map['reminder_id'] = Variable<String>(reminderId);
    }
    {
      map['record_type'] = Variable<String>(
        $EvidenceReferencesTable.$converterrecordType.toSql(recordType),
      );
    }
    map['record_id'] = Variable<String>(recordId);
    return map;
  }

  EvidenceReferencesCompanion toCompanion(bool nullToAbsent) {
    return EvidenceReferencesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      analysisId:
          analysisId == null && nullToAbsent
              ? const Value.absent()
              : Value(analysisId),
      reminderId:
          reminderId == null && nullToAbsent
              ? const Value.absent()
              : Value(reminderId),
      recordType: Value(recordType),
      recordId: Value(recordId),
    );
  }

  factory EvidenceReferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvidenceReferenceRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      analysisId: serializer.fromJson<String?>(json['analysisId']),
      reminderId: serializer.fromJson<String?>(json['reminderId']),
      recordType: $EvidenceReferencesTable.$converterrecordType.fromJson(
        serializer.fromJson<String>(json['recordType']),
      ),
      recordId: serializer.fromJson<String>(json['recordId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'analysisId': serializer.toJson<String?>(analysisId),
      'reminderId': serializer.toJson<String?>(reminderId),
      'recordType': serializer.toJson<String>(
        $EvidenceReferencesTable.$converterrecordType.toJson(recordType),
      ),
      'recordId': serializer.toJson<String>(recordId),
    };
  }

  EvidenceReferenceRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    Value<String?> analysisId = const Value.absent(),
    Value<String?> reminderId = const Value.absent(),
    RecordType? recordType,
    String? recordId,
  }) => EvidenceReferenceRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    analysisId: analysisId.present ? analysisId.value : this.analysisId,
    reminderId: reminderId.present ? reminderId.value : this.reminderId,
    recordType: recordType ?? this.recordType,
    recordId: recordId ?? this.recordId,
  );
  EvidenceReferenceRow copyWithCompanion(EvidenceReferencesCompanion data) {
    return EvidenceReferenceRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      analysisId:
          data.analysisId.present ? data.analysisId.value : this.analysisId,
      reminderId:
          data.reminderId.present ? data.reminderId.value : this.reminderId,
      recordType:
          data.recordType.present ? data.recordType.value : this.recordType,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvidenceReferenceRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('analysisId: $analysisId, ')
          ..write('reminderId: $reminderId, ')
          ..write('recordType: $recordType, ')
          ..write('recordId: $recordId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    analysisId,
    reminderId,
    recordType,
    recordId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvidenceReferenceRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.analysisId == this.analysisId &&
          other.reminderId == this.reminderId &&
          other.recordType == this.recordType &&
          other.recordId == this.recordId);
}

class EvidenceReferencesCompanion
    extends UpdateCompanion<EvidenceReferenceRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String?> analysisId;
  final Value<String?> reminderId;
  final Value<RecordType> recordType;
  final Value<String> recordId;
  final Value<int> rowid;
  const EvidenceReferencesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.analysisId = const Value.absent(),
    this.reminderId = const Value.absent(),
    this.recordType = const Value.absent(),
    this.recordId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EvidenceReferencesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.analysisId = const Value.absent(),
    this.reminderId = const Value.absent(),
    required RecordType recordType,
    required String recordId,
    this.rowid = const Value.absent(),
  }) : recordType = Value(recordType),
       recordId = Value(recordId);
  static Insertable<EvidenceReferenceRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? analysisId,
    Expression<String>? reminderId,
    Expression<String>? recordType,
    Expression<String>? recordId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (analysisId != null) 'analysis_id': analysisId,
      if (reminderId != null) 'reminder_id': reminderId,
      if (recordType != null) 'record_type': recordType,
      if (recordId != null) 'record_id': recordId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EvidenceReferencesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String?>? analysisId,
    Value<String?>? reminderId,
    Value<RecordType>? recordType,
    Value<String>? recordId,
    Value<int>? rowid,
  }) {
    return EvidenceReferencesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      analysisId: analysisId ?? this.analysisId,
      reminderId: reminderId ?? this.reminderId,
      recordType: recordType ?? this.recordType,
      recordId: recordId ?? this.recordId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (analysisId.present) {
      map['analysis_id'] = Variable<String>(analysisId.value);
    }
    if (reminderId.present) {
      map['reminder_id'] = Variable<String>(reminderId.value);
    }
    if (recordType.present) {
      map['record_type'] = Variable<String>(
        $EvidenceReferencesTable.$converterrecordType.toSql(recordType.value),
      );
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvidenceReferencesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('analysisId: $analysisId, ')
          ..write('reminderId: $reminderId, ')
          ..write('recordType: $recordType, ')
          ..write('recordId: $recordId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuggestionSuppressionsTable extends SuggestionSuppressions
    with TableInfo<$SuggestionSuppressionsTable, SuggestionSuppressionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuggestionSuppressionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _beetleIdMeta = const VerificationMeta(
    'beetleId',
  );
  @override
  late final GeneratedColumn<String> beetleId = GeneratedColumn<String>(
    'beetle_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beetles (id)',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _untilMeta = const VerificationMeta('until');
  @override
  late final GeneratedColumn<DateTime> until = GeneratedColumn<DateTime>(
    'until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    eventType,
    until,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suggestion_suppressions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SuggestionSuppressionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('beetle_id')) {
      context.handle(
        _beetleIdMeta,
        beetleId.isAcceptableOrUnknown(data['beetle_id']!, _beetleIdMeta),
      );
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('until')) {
      context.handle(
        _untilMeta,
        until.isAcceptableOrUnknown(data['until']!, _untilMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SuggestionSuppressionRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SuggestionSuppressionRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      beetleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beetle_id'],
      ),
      eventType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}event_type'],
          )!,
      until: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}until'],
      ),
    );
  }

  @override
  $SuggestionSuppressionsTable createAlias(String alias) {
    return $SuggestionSuppressionsTable(attachedDatabase, alias);
  }
}

class SuggestionSuppressionRow extends DataClass
    implements Insertable<SuggestionSuppressionRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final String? beetleId;
  final String eventType;
  final DateTime? until;
  const SuggestionSuppressionRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    this.beetleId,
    required this.eventType,
    this.until,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    if (!nullToAbsent || beetleId != null) {
      map['beetle_id'] = Variable<String>(beetleId);
    }
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || until != null) {
      map['until'] = Variable<DateTime>(until);
    }
    return map;
  }

  SuggestionSuppressionsCompanion toCompanion(bool nullToAbsent) {
    return SuggestionSuppressionsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      beetleId:
          beetleId == null && nullToAbsent
              ? const Value.absent()
              : Value(beetleId),
      eventType: Value(eventType),
      until:
          until == null && nullToAbsent ? const Value.absent() : Value(until),
    );
  }

  factory SuggestionSuppressionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SuggestionSuppressionRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      beetleId: serializer.fromJson<String?>(json['beetleId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      until: serializer.fromJson<DateTime?>(json['until']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'beetleId': serializer.toJson<String?>(beetleId),
      'eventType': serializer.toJson<String>(eventType),
      'until': serializer.toJson<DateTime?>(until),
    };
  }

  SuggestionSuppressionRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    Value<String?> beetleId = const Value.absent(),
    String? eventType,
    Value<DateTime?> until = const Value.absent(),
  }) => SuggestionSuppressionRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    beetleId: beetleId.present ? beetleId.value : this.beetleId,
    eventType: eventType ?? this.eventType,
    until: until.present ? until.value : this.until,
  );
  SuggestionSuppressionRow copyWithCompanion(
    SuggestionSuppressionsCompanion data,
  ) {
    return SuggestionSuppressionRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      beetleId: data.beetleId.present ? data.beetleId.value : this.beetleId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      until: data.until.present ? data.until.value : this.until,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SuggestionSuppressionRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('eventType: $eventType, ')
          ..write('until: $until')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    beetleId,
    eventType,
    until,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SuggestionSuppressionRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.beetleId == this.beetleId &&
          other.eventType == this.eventType &&
          other.until == this.until);
}

class SuggestionSuppressionsCompanion
    extends UpdateCompanion<SuggestionSuppressionRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<String?> beetleId;
  final Value<String> eventType;
  final Value<DateTime?> until;
  final Value<int> rowid;
  const SuggestionSuppressionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.until = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuggestionSuppressionsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.beetleId = const Value.absent(),
    required String eventType,
    this.until = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : eventType = Value(eventType);
  static Insertable<SuggestionSuppressionRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? beetleId,
    Expression<String>? eventType,
    Expression<DateTime>? until,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (beetleId != null) 'beetle_id': beetleId,
      if (eventType != null) 'event_type': eventType,
      if (until != null) 'until': until,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuggestionSuppressionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<String?>? beetleId,
    Value<String>? eventType,
    Value<DateTime?>? until,
    Value<int>? rowid,
  }) {
    return SuggestionSuppressionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      beetleId: beetleId ?? this.beetleId,
      eventType: eventType ?? this.eventType,
      until: until ?? this.until,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (beetleId.present) {
      map['beetle_id'] = Variable<String>(beetleId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (until.present) {
      map['until'] = Variable<DateTime>(until.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuggestionSuppressionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('beetleId: $beetleId, ')
          ..write('eventType: $eventType, ')
          ..write('until: $until, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiProviderSettingsTable extends AiProviderSettings
    with TableInfo<$AiProviderSettingsTable, AiProviderSettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiProviderSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AiProviderKind, String> provider =
      GeneratedColumn<String>(
        'provider',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      ).withConverter<AiProviderKind>(
        $AiProviderSettingsTable.$converterprovider,
      );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _certSha256Meta = const VerificationMeta(
    'certSha256',
  );
  @override
  late final GeneratedColumn<String> certSha256 = GeneratedColumn<String>(
    'cert_sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeoutSecondsMeta = const VerificationMeta(
    'timeoutSeconds',
  );
  @override
  late final GeneratedColumn<int> timeoutSeconds = GeneratedColumn<int>(
    'timeout_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _consentGrantedAtMeta = const VerificationMeta(
    'consentGrantedAt',
  );
  @override
  late final GeneratedColumn<DateTime> consentGrantedAt =
      GeneratedColumn<DateTime>(
        'consent_granted_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    provider,
    enabled,
    baseUrl,
    model,
    certSha256,
    timeoutSeconds,
    consentGrantedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_provider_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiProviderSettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('cert_sha256')) {
      context.handle(
        _certSha256Meta,
        certSha256.isAcceptableOrUnknown(data['cert_sha256']!, _certSha256Meta),
      );
    }
    if (data.containsKey('timeout_seconds')) {
      context.handle(
        _timeoutSecondsMeta,
        timeoutSeconds.isAcceptableOrUnknown(
          data['timeout_seconds']!,
          _timeoutSecondsMeta,
        ),
      );
    }
    if (data.containsKey('consent_granted_at')) {
      context.handle(
        _consentGrantedAtMeta,
        consentGrantedAt.isAcceptableOrUnknown(
          data['consent_granted_at']!,
          _consentGrantedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiProviderSettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiProviderSettingRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      revision:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revision'],
          )!,
      provider: $AiProviderSettingsTable.$converterprovider.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}provider'],
        )!,
      ),
      enabled:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}enabled'],
          )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      certSha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cert_sha256'],
      ),
      timeoutSeconds:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}timeout_seconds'],
          )!,
      consentGrantedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}consent_granted_at'],
      ),
    );
  }

  @override
  $AiProviderSettingsTable createAlias(String alias) {
    return $AiProviderSettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AiProviderKind, String, String> $converterprovider =
      const EnumNameConverter<AiProviderKind>(AiProviderKind.values);
}

class AiProviderSettingRow extends DataClass
    implements Insertable<AiProviderSettingRow> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  final AiProviderKind provider;
  final bool enabled;
  final String? baseUrl;
  final String? model;

  /// SHA-256 fingerprint (hex) of a self-signed gateway certificate to pin.
  final String? certSha256;
  final int timeoutSeconds;

  /// Explicit user consent to send breeding data to this provider.
  final DateTime? consentGrantedAt;
  const AiProviderSettingRow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.revision,
    required this.provider,
    required this.enabled,
    this.baseUrl,
    this.model,
    this.certSha256,
    required this.timeoutSeconds,
    this.consentGrantedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    {
      map['provider'] = Variable<String>(
        $AiProviderSettingsTable.$converterprovider.toSql(provider),
      );
    }
    map['enabled'] = Variable<bool>(enabled);
    if (!nullToAbsent || baseUrl != null) {
      map['base_url'] = Variable<String>(baseUrl);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || certSha256 != null) {
      map['cert_sha256'] = Variable<String>(certSha256);
    }
    map['timeout_seconds'] = Variable<int>(timeoutSeconds);
    if (!nullToAbsent || consentGrantedAt != null) {
      map['consent_granted_at'] = Variable<DateTime>(consentGrantedAt);
    }
    return map;
  }

  AiProviderSettingsCompanion toCompanion(bool nullToAbsent) {
    return AiProviderSettingsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      revision: Value(revision),
      provider: Value(provider),
      enabled: Value(enabled),
      baseUrl:
          baseUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(baseUrl),
      model:
          model == null && nullToAbsent ? const Value.absent() : Value(model),
      certSha256:
          certSha256 == null && nullToAbsent
              ? const Value.absent()
              : Value(certSha256),
      timeoutSeconds: Value(timeoutSeconds),
      consentGrantedAt:
          consentGrantedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(consentGrantedAt),
    );
  }

  factory AiProviderSettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiProviderSettingRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
      provider: $AiProviderSettingsTable.$converterprovider.fromJson(
        serializer.fromJson<String>(json['provider']),
      ),
      enabled: serializer.fromJson<bool>(json['enabled']),
      baseUrl: serializer.fromJson<String?>(json['baseUrl']),
      model: serializer.fromJson<String?>(json['model']),
      certSha256: serializer.fromJson<String?>(json['certSha256']),
      timeoutSeconds: serializer.fromJson<int>(json['timeoutSeconds']),
      consentGrantedAt: serializer.fromJson<DateTime?>(
        json['consentGrantedAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
      'provider': serializer.toJson<String>(
        $AiProviderSettingsTable.$converterprovider.toJson(provider),
      ),
      'enabled': serializer.toJson<bool>(enabled),
      'baseUrl': serializer.toJson<String?>(baseUrl),
      'model': serializer.toJson<String?>(model),
      'certSha256': serializer.toJson<String?>(certSha256),
      'timeoutSeconds': serializer.toJson<int>(timeoutSeconds),
      'consentGrantedAt': serializer.toJson<DateTime?>(consentGrantedAt),
    };
  }

  AiProviderSettingRow copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? revision,
    AiProviderKind? provider,
    bool? enabled,
    Value<String?> baseUrl = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<String?> certSha256 = const Value.absent(),
    int? timeoutSeconds,
    Value<DateTime?> consentGrantedAt = const Value.absent(),
  }) => AiProviderSettingRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    revision: revision ?? this.revision,
    provider: provider ?? this.provider,
    enabled: enabled ?? this.enabled,
    baseUrl: baseUrl.present ? baseUrl.value : this.baseUrl,
    model: model.present ? model.value : this.model,
    certSha256: certSha256.present ? certSha256.value : this.certSha256,
    timeoutSeconds: timeoutSeconds ?? this.timeoutSeconds,
    consentGrantedAt:
        consentGrantedAt.present
            ? consentGrantedAt.value
            : this.consentGrantedAt,
  );
  AiProviderSettingRow copyWithCompanion(AiProviderSettingsCompanion data) {
    return AiProviderSettingRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
      provider: data.provider.present ? data.provider.value : this.provider,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      model: data.model.present ? data.model.value : this.model,
      certSha256:
          data.certSha256.present ? data.certSha256.value : this.certSha256,
      timeoutSeconds:
          data.timeoutSeconds.present
              ? data.timeoutSeconds.value
              : this.timeoutSeconds,
      consentGrantedAt:
          data.consentGrantedAt.present
              ? data.consentGrantedAt.value
              : this.consentGrantedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiProviderSettingRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('provider: $provider, ')
          ..write('enabled: $enabled, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('model: $model, ')
          ..write('certSha256: $certSha256, ')
          ..write('timeoutSeconds: $timeoutSeconds, ')
          ..write('consentGrantedAt: $consentGrantedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    revision,
    provider,
    enabled,
    baseUrl,
    model,
    certSha256,
    timeoutSeconds,
    consentGrantedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiProviderSettingRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision &&
          other.provider == this.provider &&
          other.enabled == this.enabled &&
          other.baseUrl == this.baseUrl &&
          other.model == this.model &&
          other.certSha256 == this.certSha256 &&
          other.timeoutSeconds == this.timeoutSeconds &&
          other.consentGrantedAt == this.consentGrantedAt);
}

class AiProviderSettingsCompanion
    extends UpdateCompanion<AiProviderSettingRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<AiProviderKind> provider;
  final Value<bool> enabled;
  final Value<String?> baseUrl;
  final Value<String?> model;
  final Value<String?> certSha256;
  final Value<int> timeoutSeconds;
  final Value<DateTime?> consentGrantedAt;
  final Value<int> rowid;
  const AiProviderSettingsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.provider = const Value.absent(),
    this.enabled = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.model = const Value.absent(),
    this.certSha256 = const Value.absent(),
    this.timeoutSeconds = const Value.absent(),
    this.consentGrantedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiProviderSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    required AiProviderKind provider,
    this.enabled = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.model = const Value.absent(),
    this.certSha256 = const Value.absent(),
    this.timeoutSeconds = const Value.absent(),
    this.consentGrantedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : provider = Value(provider);
  static Insertable<AiProviderSettingRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<String>? provider,
    Expression<bool>? enabled,
    Expression<String>? baseUrl,
    Expression<String>? model,
    Expression<String>? certSha256,
    Expression<int>? timeoutSeconds,
    Expression<DateTime>? consentGrantedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (provider != null) 'provider': provider,
      if (enabled != null) 'enabled': enabled,
      if (baseUrl != null) 'base_url': baseUrl,
      if (model != null) 'model': model,
      if (certSha256 != null) 'cert_sha256': certSha256,
      if (timeoutSeconds != null) 'timeout_seconds': timeoutSeconds,
      if (consentGrantedAt != null) 'consent_granted_at': consentGrantedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiProviderSettingsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? revision,
    Value<AiProviderKind>? provider,
    Value<bool>? enabled,
    Value<String?>? baseUrl,
    Value<String?>? model,
    Value<String?>? certSha256,
    Value<int>? timeoutSeconds,
    Value<DateTime?>? consentGrantedAt,
    Value<int>? rowid,
  }) {
    return AiProviderSettingsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      provider: provider ?? this.provider,
      enabled: enabled ?? this.enabled,
      baseUrl: baseUrl ?? this.baseUrl,
      model: model ?? this.model,
      certSha256: certSha256 ?? this.certSha256,
      timeoutSeconds: timeoutSeconds ?? this.timeoutSeconds,
      consentGrantedAt: consentGrantedAt ?? this.consentGrantedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(
        $AiProviderSettingsTable.$converterprovider.toSql(provider.value),
      );
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (certSha256.present) {
      map['cert_sha256'] = Variable<String>(certSha256.value);
    }
    if (timeoutSeconds.present) {
      map['timeout_seconds'] = Variable<int>(timeoutSeconds.value);
    }
    if (consentGrantedAt.present) {
      map['consent_granted_at'] = Variable<DateTime>(consentGrantedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiProviderSettingsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('provider: $provider, ')
          ..write('enabled: $enabled, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('model: $model, ')
          ..write('certSha256: $certSha256, ')
          ..write('timeoutSeconds: $timeoutSeconds, ')
          ..write('consentGrantedAt: $consentGrantedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingRow(
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSettingRow extends DataClass implements Insertable<AppSettingRow> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppSettingRow({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSettingRow copyWith({String? key, String? value, DateTime? updatedAt}) =>
      AppSettingRow(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSettingRow copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingRow(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingRow &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSettingRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupImportsTable extends BackupImports
    with TableInfo<$BackupImportsTable, BackupImportRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupImportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _backupIdMeta = const VerificationMeta(
    'backupId',
  );
  @override
  late final GeneratedColumn<String> backupId = GeneratedColumn<String>(
    'backup_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: nowUtc,
  );
  static const VerificationMeta _insertedCountMeta = const VerificationMeta(
    'insertedCount',
  );
  @override
  late final GeneratedColumn<int> insertedCount = GeneratedColumn<int>(
    'inserted_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedCountMeta = const VerificationMeta(
    'updatedCount',
  );
  @override
  late final GeneratedColumn<int> updatedCount = GeneratedColumn<int>(
    'updated_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skippedCountMeta = const VerificationMeta(
    'skippedCount',
  );
  @override
  late final GeneratedColumn<int> skippedCount = GeneratedColumn<int>(
    'skipped_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    backupId,
    importedAt,
    insertedCount,
    updatedCount,
    skippedCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_imports';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupImportRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('backup_id')) {
      context.handle(
        _backupIdMeta,
        backupId.isAcceptableOrUnknown(data['backup_id']!, _backupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_backupIdMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    }
    if (data.containsKey('inserted_count')) {
      context.handle(
        _insertedCountMeta,
        insertedCount.isAcceptableOrUnknown(
          data['inserted_count']!,
          _insertedCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_insertedCountMeta);
    }
    if (data.containsKey('updated_count')) {
      context.handle(
        _updatedCountMeta,
        updatedCount.isAcceptableOrUnknown(
          data['updated_count']!,
          _updatedCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedCountMeta);
    }
    if (data.containsKey('skipped_count')) {
      context.handle(
        _skippedCountMeta,
        skippedCount.isAcceptableOrUnknown(
          data['skipped_count']!,
          _skippedCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_skippedCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {backupId};
  @override
  BackupImportRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupImportRow(
      backupId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}backup_id'],
          )!,
      importedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}imported_at'],
          )!,
      insertedCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}inserted_count'],
          )!,
      updatedCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}updated_count'],
          )!,
      skippedCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}skipped_count'],
          )!,
    );
  }

  @override
  $BackupImportsTable createAlias(String alias) {
    return $BackupImportsTable(attachedDatabase, alias);
  }
}

class BackupImportRow extends DataClass implements Insertable<BackupImportRow> {
  final String backupId;
  final DateTime importedAt;
  final int insertedCount;
  final int updatedCount;
  final int skippedCount;
  const BackupImportRow({
    required this.backupId,
    required this.importedAt,
    required this.insertedCount,
    required this.updatedCount,
    required this.skippedCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['backup_id'] = Variable<String>(backupId);
    map['imported_at'] = Variable<DateTime>(importedAt);
    map['inserted_count'] = Variable<int>(insertedCount);
    map['updated_count'] = Variable<int>(updatedCount);
    map['skipped_count'] = Variable<int>(skippedCount);
    return map;
  }

  BackupImportsCompanion toCompanion(bool nullToAbsent) {
    return BackupImportsCompanion(
      backupId: Value(backupId),
      importedAt: Value(importedAt),
      insertedCount: Value(insertedCount),
      updatedCount: Value(updatedCount),
      skippedCount: Value(skippedCount),
    );
  }

  factory BackupImportRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupImportRow(
      backupId: serializer.fromJson<String>(json['backupId']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      insertedCount: serializer.fromJson<int>(json['insertedCount']),
      updatedCount: serializer.fromJson<int>(json['updatedCount']),
      skippedCount: serializer.fromJson<int>(json['skippedCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'backupId': serializer.toJson<String>(backupId),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'insertedCount': serializer.toJson<int>(insertedCount),
      'updatedCount': serializer.toJson<int>(updatedCount),
      'skippedCount': serializer.toJson<int>(skippedCount),
    };
  }

  BackupImportRow copyWith({
    String? backupId,
    DateTime? importedAt,
    int? insertedCount,
    int? updatedCount,
    int? skippedCount,
  }) => BackupImportRow(
    backupId: backupId ?? this.backupId,
    importedAt: importedAt ?? this.importedAt,
    insertedCount: insertedCount ?? this.insertedCount,
    updatedCount: updatedCount ?? this.updatedCount,
    skippedCount: skippedCount ?? this.skippedCount,
  );
  BackupImportRow copyWithCompanion(BackupImportsCompanion data) {
    return BackupImportRow(
      backupId: data.backupId.present ? data.backupId.value : this.backupId,
      importedAt:
          data.importedAt.present ? data.importedAt.value : this.importedAt,
      insertedCount:
          data.insertedCount.present
              ? data.insertedCount.value
              : this.insertedCount,
      updatedCount:
          data.updatedCount.present
              ? data.updatedCount.value
              : this.updatedCount,
      skippedCount:
          data.skippedCount.present
              ? data.skippedCount.value
              : this.skippedCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupImportRow(')
          ..write('backupId: $backupId, ')
          ..write('importedAt: $importedAt, ')
          ..write('insertedCount: $insertedCount, ')
          ..write('updatedCount: $updatedCount, ')
          ..write('skippedCount: $skippedCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    backupId,
    importedAt,
    insertedCount,
    updatedCount,
    skippedCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupImportRow &&
          other.backupId == this.backupId &&
          other.importedAt == this.importedAt &&
          other.insertedCount == this.insertedCount &&
          other.updatedCount == this.updatedCount &&
          other.skippedCount == this.skippedCount);
}

class BackupImportsCompanion extends UpdateCompanion<BackupImportRow> {
  final Value<String> backupId;
  final Value<DateTime> importedAt;
  final Value<int> insertedCount;
  final Value<int> updatedCount;
  final Value<int> skippedCount;
  final Value<int> rowid;
  const BackupImportsCompanion({
    this.backupId = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.insertedCount = const Value.absent(),
    this.updatedCount = const Value.absent(),
    this.skippedCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackupImportsCompanion.insert({
    required String backupId,
    this.importedAt = const Value.absent(),
    required int insertedCount,
    required int updatedCount,
    required int skippedCount,
    this.rowid = const Value.absent(),
  }) : backupId = Value(backupId),
       insertedCount = Value(insertedCount),
       updatedCount = Value(updatedCount),
       skippedCount = Value(skippedCount);
  static Insertable<BackupImportRow> custom({
    Expression<String>? backupId,
    Expression<DateTime>? importedAt,
    Expression<int>? insertedCount,
    Expression<int>? updatedCount,
    Expression<int>? skippedCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (backupId != null) 'backup_id': backupId,
      if (importedAt != null) 'imported_at': importedAt,
      if (insertedCount != null) 'inserted_count': insertedCount,
      if (updatedCount != null) 'updated_count': updatedCount,
      if (skippedCount != null) 'skipped_count': skippedCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackupImportsCompanion copyWith({
    Value<String>? backupId,
    Value<DateTime>? importedAt,
    Value<int>? insertedCount,
    Value<int>? updatedCount,
    Value<int>? skippedCount,
    Value<int>? rowid,
  }) {
    return BackupImportsCompanion(
      backupId: backupId ?? this.backupId,
      importedAt: importedAt ?? this.importedAt,
      insertedCount: insertedCount ?? this.insertedCount,
      updatedCount: updatedCount ?? this.updatedCount,
      skippedCount: skippedCount ?? this.skippedCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (backupId.present) {
      map['backup_id'] = Variable<String>(backupId.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (insertedCount.present) {
      map['inserted_count'] = Variable<int>(insertedCount.value);
    }
    if (updatedCount.present) {
      map['updated_count'] = Variable<int>(updatedCount.value);
    }
    if (skippedCount.present) {
      map['skipped_count'] = Variable<int>(skippedCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupImportsCompanion(')
          ..write('backupId: $backupId, ')
          ..write('importedAt: $importedAt, ')
          ..write('insertedCount: $insertedCount, ')
          ..write('updatedCount: $updatedCount, ')
          ..write('skippedCount: $skippedCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SpeciesTable species = $SpeciesTable(this);
  late final $TemperatureSensorsTable temperatureSensors =
      $TemperatureSensorsTable(this);
  late final $BeetlesTable beetles = $BeetlesTable(this);
  late final $WeightRecordsTable weightRecords = $WeightRecordsTable(this);
  late final $ObservationRecordsTable observationRecords =
      $ObservationRecordsTable(this);
  late final $TemperatureRecordsTable temperatureRecords =
      $TemperatureRecordsTable(this);
  late final $SubstrateChangesTable substrateChanges = $SubstrateChangesTable(
    this,
  );
  late final $ContainerChangesTable containerChanges = $ContainerChangesTable(
    this,
  );
  late final $LifeStageEventsTable lifeStageEvents = $LifeStageEventsTable(
    this,
  );
  late final $PhotoAttachmentsTable photoAttachments = $PhotoAttachmentsTable(
    this,
  );
  late final $AiAnalysesTable aiAnalyses = $AiAnalysesTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $EvidenceReferencesTable evidenceReferences =
      $EvidenceReferencesTable(this);
  late final $SuggestionSuppressionsTable suggestionSuppressions =
      $SuggestionSuppressionsTable(this);
  late final $AiProviderSettingsTable aiProviderSettings =
      $AiProviderSettingsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $BackupImportsTable backupImports = $BackupImportsTable(this);
  late final Index idxBeetlesSpecies = Index(
    'idx_beetles_species',
    'CREATE INDEX idx_beetles_species ON beetles (species_id)',
  );
  late final Index idxBeetlesStatus = Index(
    'idx_beetles_status',
    'CREATE INDEX idx_beetles_status ON beetles (status)',
  );
  late final Index idxWeightBeetleTime = Index(
    'idx_weight_beetle_time',
    'CREATE INDEX idx_weight_beetle_time ON weight_records (beetle_id, measured_at)',
  );
  late final Index idxObservationBeetleTime = Index(
    'idx_observation_beetle_time',
    'CREATE INDEX idx_observation_beetle_time ON observation_records (beetle_id, observed_at)',
  );
  late final Index idxTemperatureSensorTime = Index(
    'idx_temperature_sensor_time',
    'CREATE INDEX idx_temperature_sensor_time ON temperature_records (sensor_id, recorded_at)',
  );
  late final Index idxSubstrateBeetleTime = Index(
    'idx_substrate_beetle_time',
    'CREATE INDEX idx_substrate_beetle_time ON substrate_changes (beetle_id, changed_at)',
  );
  late final Index idxContainerBeetleTime = Index(
    'idx_container_beetle_time',
    'CREATE INDEX idx_container_beetle_time ON container_changes (beetle_id, changed_at)',
  );
  late final Index idxLifestageBeetleTime = Index(
    'idx_lifestage_beetle_time',
    'CREATE INDEX idx_lifestage_beetle_time ON life_stage_events (beetle_id, occurred_at)',
  );
  late final Index idxPhotoOwner = Index(
    'idx_photo_owner',
    'CREATE INDEX idx_photo_owner ON photo_attachments (owner_type, owner_id)',
  );
  late final Index idxPhotoBeetle = Index(
    'idx_photo_beetle',
    'CREATE INDEX idx_photo_beetle ON photo_attachments (beetle_id)',
  );
  late final Index idxAnalysisBeetleTime = Index(
    'idx_analysis_beetle_time',
    'CREATE INDEX idx_analysis_beetle_time ON ai_analyses (beetle_id, created_at)',
  );
  late final Index idxReminderStatusDue = Index(
    'idx_reminder_status_due',
    'CREATE INDEX idx_reminder_status_due ON reminders (status, due_at)',
  );
  late final Index idxReminderDedupe = Index(
    'idx_reminder_dedupe',
    'CREATE INDEX idx_reminder_dedupe ON reminders (dedupe_key)',
  );
  late final Index idxReminderBeetleEvent = Index(
    'idx_reminder_beetle_event',
    'CREATE INDEX idx_reminder_beetle_event ON reminders (beetle_id, event_type)',
  );
  late final Index idxEvidenceAnalysis = Index(
    'idx_evidence_analysis',
    'CREATE INDEX idx_evidence_analysis ON evidence_references (analysis_id)',
  );
  late final Index idxEvidenceReminder = Index(
    'idx_evidence_reminder',
    'CREATE INDEX idx_evidence_reminder ON evidence_references (reminder_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    species,
    temperatureSensors,
    beetles,
    weightRecords,
    observationRecords,
    temperatureRecords,
    substrateChanges,
    containerChanges,
    lifeStageEvents,
    photoAttachments,
    aiAnalyses,
    reminders,
    evidenceReferences,
    suggestionSuppressions,
    aiProviderSettings,
    appSettings,
    backupImports,
    idxBeetlesSpecies,
    idxBeetlesStatus,
    idxWeightBeetleTime,
    idxObservationBeetleTime,
    idxTemperatureSensorTime,
    idxSubstrateBeetleTime,
    idxContainerBeetleTime,
    idxLifestageBeetleTime,
    idxPhotoOwner,
    idxPhotoBeetle,
    idxAnalysisBeetleTime,
    idxReminderStatusDue,
    idxReminderDedupe,
    idxReminderBeetleEvent,
    idxEvidenceAnalysis,
    idxEvidenceReminder,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ai_analyses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('evidence_references', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'reminders',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('evidence_references', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SpeciesTableCreateCompanionBuilder =
    SpeciesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required String code,
      required String scientificName,
      Value<String?> commonName,
      Value<bool> isBuiltin,
      Value<int?> expectedPupaDaysMin,
      Value<int?> expectedPupaDaysMax,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$SpeciesTableUpdateCompanionBuilder =
    SpeciesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String> code,
      Value<String> scientificName,
      Value<String?> commonName,
      Value<bool> isBuiltin,
      Value<int?> expectedPupaDaysMin,
      Value<int?> expectedPupaDaysMax,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$SpeciesTableReferences
    extends BaseReferences<_$AppDatabase, $SpeciesTable, SpeciesRow> {
  $$SpeciesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BeetlesTable, List<BeetleRow>> _beetlesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.beetles,
    aliasName: $_aliasNameGenerator(db.species.id, db.beetles.speciesId),
  );

  $$BeetlesTableProcessedTableManager get beetlesRefs {
    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_beetlesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpeciesTableFilterComposer
    extends Composer<_$AppDatabase, $SpeciesTable> {
  $$SpeciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedPupaDaysMin => $composableBuilder(
    column: $table.expectedPupaDaysMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedPupaDaysMax => $composableBuilder(
    column: $table.expectedPupaDaysMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> beetlesRefs(
    Expression<bool> Function($$BeetlesTableFilterComposer f) f,
  ) {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpeciesTableOrderingComposer
    extends Composer<_$AppDatabase, $SpeciesTable> {
  $$SpeciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedPupaDaysMin => $composableBuilder(
    column: $table.expectedPupaDaysMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedPupaDaysMax => $composableBuilder(
    column: $table.expectedPupaDaysMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SpeciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpeciesTable> {
  $$SpeciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltin =>
      $composableBuilder(column: $table.isBuiltin, builder: (column) => column);

  GeneratedColumn<int> get expectedPupaDaysMin => $composableBuilder(
    column: $table.expectedPupaDaysMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expectedPupaDaysMax => $composableBuilder(
    column: $table.expectedPupaDaysMax,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> beetlesRefs<T extends Object>(
    Expression<T> Function($$BeetlesTableAnnotationComposer a) f,
  ) {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpeciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpeciesTable,
          SpeciesRow,
          $$SpeciesTableFilterComposer,
          $$SpeciesTableOrderingComposer,
          $$SpeciesTableAnnotationComposer,
          $$SpeciesTableCreateCompanionBuilder,
          $$SpeciesTableUpdateCompanionBuilder,
          (SpeciesRow, $$SpeciesTableReferences),
          SpeciesRow,
          PrefetchHooks Function({bool beetlesRefs})
        > {
  $$SpeciesTableTableManager(_$AppDatabase db, $SpeciesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SpeciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SpeciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SpeciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> scientificName = const Value.absent(),
                Value<String?> commonName = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
                Value<int?> expectedPupaDaysMin = const Value.absent(),
                Value<int?> expectedPupaDaysMax = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeciesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                code: code,
                scientificName: scientificName,
                commonName: commonName,
                isBuiltin: isBuiltin,
                expectedPupaDaysMin: expectedPupaDaysMin,
                expectedPupaDaysMax: expectedPupaDaysMax,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required String code,
                required String scientificName,
                Value<String?> commonName = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
                Value<int?> expectedPupaDaysMin = const Value.absent(),
                Value<int?> expectedPupaDaysMax = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeciesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                code: code,
                scientificName: scientificName,
                commonName: commonName,
                isBuiltin: isBuiltin,
                expectedPupaDaysMin: expectedPupaDaysMin,
                expectedPupaDaysMax: expectedPupaDaysMax,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SpeciesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({beetlesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (beetlesRefs) db.beetles],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (beetlesRefs)
                    await $_getPrefetchedData<
                      SpeciesRow,
                      $SpeciesTable,
                      BeetleRow
                    >(
                      currentTable: table,
                      referencedTable: $$SpeciesTableReferences
                          ._beetlesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SpeciesTableReferences(
                                db,
                                table,
                                p0,
                              ).beetlesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.speciesId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SpeciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpeciesTable,
      SpeciesRow,
      $$SpeciesTableFilterComposer,
      $$SpeciesTableOrderingComposer,
      $$SpeciesTableAnnotationComposer,
      $$SpeciesTableCreateCompanionBuilder,
      $$SpeciesTableUpdateCompanionBuilder,
      (SpeciesRow, $$SpeciesTableReferences),
      SpeciesRow,
      PrefetchHooks Function({bool beetlesRefs})
    >;
typedef $$TemperatureSensorsTableCreateCompanionBuilder =
    TemperatureSensorsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required String name,
      Value<String?> location,
      Value<SensorKind> kind,
      Value<String?> externalId,
      Value<double?> minThresholdC,
      Value<double?> maxThresholdC,
      Value<double?> targetC,
      Value<int> rowid,
    });
typedef $$TemperatureSensorsTableUpdateCompanionBuilder =
    TemperatureSensorsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String> name,
      Value<String?> location,
      Value<SensorKind> kind,
      Value<String?> externalId,
      Value<double?> minThresholdC,
      Value<double?> maxThresholdC,
      Value<double?> targetC,
      Value<int> rowid,
    });

final class $$TemperatureSensorsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TemperatureSensorsTable,
          TemperatureSensorRow
        > {
  $$TemperatureSensorsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$BeetlesTable, List<BeetleRow>> _beetlesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.beetles,
    aliasName: $_aliasNameGenerator(
      db.temperatureSensors.id,
      db.beetles.sensorId,
    ),
  );

  $$BeetlesTableProcessedTableManager get beetlesRefs {
    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.sensorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_beetlesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TemperatureRecordsTable,
    List<TemperatureRecordRow>
  >
  _temperatureRecordsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.temperatureRecords,
        aliasName: $_aliasNameGenerator(
          db.temperatureSensors.id,
          db.temperatureRecords.sensorId,
        ),
      );

  $$TemperatureRecordsTableProcessedTableManager get temperatureRecordsRefs {
    final manager = $$TemperatureRecordsTableTableManager(
      $_db,
      $_db.temperatureRecords,
    ).filter((f) => f.sensorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _temperatureRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderRow>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: $_aliasNameGenerator(
      db.temperatureSensors.id,
      db.reminders.sensorId,
    ),
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.sensorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TemperatureSensorsTableFilterComposer
    extends Composer<_$AppDatabase, $TemperatureSensorsTable> {
  $$TemperatureSensorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SensorKind, SensorKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minThresholdC => $composableBuilder(
    column: $table.minThresholdC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxThresholdC => $composableBuilder(
    column: $table.maxThresholdC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetC => $composableBuilder(
    column: $table.targetC,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> beetlesRefs(
    Expression<bool> Function($$BeetlesTableFilterComposer f) f,
  ) {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.sensorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> temperatureRecordsRefs(
    Expression<bool> Function($$TemperatureRecordsTableFilterComposer f) f,
  ) {
    final $$TemperatureRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.temperatureRecords,
      getReferencedColumn: (t) => t.sensorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemperatureRecordsTableFilterComposer(
            $db: $db,
            $table: $db.temperatureRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.sensorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TemperatureSensorsTableOrderingComposer
    extends Composer<_$AppDatabase, $TemperatureSensorsTable> {
  $$TemperatureSensorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minThresholdC => $composableBuilder(
    column: $table.minThresholdC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxThresholdC => $composableBuilder(
    column: $table.maxThresholdC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetC => $composableBuilder(
    column: $table.targetC,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TemperatureSensorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemperatureSensorsTable> {
  $$TemperatureSensorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SensorKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get minThresholdC => $composableBuilder(
    column: $table.minThresholdC,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxThresholdC => $composableBuilder(
    column: $table.maxThresholdC,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetC =>
      $composableBuilder(column: $table.targetC, builder: (column) => column);

  Expression<T> beetlesRefs<T extends Object>(
    Expression<T> Function($$BeetlesTableAnnotationComposer a) f,
  ) {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.sensorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> temperatureRecordsRefs<T extends Object>(
    Expression<T> Function($$TemperatureRecordsTableAnnotationComposer a) f,
  ) {
    final $$TemperatureRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.temperatureRecords,
          getReferencedColumn: (t) => t.sensorId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TemperatureRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.temperatureRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.sensorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TemperatureSensorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemperatureSensorsTable,
          TemperatureSensorRow,
          $$TemperatureSensorsTableFilterComposer,
          $$TemperatureSensorsTableOrderingComposer,
          $$TemperatureSensorsTableAnnotationComposer,
          $$TemperatureSensorsTableCreateCompanionBuilder,
          $$TemperatureSensorsTableUpdateCompanionBuilder,
          (TemperatureSensorRow, $$TemperatureSensorsTableReferences),
          TemperatureSensorRow,
          PrefetchHooks Function({
            bool beetlesRefs,
            bool temperatureRecordsRefs,
            bool remindersRefs,
          })
        > {
  $$TemperatureSensorsTableTableManager(
    _$AppDatabase db,
    $TemperatureSensorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TemperatureSensorsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$TemperatureSensorsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$TemperatureSensorsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<SensorKind> kind = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
                Value<double?> minThresholdC = const Value.absent(),
                Value<double?> maxThresholdC = const Value.absent(),
                Value<double?> targetC = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemperatureSensorsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                name: name,
                location: location,
                kind: kind,
                externalId: externalId,
                minThresholdC: minThresholdC,
                maxThresholdC: maxThresholdC,
                targetC: targetC,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required String name,
                Value<String?> location = const Value.absent(),
                Value<SensorKind> kind = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
                Value<double?> minThresholdC = const Value.absent(),
                Value<double?> maxThresholdC = const Value.absent(),
                Value<double?> targetC = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemperatureSensorsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                name: name,
                location: location,
                kind: kind,
                externalId: externalId,
                minThresholdC: minThresholdC,
                maxThresholdC: maxThresholdC,
                targetC: targetC,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TemperatureSensorsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            beetlesRefs = false,
            temperatureRecordsRefs = false,
            remindersRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (beetlesRefs) db.beetles,
                if (temperatureRecordsRefs) db.temperatureRecords,
                if (remindersRefs) db.reminders,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (beetlesRefs)
                    await $_getPrefetchedData<
                      TemperatureSensorRow,
                      $TemperatureSensorsTable,
                      BeetleRow
                    >(
                      currentTable: table,
                      referencedTable: $$TemperatureSensorsTableReferences
                          ._beetlesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TemperatureSensorsTableReferences(
                                db,
                                table,
                                p0,
                              ).beetlesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.sensorId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (temperatureRecordsRefs)
                    await $_getPrefetchedData<
                      TemperatureSensorRow,
                      $TemperatureSensorsTable,
                      TemperatureRecordRow
                    >(
                      currentTable: table,
                      referencedTable: $$TemperatureSensorsTableReferences
                          ._temperatureRecordsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TemperatureSensorsTableReferences(
                                db,
                                table,
                                p0,
                              ).temperatureRecordsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.sensorId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (remindersRefs)
                    await $_getPrefetchedData<
                      TemperatureSensorRow,
                      $TemperatureSensorsTable,
                      ReminderRow
                    >(
                      currentTable: table,
                      referencedTable: $$TemperatureSensorsTableReferences
                          ._remindersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TemperatureSensorsTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.sensorId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TemperatureSensorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemperatureSensorsTable,
      TemperatureSensorRow,
      $$TemperatureSensorsTableFilterComposer,
      $$TemperatureSensorsTableOrderingComposer,
      $$TemperatureSensorsTableAnnotationComposer,
      $$TemperatureSensorsTableCreateCompanionBuilder,
      $$TemperatureSensorsTableUpdateCompanionBuilder,
      (TemperatureSensorRow, $$TemperatureSensorsTableReferences),
      TemperatureSensorRow,
      PrefetchHooks Function({
        bool beetlesRefs,
        bool temperatureRecordsRefs,
        bool remindersRefs,
      })
    >;
typedef $$BeetlesTableCreateCompanionBuilder =
    BeetlesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required String code,
      required String speciesId,
      Value<Sex> sex,
      Value<BeetleStatus> status,
      Value<DateTime?> acquiredAt,
      Value<DateTime?> hatchDate,
      Value<DateTime?> estimatedHatchDate,
      Value<int?> hatchUncertaintyDays,
      Value<String?> sensorId,
      Value<String?> notes,
      Value<String?> sireId,
      Value<String?> damId,
      Value<String?> sireNote,
      Value<String?> damNote,
      Value<int> rowid,
    });
typedef $$BeetlesTableUpdateCompanionBuilder =
    BeetlesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String> code,
      Value<String> speciesId,
      Value<Sex> sex,
      Value<BeetleStatus> status,
      Value<DateTime?> acquiredAt,
      Value<DateTime?> hatchDate,
      Value<DateTime?> estimatedHatchDate,
      Value<int?> hatchUncertaintyDays,
      Value<String?> sensorId,
      Value<String?> notes,
      Value<String?> sireId,
      Value<String?> damId,
      Value<String?> sireNote,
      Value<String?> damNote,
      Value<int> rowid,
    });

final class $$BeetlesTableReferences
    extends BaseReferences<_$AppDatabase, $BeetlesTable, BeetleRow> {
  $$BeetlesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SpeciesTable _speciesIdTable(_$AppDatabase db) => db.species
      .createAlias($_aliasNameGenerator(db.beetles.speciesId, db.species.id));

  $$SpeciesTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<String>('species_id')!;

    final manager = $$SpeciesTableTableManager(
      $_db,
      $_db.species,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TemperatureSensorsTable _sensorIdTable(_$AppDatabase db) =>
      db.temperatureSensors.createAlias(
        $_aliasNameGenerator(db.beetles.sensorId, db.temperatureSensors.id),
      );

  $$TemperatureSensorsTableProcessedTableManager? get sensorId {
    final $_column = $_itemColumn<String>('sensor_id');
    if ($_column == null) return null;
    final manager = $$TemperatureSensorsTableTableManager(
      $_db,
      $_db.temperatureSensors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sensorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BeetlesTable _sireIdTable(_$AppDatabase db) => db.beetles.createAlias(
    $_aliasNameGenerator(db.beetles.sireId, db.beetles.id),
  );

  $$BeetlesTableProcessedTableManager? get sireId {
    final $_column = $_itemColumn<String>('sire_id');
    if ($_column == null) return null;
    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sireIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BeetlesTable _damIdTable(_$AppDatabase db) => db.beetles.createAlias(
    $_aliasNameGenerator(db.beetles.damId, db.beetles.id),
  );

  $$BeetlesTableProcessedTableManager? get damId {
    final $_column = $_itemColumn<String>('dam_id');
    if ($_column == null) return null;
    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_damIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WeightRecordsTable, List<WeightRecordRow>>
  _weightRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weightRecords,
    aliasName: $_aliasNameGenerator(db.beetles.id, db.weightRecords.beetleId),
  );

  $$WeightRecordsTableProcessedTableManager get weightRecordsRefs {
    final manager = $$WeightRecordsTableTableManager(
      $_db,
      $_db.weightRecords,
    ).filter((f) => f.beetleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_weightRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ObservationRecordsTable,
    List<ObservationRecordRow>
  >
  _observationRecordsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.observationRecords,
        aliasName: $_aliasNameGenerator(
          db.beetles.id,
          db.observationRecords.beetleId,
        ),
      );

  $$ObservationRecordsTableProcessedTableManager get observationRecordsRefs {
    final manager = $$ObservationRecordsTableTableManager(
      $_db,
      $_db.observationRecords,
    ).filter((f) => f.beetleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _observationRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SubstrateChangesTable, List<SubstrateChangeRow>>
  _substrateChangesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.substrateChanges,
    aliasName: $_aliasNameGenerator(
      db.beetles.id,
      db.substrateChanges.beetleId,
    ),
  );

  $$SubstrateChangesTableProcessedTableManager get substrateChangesRefs {
    final manager = $$SubstrateChangesTableTableManager(
      $_db,
      $_db.substrateChanges,
    ).filter((f) => f.beetleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _substrateChangesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContainerChangesTable, List<ContainerChangeRow>>
  _containerChangesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.containerChanges,
    aliasName: $_aliasNameGenerator(
      db.beetles.id,
      db.containerChanges.beetleId,
    ),
  );

  $$ContainerChangesTableProcessedTableManager get containerChangesRefs {
    final manager = $$ContainerChangesTableTableManager(
      $_db,
      $_db.containerChanges,
    ).filter((f) => f.beetleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _containerChangesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LifeStageEventsTable, List<LifeStageEventRow>>
  _lifeStageEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lifeStageEvents,
    aliasName: $_aliasNameGenerator(db.beetles.id, db.lifeStageEvents.beetleId),
  );

  $$LifeStageEventsTableProcessedTableManager get lifeStageEventsRefs {
    final manager = $$LifeStageEventsTableTableManager(
      $_db,
      $_db.lifeStageEvents,
    ).filter((f) => f.beetleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _lifeStageEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhotoAttachmentsTable, List<PhotoAttachmentRow>>
  _photoAttachmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.photoAttachments,
    aliasName: $_aliasNameGenerator(
      db.beetles.id,
      db.photoAttachments.beetleId,
    ),
  );

  $$PhotoAttachmentsTableProcessedTableManager get photoAttachmentsRefs {
    final manager = $$PhotoAttachmentsTableTableManager(
      $_db,
      $_db.photoAttachments,
    ).filter((f) => f.beetleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _photoAttachmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AiAnalysesTable, List<AiAnalysisRow>>
  _aiAnalysesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.aiAnalyses,
    aliasName: $_aliasNameGenerator(db.beetles.id, db.aiAnalyses.beetleId),
  );

  $$AiAnalysesTableProcessedTableManager get aiAnalysesRefs {
    final manager = $$AiAnalysesTableTableManager(
      $_db,
      $_db.aiAnalyses,
    ).filter((f) => f.beetleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_aiAnalysesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderRow>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: $_aliasNameGenerator(db.beetles.id, db.reminders.beetleId),
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.beetleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SuggestionSuppressionsTable,
    List<SuggestionSuppressionRow>
  >
  _suggestionSuppressionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.suggestionSuppressions,
        aliasName: $_aliasNameGenerator(
          db.beetles.id,
          db.suggestionSuppressions.beetleId,
        ),
      );

  $$SuggestionSuppressionsTableProcessedTableManager
  get suggestionSuppressionsRefs {
    final manager = $$SuggestionSuppressionsTableTableManager(
      $_db,
      $_db.suggestionSuppressions,
    ).filter((f) => f.beetleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _suggestionSuppressionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BeetlesTableFilterComposer
    extends Composer<_$AppDatabase, $BeetlesTable> {
  $$BeetlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sex, Sex, String> get sex =>
      $composableBuilder(
        column: $table.sex,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<BeetleStatus, BeetleStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get hatchDate => $composableBuilder(
    column: $table.hatchDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get estimatedHatchDate => $composableBuilder(
    column: $table.estimatedHatchDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hatchUncertaintyDays => $composableBuilder(
    column: $table.hatchUncertaintyDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sireNote => $composableBuilder(
    column: $table.sireNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damNote => $composableBuilder(
    column: $table.damNote,
    builder: (column) => ColumnFilters(column),
  );

  $$SpeciesTableFilterComposer get speciesId {
    final $$SpeciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableFilterComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemperatureSensorsTableFilterComposer get sensorId {
    final $$TemperatureSensorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sensorId,
      referencedTable: $db.temperatureSensors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemperatureSensorsTableFilterComposer(
            $db: $db,
            $table: $db.temperatureSensors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeetlesTableFilterComposer get sireId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sireId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeetlesTableFilterComposer get damId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.damId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> weightRecordsRefs(
    Expression<bool> Function($$WeightRecordsTableFilterComposer f) f,
  ) {
    final $$WeightRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weightRecords,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeightRecordsTableFilterComposer(
            $db: $db,
            $table: $db.weightRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> observationRecordsRefs(
    Expression<bool> Function($$ObservationRecordsTableFilterComposer f) f,
  ) {
    final $$ObservationRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.observationRecords,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationRecordsTableFilterComposer(
            $db: $db,
            $table: $db.observationRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> substrateChangesRefs(
    Expression<bool> Function($$SubstrateChangesTableFilterComposer f) f,
  ) {
    final $$SubstrateChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.substrateChanges,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubstrateChangesTableFilterComposer(
            $db: $db,
            $table: $db.substrateChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> containerChangesRefs(
    Expression<bool> Function($$ContainerChangesTableFilterComposer f) f,
  ) {
    final $$ContainerChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.containerChanges,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContainerChangesTableFilterComposer(
            $db: $db,
            $table: $db.containerChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> lifeStageEventsRefs(
    Expression<bool> Function($$LifeStageEventsTableFilterComposer f) f,
  ) {
    final $$LifeStageEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lifeStageEvents,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LifeStageEventsTableFilterComposer(
            $db: $db,
            $table: $db.lifeStageEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> photoAttachmentsRefs(
    Expression<bool> Function($$PhotoAttachmentsTableFilterComposer f) f,
  ) {
    final $$PhotoAttachmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photoAttachments,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotoAttachmentsTableFilterComposer(
            $db: $db,
            $table: $db.photoAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> aiAnalysesRefs(
    Expression<bool> Function($$AiAnalysesTableFilterComposer f) f,
  ) {
    final $$AiAnalysesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiAnalyses,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiAnalysesTableFilterComposer(
            $db: $db,
            $table: $db.aiAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> suggestionSuppressionsRefs(
    Expression<bool> Function($$SuggestionSuppressionsTableFilterComposer f) f,
  ) {
    final $$SuggestionSuppressionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.suggestionSuppressions,
          getReferencedColumn: (t) => t.beetleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SuggestionSuppressionsTableFilterComposer(
                $db: $db,
                $table: $db.suggestionSuppressions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BeetlesTableOrderingComposer
    extends Composer<_$AppDatabase, $BeetlesTable> {
  $$BeetlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get hatchDate => $composableBuilder(
    column: $table.hatchDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get estimatedHatchDate => $composableBuilder(
    column: $table.estimatedHatchDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hatchUncertaintyDays => $composableBuilder(
    column: $table.hatchUncertaintyDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sireNote => $composableBuilder(
    column: $table.sireNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damNote => $composableBuilder(
    column: $table.damNote,
    builder: (column) => ColumnOrderings(column),
  );

  $$SpeciesTableOrderingComposer get speciesId {
    final $$SpeciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableOrderingComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemperatureSensorsTableOrderingComposer get sensorId {
    final $$TemperatureSensorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sensorId,
      referencedTable: $db.temperatureSensors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemperatureSensorsTableOrderingComposer(
            $db: $db,
            $table: $db.temperatureSensors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeetlesTableOrderingComposer get sireId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sireId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeetlesTableOrderingComposer get damId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.damId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BeetlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BeetlesTable> {
  $$BeetlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Sex, String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BeetleStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get hatchDate =>
      $composableBuilder(column: $table.hatchDate, builder: (column) => column);

  GeneratedColumn<DateTime> get estimatedHatchDate => $composableBuilder(
    column: $table.estimatedHatchDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hatchUncertaintyDays => $composableBuilder(
    column: $table.hatchUncertaintyDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get sireNote =>
      $composableBuilder(column: $table.sireNote, builder: (column) => column);

  GeneratedColumn<String> get damNote =>
      $composableBuilder(column: $table.damNote, builder: (column) => column);

  $$SpeciesTableAnnotationComposer get speciesId {
    final $$SpeciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableAnnotationComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemperatureSensorsTableAnnotationComposer get sensorId {
    final $$TemperatureSensorsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sensorId,
          referencedTable: $db.temperatureSensors,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TemperatureSensorsTableAnnotationComposer(
                $db: $db,
                $table: $db.temperatureSensors,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$BeetlesTableAnnotationComposer get sireId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sireId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeetlesTableAnnotationComposer get damId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.damId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> weightRecordsRefs<T extends Object>(
    Expression<T> Function($$WeightRecordsTableAnnotationComposer a) f,
  ) {
    final $$WeightRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weightRecords,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeightRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.weightRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> observationRecordsRefs<T extends Object>(
    Expression<T> Function($$ObservationRecordsTableAnnotationComposer a) f,
  ) {
    final $$ObservationRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.observationRecords,
          getReferencedColumn: (t) => t.beetleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.observationRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> substrateChangesRefs<T extends Object>(
    Expression<T> Function($$SubstrateChangesTableAnnotationComposer a) f,
  ) {
    final $$SubstrateChangesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.substrateChanges,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubstrateChangesTableAnnotationComposer(
            $db: $db,
            $table: $db.substrateChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> containerChangesRefs<T extends Object>(
    Expression<T> Function($$ContainerChangesTableAnnotationComposer a) f,
  ) {
    final $$ContainerChangesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.containerChanges,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContainerChangesTableAnnotationComposer(
            $db: $db,
            $table: $db.containerChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> lifeStageEventsRefs<T extends Object>(
    Expression<T> Function($$LifeStageEventsTableAnnotationComposer a) f,
  ) {
    final $$LifeStageEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lifeStageEvents,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LifeStageEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.lifeStageEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> photoAttachmentsRefs<T extends Object>(
    Expression<T> Function($$PhotoAttachmentsTableAnnotationComposer a) f,
  ) {
    final $$PhotoAttachmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photoAttachments,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotoAttachmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.photoAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> aiAnalysesRefs<T extends Object>(
    Expression<T> Function($$AiAnalysesTableAnnotationComposer a) f,
  ) {
    final $$AiAnalysesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiAnalyses,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiAnalysesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.beetleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> suggestionSuppressionsRefs<T extends Object>(
    Expression<T> Function($$SuggestionSuppressionsTableAnnotationComposer a) f,
  ) {
    final $$SuggestionSuppressionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.suggestionSuppressions,
          getReferencedColumn: (t) => t.beetleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SuggestionSuppressionsTableAnnotationComposer(
                $db: $db,
                $table: $db.suggestionSuppressions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BeetlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BeetlesTable,
          BeetleRow,
          $$BeetlesTableFilterComposer,
          $$BeetlesTableOrderingComposer,
          $$BeetlesTableAnnotationComposer,
          $$BeetlesTableCreateCompanionBuilder,
          $$BeetlesTableUpdateCompanionBuilder,
          (BeetleRow, $$BeetlesTableReferences),
          BeetleRow,
          PrefetchHooks Function({
            bool speciesId,
            bool sensorId,
            bool sireId,
            bool damId,
            bool weightRecordsRefs,
            bool observationRecordsRefs,
            bool substrateChangesRefs,
            bool containerChangesRefs,
            bool lifeStageEventsRefs,
            bool photoAttachmentsRefs,
            bool aiAnalysesRefs,
            bool remindersRefs,
            bool suggestionSuppressionsRefs,
          })
        > {
  $$BeetlesTableTableManager(_$AppDatabase db, $BeetlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BeetlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BeetlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BeetlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> speciesId = const Value.absent(),
                Value<Sex> sex = const Value.absent(),
                Value<BeetleStatus> status = const Value.absent(),
                Value<DateTime?> acquiredAt = const Value.absent(),
                Value<DateTime?> hatchDate = const Value.absent(),
                Value<DateTime?> estimatedHatchDate = const Value.absent(),
                Value<int?> hatchUncertaintyDays = const Value.absent(),
                Value<String?> sensorId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> sireId = const Value.absent(),
                Value<String?> damId = const Value.absent(),
                Value<String?> sireNote = const Value.absent(),
                Value<String?> damNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BeetlesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                code: code,
                speciesId: speciesId,
                sex: sex,
                status: status,
                acquiredAt: acquiredAt,
                hatchDate: hatchDate,
                estimatedHatchDate: estimatedHatchDate,
                hatchUncertaintyDays: hatchUncertaintyDays,
                sensorId: sensorId,
                notes: notes,
                sireId: sireId,
                damId: damId,
                sireNote: sireNote,
                damNote: damNote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required String code,
                required String speciesId,
                Value<Sex> sex = const Value.absent(),
                Value<BeetleStatus> status = const Value.absent(),
                Value<DateTime?> acquiredAt = const Value.absent(),
                Value<DateTime?> hatchDate = const Value.absent(),
                Value<DateTime?> estimatedHatchDate = const Value.absent(),
                Value<int?> hatchUncertaintyDays = const Value.absent(),
                Value<String?> sensorId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> sireId = const Value.absent(),
                Value<String?> damId = const Value.absent(),
                Value<String?> sireNote = const Value.absent(),
                Value<String?> damNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BeetlesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                code: code,
                speciesId: speciesId,
                sex: sex,
                status: status,
                acquiredAt: acquiredAt,
                hatchDate: hatchDate,
                estimatedHatchDate: estimatedHatchDate,
                hatchUncertaintyDays: hatchUncertaintyDays,
                sensorId: sensorId,
                notes: notes,
                sireId: sireId,
                damId: damId,
                sireNote: sireNote,
                damNote: damNote,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$BeetlesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            speciesId = false,
            sensorId = false,
            sireId = false,
            damId = false,
            weightRecordsRefs = false,
            observationRecordsRefs = false,
            substrateChangesRefs = false,
            containerChangesRefs = false,
            lifeStageEventsRefs = false,
            photoAttachmentsRefs = false,
            aiAnalysesRefs = false,
            remindersRefs = false,
            suggestionSuppressionsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (weightRecordsRefs) db.weightRecords,
                if (observationRecordsRefs) db.observationRecords,
                if (substrateChangesRefs) db.substrateChanges,
                if (containerChangesRefs) db.containerChanges,
                if (lifeStageEventsRefs) db.lifeStageEvents,
                if (photoAttachmentsRefs) db.photoAttachments,
                if (aiAnalysesRefs) db.aiAnalyses,
                if (remindersRefs) db.reminders,
                if (suggestionSuppressionsRefs) db.suggestionSuppressions,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (speciesId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.speciesId,
                            referencedTable: $$BeetlesTableReferences
                                ._speciesIdTable(db),
                            referencedColumn:
                                $$BeetlesTableReferences._speciesIdTable(db).id,
                          )
                          as T;
                }
                if (sensorId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.sensorId,
                            referencedTable: $$BeetlesTableReferences
                                ._sensorIdTable(db),
                            referencedColumn:
                                $$BeetlesTableReferences._sensorIdTable(db).id,
                          )
                          as T;
                }
                if (sireId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.sireId,
                            referencedTable: $$BeetlesTableReferences
                                ._sireIdTable(db),
                            referencedColumn:
                                $$BeetlesTableReferences._sireIdTable(db).id,
                          )
                          as T;
                }
                if (damId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.damId,
                            referencedTable: $$BeetlesTableReferences
                                ._damIdTable(db),
                            referencedColumn:
                                $$BeetlesTableReferences._damIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (weightRecordsRefs)
                    await $_getPrefetchedData<
                      BeetleRow,
                      $BeetlesTable,
                      WeightRecordRow
                    >(
                      currentTable: table,
                      referencedTable: $$BeetlesTableReferences
                          ._weightRecordsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BeetlesTableReferences(
                                db,
                                table,
                                p0,
                              ).weightRecordsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.beetleId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (observationRecordsRefs)
                    await $_getPrefetchedData<
                      BeetleRow,
                      $BeetlesTable,
                      ObservationRecordRow
                    >(
                      currentTable: table,
                      referencedTable: $$BeetlesTableReferences
                          ._observationRecordsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BeetlesTableReferences(
                                db,
                                table,
                                p0,
                              ).observationRecordsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.beetleId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (substrateChangesRefs)
                    await $_getPrefetchedData<
                      BeetleRow,
                      $BeetlesTable,
                      SubstrateChangeRow
                    >(
                      currentTable: table,
                      referencedTable: $$BeetlesTableReferences
                          ._substrateChangesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BeetlesTableReferences(
                                db,
                                table,
                                p0,
                              ).substrateChangesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.beetleId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (containerChangesRefs)
                    await $_getPrefetchedData<
                      BeetleRow,
                      $BeetlesTable,
                      ContainerChangeRow
                    >(
                      currentTable: table,
                      referencedTable: $$BeetlesTableReferences
                          ._containerChangesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BeetlesTableReferences(
                                db,
                                table,
                                p0,
                              ).containerChangesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.beetleId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (lifeStageEventsRefs)
                    await $_getPrefetchedData<
                      BeetleRow,
                      $BeetlesTable,
                      LifeStageEventRow
                    >(
                      currentTable: table,
                      referencedTable: $$BeetlesTableReferences
                          ._lifeStageEventsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BeetlesTableReferences(
                                db,
                                table,
                                p0,
                              ).lifeStageEventsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.beetleId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (photoAttachmentsRefs)
                    await $_getPrefetchedData<
                      BeetleRow,
                      $BeetlesTable,
                      PhotoAttachmentRow
                    >(
                      currentTable: table,
                      referencedTable: $$BeetlesTableReferences
                          ._photoAttachmentsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BeetlesTableReferences(
                                db,
                                table,
                                p0,
                              ).photoAttachmentsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.beetleId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (aiAnalysesRefs)
                    await $_getPrefetchedData<
                      BeetleRow,
                      $BeetlesTable,
                      AiAnalysisRow
                    >(
                      currentTable: table,
                      referencedTable: $$BeetlesTableReferences
                          ._aiAnalysesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BeetlesTableReferences(
                                db,
                                table,
                                p0,
                              ).aiAnalysesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.beetleId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (remindersRefs)
                    await $_getPrefetchedData<
                      BeetleRow,
                      $BeetlesTable,
                      ReminderRow
                    >(
                      currentTable: table,
                      referencedTable: $$BeetlesTableReferences
                          ._remindersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BeetlesTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.beetleId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (suggestionSuppressionsRefs)
                    await $_getPrefetchedData<
                      BeetleRow,
                      $BeetlesTable,
                      SuggestionSuppressionRow
                    >(
                      currentTable: table,
                      referencedTable: $$BeetlesTableReferences
                          ._suggestionSuppressionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BeetlesTableReferences(
                                db,
                                table,
                                p0,
                              ).suggestionSuppressionsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.beetleId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BeetlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BeetlesTable,
      BeetleRow,
      $$BeetlesTableFilterComposer,
      $$BeetlesTableOrderingComposer,
      $$BeetlesTableAnnotationComposer,
      $$BeetlesTableCreateCompanionBuilder,
      $$BeetlesTableUpdateCompanionBuilder,
      (BeetleRow, $$BeetlesTableReferences),
      BeetleRow,
      PrefetchHooks Function({
        bool speciesId,
        bool sensorId,
        bool sireId,
        bool damId,
        bool weightRecordsRefs,
        bool observationRecordsRefs,
        bool substrateChangesRefs,
        bool containerChangesRefs,
        bool lifeStageEventsRefs,
        bool photoAttachmentsRefs,
        bool aiAnalysesRefs,
        bool remindersRefs,
        bool suggestionSuppressionsRefs,
      })
    >;
typedef $$WeightRecordsTableCreateCompanionBuilder =
    WeightRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required String beetleId,
      required DateTime measuredAt,
      required double weightGrams,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$WeightRecordsTableUpdateCompanionBuilder =
    WeightRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String> beetleId,
      Value<DateTime> measuredAt,
      Value<double> weightGrams,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$WeightRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WeightRecordsTable, WeightRecordRow> {
  $$WeightRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BeetlesTable _beetleIdTable(_$AppDatabase db) =>
      db.beetles.createAlias(
        $_aliasNameGenerator(db.weightRecords.beetleId, db.beetles.id),
      );

  $$BeetlesTableProcessedTableManager get beetleId {
    final $_column = $_itemColumn<String>('beetle_id')!;

    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beetleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeightRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BeetlesTableFilterComposer get beetleId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeetlesTableOrderingComposer get beetleId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BeetlesTableAnnotationComposer get beetleId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeightRecordsTable,
          WeightRecordRow,
          $$WeightRecordsTableFilterComposer,
          $$WeightRecordsTableOrderingComposer,
          $$WeightRecordsTableAnnotationComposer,
          $$WeightRecordsTableCreateCompanionBuilder,
          $$WeightRecordsTableUpdateCompanionBuilder,
          (WeightRecordRow, $$WeightRecordsTableReferences),
          WeightRecordRow,
          PrefetchHooks Function({bool beetleId})
        > {
  $$WeightRecordsTableTableManager(_$AppDatabase db, $WeightRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WeightRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$WeightRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WeightRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> beetleId = const Value.absent(),
                Value<DateTime> measuredAt = const Value.absent(),
                Value<double> weightGrams = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeightRecordsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                measuredAt: measuredAt,
                weightGrams: weightGrams,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required String beetleId,
                required DateTime measuredAt,
                required double weightGrams,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeightRecordsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                measuredAt: measuredAt,
                weightGrams: weightGrams,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WeightRecordsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({beetleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (beetleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.beetleId,
                            referencedTable: $$WeightRecordsTableReferences
                                ._beetleIdTable(db),
                            referencedColumn:
                                $$WeightRecordsTableReferences
                                    ._beetleIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeightRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeightRecordsTable,
      WeightRecordRow,
      $$WeightRecordsTableFilterComposer,
      $$WeightRecordsTableOrderingComposer,
      $$WeightRecordsTableAnnotationComposer,
      $$WeightRecordsTableCreateCompanionBuilder,
      $$WeightRecordsTableUpdateCompanionBuilder,
      (WeightRecordRow, $$WeightRecordsTableReferences),
      WeightRecordRow,
      PrefetchHooks Function({bool beetleId})
    >;
typedef $$ObservationRecordsTableCreateCompanionBuilder =
    ObservationRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required String beetleId,
      required DateTime observedAt,
      Value<ObservationCategory> category,
      required String description,
      Value<int> rowid,
    });
typedef $$ObservationRecordsTableUpdateCompanionBuilder =
    ObservationRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String> beetleId,
      Value<DateTime> observedAt,
      Value<ObservationCategory> category,
      Value<String> description,
      Value<int> rowid,
    });

final class $$ObservationRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ObservationRecordsTable,
          ObservationRecordRow
        > {
  $$ObservationRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BeetlesTable _beetleIdTable(_$AppDatabase db) =>
      db.beetles.createAlias(
        $_aliasNameGenerator(db.observationRecords.beetleId, db.beetles.id),
      );

  $$BeetlesTableProcessedTableManager get beetleId {
    final $_column = $_itemColumn<String>('beetle_id')!;

    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beetleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ObservationRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ObservationRecordsTable> {
  $$ObservationRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    ObservationCategory,
    ObservationCategory,
    String
  >
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$BeetlesTableFilterComposer get beetleId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ObservationRecordsTable> {
  $$ObservationRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeetlesTableOrderingComposer get beetleId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ObservationRecordsTable> {
  $$ObservationRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ObservationCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$BeetlesTableAnnotationComposer get beetleId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ObservationRecordsTable,
          ObservationRecordRow,
          $$ObservationRecordsTableFilterComposer,
          $$ObservationRecordsTableOrderingComposer,
          $$ObservationRecordsTableAnnotationComposer,
          $$ObservationRecordsTableCreateCompanionBuilder,
          $$ObservationRecordsTableUpdateCompanionBuilder,
          (ObservationRecordRow, $$ObservationRecordsTableReferences),
          ObservationRecordRow,
          PrefetchHooks Function({bool beetleId})
        > {
  $$ObservationRecordsTableTableManager(
    _$AppDatabase db,
    $ObservationRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ObservationRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ObservationRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ObservationRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> beetleId = const Value.absent(),
                Value<DateTime> observedAt = const Value.absent(),
                Value<ObservationCategory> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObservationRecordsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                observedAt: observedAt,
                category: category,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required String beetleId,
                required DateTime observedAt,
                Value<ObservationCategory> category = const Value.absent(),
                required String description,
                Value<int> rowid = const Value.absent(),
              }) => ObservationRecordsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                observedAt: observedAt,
                category: category,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ObservationRecordsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({beetleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (beetleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.beetleId,
                            referencedTable: $$ObservationRecordsTableReferences
                                ._beetleIdTable(db),
                            referencedColumn:
                                $$ObservationRecordsTableReferences
                                    ._beetleIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ObservationRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ObservationRecordsTable,
      ObservationRecordRow,
      $$ObservationRecordsTableFilterComposer,
      $$ObservationRecordsTableOrderingComposer,
      $$ObservationRecordsTableAnnotationComposer,
      $$ObservationRecordsTableCreateCompanionBuilder,
      $$ObservationRecordsTableUpdateCompanionBuilder,
      (ObservationRecordRow, $$ObservationRecordsTableReferences),
      ObservationRecordRow,
      PrefetchHooks Function({bool beetleId})
    >;
typedef $$TemperatureRecordsTableCreateCompanionBuilder =
    TemperatureRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required String sensorId,
      required DateTime recordedAt,
      required double celsius,
      Value<TemperatureSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$TemperatureRecordsTableUpdateCompanionBuilder =
    TemperatureRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String> sensorId,
      Value<DateTime> recordedAt,
      Value<double> celsius,
      Value<TemperatureSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$TemperatureRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TemperatureRecordsTable,
          TemperatureRecordRow
        > {
  $$TemperatureRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TemperatureSensorsTable _sensorIdTable(_$AppDatabase db) =>
      db.temperatureSensors.createAlias(
        $_aliasNameGenerator(
          db.temperatureRecords.sensorId,
          db.temperatureSensors.id,
        ),
      );

  $$TemperatureSensorsTableProcessedTableManager get sensorId {
    final $_column = $_itemColumn<String>('sensor_id')!;

    final manager = $$TemperatureSensorsTableTableManager(
      $_db,
      $_db.temperatureSensors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sensorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TemperatureRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $TemperatureRecordsTable> {
  $$TemperatureRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get celsius => $composableBuilder(
    column: $table.celsius,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TemperatureSource, TemperatureSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$TemperatureSensorsTableFilterComposer get sensorId {
    final $$TemperatureSensorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sensorId,
      referencedTable: $db.temperatureSensors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemperatureSensorsTableFilterComposer(
            $db: $db,
            $table: $db.temperatureSensors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemperatureRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $TemperatureRecordsTable> {
  $$TemperatureRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get celsius => $composableBuilder(
    column: $table.celsius,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$TemperatureSensorsTableOrderingComposer get sensorId {
    final $$TemperatureSensorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sensorId,
      referencedTable: $db.temperatureSensors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemperatureSensorsTableOrderingComposer(
            $db: $db,
            $table: $db.temperatureSensors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemperatureRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemperatureRecordsTable> {
  $$TemperatureRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get celsius =>
      $composableBuilder(column: $table.celsius, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TemperatureSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$TemperatureSensorsTableAnnotationComposer get sensorId {
    final $$TemperatureSensorsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sensorId,
          referencedTable: $db.temperatureSensors,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TemperatureSensorsTableAnnotationComposer(
                $db: $db,
                $table: $db.temperatureSensors,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$TemperatureRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemperatureRecordsTable,
          TemperatureRecordRow,
          $$TemperatureRecordsTableFilterComposer,
          $$TemperatureRecordsTableOrderingComposer,
          $$TemperatureRecordsTableAnnotationComposer,
          $$TemperatureRecordsTableCreateCompanionBuilder,
          $$TemperatureRecordsTableUpdateCompanionBuilder,
          (TemperatureRecordRow, $$TemperatureRecordsTableReferences),
          TemperatureRecordRow,
          PrefetchHooks Function({bool sensorId})
        > {
  $$TemperatureRecordsTableTableManager(
    _$AppDatabase db,
    $TemperatureRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TemperatureRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$TemperatureRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$TemperatureRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> sensorId = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<double> celsius = const Value.absent(),
                Value<TemperatureSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemperatureRecordsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                sensorId: sensorId,
                recordedAt: recordedAt,
                celsius: celsius,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required String sensorId,
                required DateTime recordedAt,
                required double celsius,
                Value<TemperatureSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemperatureRecordsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                sensorId: sensorId,
                recordedAt: recordedAt,
                celsius: celsius,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TemperatureRecordsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({sensorId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (sensorId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.sensorId,
                            referencedTable: $$TemperatureRecordsTableReferences
                                ._sensorIdTable(db),
                            referencedColumn:
                                $$TemperatureRecordsTableReferences
                                    ._sensorIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TemperatureRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemperatureRecordsTable,
      TemperatureRecordRow,
      $$TemperatureRecordsTableFilterComposer,
      $$TemperatureRecordsTableOrderingComposer,
      $$TemperatureRecordsTableAnnotationComposer,
      $$TemperatureRecordsTableCreateCompanionBuilder,
      $$TemperatureRecordsTableUpdateCompanionBuilder,
      (TemperatureRecordRow, $$TemperatureRecordsTableReferences),
      TemperatureRecordRow,
      PrefetchHooks Function({bool sensorId})
    >;
typedef $$SubstrateChangesTableCreateCompanionBuilder =
    SubstrateChangesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required String beetleId,
      required DateTime changedAt,
      Value<String?> substrateType,
      Value<String?> brand,
      Value<String?> batch,
      Value<double?> quantityLiters,
      Value<double?> beetleWeightGrams,
      Value<String?> condition,
      Value<DateTime?> nextPlannedAt,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$SubstrateChangesTableUpdateCompanionBuilder =
    SubstrateChangesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String> beetleId,
      Value<DateTime> changedAt,
      Value<String?> substrateType,
      Value<String?> brand,
      Value<String?> batch,
      Value<double?> quantityLiters,
      Value<double?> beetleWeightGrams,
      Value<String?> condition,
      Value<DateTime?> nextPlannedAt,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$SubstrateChangesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SubstrateChangesTable,
          SubstrateChangeRow
        > {
  $$SubstrateChangesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BeetlesTable _beetleIdTable(_$AppDatabase db) =>
      db.beetles.createAlias(
        $_aliasNameGenerator(db.substrateChanges.beetleId, db.beetles.id),
      );

  $$BeetlesTableProcessedTableManager get beetleId {
    final $_column = $_itemColumn<String>('beetle_id')!;

    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beetleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SubstrateChangesTableFilterComposer
    extends Composer<_$AppDatabase, $SubstrateChangesTable> {
  $$SubstrateChangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get substrateType => $composableBuilder(
    column: $table.substrateType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batch => $composableBuilder(
    column: $table.batch,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantityLiters => $composableBuilder(
    column: $table.quantityLiters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get beetleWeightGrams => $composableBuilder(
    column: $table.beetleWeightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextPlannedAt => $composableBuilder(
    column: $table.nextPlannedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BeetlesTableFilterComposer get beetleId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubstrateChangesTableOrderingComposer
    extends Composer<_$AppDatabase, $SubstrateChangesTable> {
  $$SubstrateChangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get substrateType => $composableBuilder(
    column: $table.substrateType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batch => $composableBuilder(
    column: $table.batch,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantityLiters => $composableBuilder(
    column: $table.quantityLiters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get beetleWeightGrams => $composableBuilder(
    column: $table.beetleWeightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextPlannedAt => $composableBuilder(
    column: $table.nextPlannedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeetlesTableOrderingComposer get beetleId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubstrateChangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubstrateChangesTable> {
  $$SubstrateChangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<String> get substrateType => $composableBuilder(
    column: $table.substrateType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get batch =>
      $composableBuilder(column: $table.batch, builder: (column) => column);

  GeneratedColumn<double> get quantityLiters => $composableBuilder(
    column: $table.quantityLiters,
    builder: (column) => column,
  );

  GeneratedColumn<double> get beetleWeightGrams => $composableBuilder(
    column: $table.beetleWeightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<DateTime> get nextPlannedAt => $composableBuilder(
    column: $table.nextPlannedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BeetlesTableAnnotationComposer get beetleId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubstrateChangesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubstrateChangesTable,
          SubstrateChangeRow,
          $$SubstrateChangesTableFilterComposer,
          $$SubstrateChangesTableOrderingComposer,
          $$SubstrateChangesTableAnnotationComposer,
          $$SubstrateChangesTableCreateCompanionBuilder,
          $$SubstrateChangesTableUpdateCompanionBuilder,
          (SubstrateChangeRow, $$SubstrateChangesTableReferences),
          SubstrateChangeRow,
          PrefetchHooks Function({bool beetleId})
        > {
  $$SubstrateChangesTableTableManager(
    _$AppDatabase db,
    $SubstrateChangesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$SubstrateChangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SubstrateChangesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$SubstrateChangesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> beetleId = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
                Value<String?> substrateType = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> batch = const Value.absent(),
                Value<double?> quantityLiters = const Value.absent(),
                Value<double?> beetleWeightGrams = const Value.absent(),
                Value<String?> condition = const Value.absent(),
                Value<DateTime?> nextPlannedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubstrateChangesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                changedAt: changedAt,
                substrateType: substrateType,
                brand: brand,
                batch: batch,
                quantityLiters: quantityLiters,
                beetleWeightGrams: beetleWeightGrams,
                condition: condition,
                nextPlannedAt: nextPlannedAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required String beetleId,
                required DateTime changedAt,
                Value<String?> substrateType = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> batch = const Value.absent(),
                Value<double?> quantityLiters = const Value.absent(),
                Value<double?> beetleWeightGrams = const Value.absent(),
                Value<String?> condition = const Value.absent(),
                Value<DateTime?> nextPlannedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubstrateChangesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                changedAt: changedAt,
                substrateType: substrateType,
                brand: brand,
                batch: batch,
                quantityLiters: quantityLiters,
                beetleWeightGrams: beetleWeightGrams,
                condition: condition,
                nextPlannedAt: nextPlannedAt,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SubstrateChangesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({beetleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (beetleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.beetleId,
                            referencedTable: $$SubstrateChangesTableReferences
                                ._beetleIdTable(db),
                            referencedColumn:
                                $$SubstrateChangesTableReferences
                                    ._beetleIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SubstrateChangesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubstrateChangesTable,
      SubstrateChangeRow,
      $$SubstrateChangesTableFilterComposer,
      $$SubstrateChangesTableOrderingComposer,
      $$SubstrateChangesTableAnnotationComposer,
      $$SubstrateChangesTableCreateCompanionBuilder,
      $$SubstrateChangesTableUpdateCompanionBuilder,
      (SubstrateChangeRow, $$SubstrateChangesTableReferences),
      SubstrateChangeRow,
      PrefetchHooks Function({bool beetleId})
    >;
typedef $$ContainerChangesTableCreateCompanionBuilder =
    ContainerChangesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required String beetleId,
      required DateTime changedAt,
      Value<double?> previousVolumeLiters,
      required double newVolumeLiters,
      Value<double?> beetleWeightGrams,
      Value<String?> condition,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$ContainerChangesTableUpdateCompanionBuilder =
    ContainerChangesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String> beetleId,
      Value<DateTime> changedAt,
      Value<double?> previousVolumeLiters,
      Value<double> newVolumeLiters,
      Value<double?> beetleWeightGrams,
      Value<String?> condition,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$ContainerChangesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ContainerChangesTable,
          ContainerChangeRow
        > {
  $$ContainerChangesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BeetlesTable _beetleIdTable(_$AppDatabase db) =>
      db.beetles.createAlias(
        $_aliasNameGenerator(db.containerChanges.beetleId, db.beetles.id),
      );

  $$BeetlesTableProcessedTableManager get beetleId {
    final $_column = $_itemColumn<String>('beetle_id')!;

    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beetleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContainerChangesTableFilterComposer
    extends Composer<_$AppDatabase, $ContainerChangesTable> {
  $$ContainerChangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get previousVolumeLiters => $composableBuilder(
    column: $table.previousVolumeLiters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get newVolumeLiters => $composableBuilder(
    column: $table.newVolumeLiters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get beetleWeightGrams => $composableBuilder(
    column: $table.beetleWeightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BeetlesTableFilterComposer get beetleId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContainerChangesTableOrderingComposer
    extends Composer<_$AppDatabase, $ContainerChangesTable> {
  $$ContainerChangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get previousVolumeLiters => $composableBuilder(
    column: $table.previousVolumeLiters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get newVolumeLiters => $composableBuilder(
    column: $table.newVolumeLiters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get beetleWeightGrams => $composableBuilder(
    column: $table.beetleWeightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeetlesTableOrderingComposer get beetleId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContainerChangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContainerChangesTable> {
  $$ContainerChangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<double> get previousVolumeLiters => $composableBuilder(
    column: $table.previousVolumeLiters,
    builder: (column) => column,
  );

  GeneratedColumn<double> get newVolumeLiters => $composableBuilder(
    column: $table.newVolumeLiters,
    builder: (column) => column,
  );

  GeneratedColumn<double> get beetleWeightGrams => $composableBuilder(
    column: $table.beetleWeightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BeetlesTableAnnotationComposer get beetleId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContainerChangesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContainerChangesTable,
          ContainerChangeRow,
          $$ContainerChangesTableFilterComposer,
          $$ContainerChangesTableOrderingComposer,
          $$ContainerChangesTableAnnotationComposer,
          $$ContainerChangesTableCreateCompanionBuilder,
          $$ContainerChangesTableUpdateCompanionBuilder,
          (ContainerChangeRow, $$ContainerChangesTableReferences),
          ContainerChangeRow,
          PrefetchHooks Function({bool beetleId})
        > {
  $$ContainerChangesTableTableManager(
    _$AppDatabase db,
    $ContainerChangesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$ContainerChangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ContainerChangesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ContainerChangesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> beetleId = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
                Value<double?> previousVolumeLiters = const Value.absent(),
                Value<double> newVolumeLiters = const Value.absent(),
                Value<double?> beetleWeightGrams = const Value.absent(),
                Value<String?> condition = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContainerChangesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                changedAt: changedAt,
                previousVolumeLiters: previousVolumeLiters,
                newVolumeLiters: newVolumeLiters,
                beetleWeightGrams: beetleWeightGrams,
                condition: condition,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required String beetleId,
                required DateTime changedAt,
                Value<double?> previousVolumeLiters = const Value.absent(),
                required double newVolumeLiters,
                Value<double?> beetleWeightGrams = const Value.absent(),
                Value<String?> condition = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContainerChangesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                changedAt: changedAt,
                previousVolumeLiters: previousVolumeLiters,
                newVolumeLiters: newVolumeLiters,
                beetleWeightGrams: beetleWeightGrams,
                condition: condition,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ContainerChangesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({beetleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (beetleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.beetleId,
                            referencedTable: $$ContainerChangesTableReferences
                                ._beetleIdTable(db),
                            referencedColumn:
                                $$ContainerChangesTableReferences
                                    ._beetleIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ContainerChangesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContainerChangesTable,
      ContainerChangeRow,
      $$ContainerChangesTableFilterComposer,
      $$ContainerChangesTableOrderingComposer,
      $$ContainerChangesTableAnnotationComposer,
      $$ContainerChangesTableCreateCompanionBuilder,
      $$ContainerChangesTableUpdateCompanionBuilder,
      (ContainerChangeRow, $$ContainerChangesTableReferences),
      ContainerChangeRow,
      PrefetchHooks Function({bool beetleId})
    >;
typedef $$LifeStageEventsTableCreateCompanionBuilder =
    LifeStageEventsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required String beetleId,
      required DateTime occurredAt,
      required LifeStage stage,
      Value<L3Phase?> l3Phase,
      Value<bool> isEstimated,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$LifeStageEventsTableUpdateCompanionBuilder =
    LifeStageEventsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String> beetleId,
      Value<DateTime> occurredAt,
      Value<LifeStage> stage,
      Value<L3Phase?> l3Phase,
      Value<bool> isEstimated,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$LifeStageEventsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LifeStageEventsTable,
          LifeStageEventRow
        > {
  $$LifeStageEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BeetlesTable _beetleIdTable(_$AppDatabase db) =>
      db.beetles.createAlias(
        $_aliasNameGenerator(db.lifeStageEvents.beetleId, db.beetles.id),
      );

  $$BeetlesTableProcessedTableManager get beetleId {
    final $_column = $_itemColumn<String>('beetle_id')!;

    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beetleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LifeStageEventsTableFilterComposer
    extends Composer<_$AppDatabase, $LifeStageEventsTable> {
  $$LifeStageEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LifeStage, LifeStage, String> get stage =>
      $composableBuilder(
        column: $table.stage,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<L3Phase?, L3Phase, String> get l3Phase =>
      $composableBuilder(
        column: $table.l3Phase,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isEstimated => $composableBuilder(
    column: $table.isEstimated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BeetlesTableFilterComposer get beetleId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LifeStageEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $LifeStageEventsTable> {
  $$LifeStageEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get l3Phase => $composableBuilder(
    column: $table.l3Phase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEstimated => $composableBuilder(
    column: $table.isEstimated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeetlesTableOrderingComposer get beetleId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LifeStageEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LifeStageEventsTable> {
  $$LifeStageEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LifeStage, String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumnWithTypeConverter<L3Phase?, String> get l3Phase =>
      $composableBuilder(column: $table.l3Phase, builder: (column) => column);

  GeneratedColumn<bool> get isEstimated => $composableBuilder(
    column: $table.isEstimated,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BeetlesTableAnnotationComposer get beetleId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LifeStageEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LifeStageEventsTable,
          LifeStageEventRow,
          $$LifeStageEventsTableFilterComposer,
          $$LifeStageEventsTableOrderingComposer,
          $$LifeStageEventsTableAnnotationComposer,
          $$LifeStageEventsTableCreateCompanionBuilder,
          $$LifeStageEventsTableUpdateCompanionBuilder,
          (LifeStageEventRow, $$LifeStageEventsTableReferences),
          LifeStageEventRow,
          PrefetchHooks Function({bool beetleId})
        > {
  $$LifeStageEventsTableTableManager(
    _$AppDatabase db,
    $LifeStageEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$LifeStageEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LifeStageEventsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$LifeStageEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String> beetleId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<LifeStage> stage = const Value.absent(),
                Value<L3Phase?> l3Phase = const Value.absent(),
                Value<bool> isEstimated = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LifeStageEventsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                occurredAt: occurredAt,
                stage: stage,
                l3Phase: l3Phase,
                isEstimated: isEstimated,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required String beetleId,
                required DateTime occurredAt,
                required LifeStage stage,
                Value<L3Phase?> l3Phase = const Value.absent(),
                Value<bool> isEstimated = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LifeStageEventsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                occurredAt: occurredAt,
                stage: stage,
                l3Phase: l3Phase,
                isEstimated: isEstimated,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$LifeStageEventsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({beetleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (beetleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.beetleId,
                            referencedTable: $$LifeStageEventsTableReferences
                                ._beetleIdTable(db),
                            referencedColumn:
                                $$LifeStageEventsTableReferences
                                    ._beetleIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LifeStageEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LifeStageEventsTable,
      LifeStageEventRow,
      $$LifeStageEventsTableFilterComposer,
      $$LifeStageEventsTableOrderingComposer,
      $$LifeStageEventsTableAnnotationComposer,
      $$LifeStageEventsTableCreateCompanionBuilder,
      $$LifeStageEventsTableUpdateCompanionBuilder,
      (LifeStageEventRow, $$LifeStageEventsTableReferences),
      LifeStageEventRow,
      PrefetchHooks Function({bool beetleId})
    >;
typedef $$PhotoAttachmentsTableCreateCompanionBuilder =
    PhotoAttachmentsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required PhotoOwnerType ownerType,
      required String ownerId,
      Value<String?> beetleId,
      required String relativePath,
      required String sha256,
      required DateTime takenAt,
      Value<String?> caption,
      Value<int> rowid,
    });
typedef $$PhotoAttachmentsTableUpdateCompanionBuilder =
    PhotoAttachmentsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<PhotoOwnerType> ownerType,
      Value<String> ownerId,
      Value<String?> beetleId,
      Value<String> relativePath,
      Value<String> sha256,
      Value<DateTime> takenAt,
      Value<String?> caption,
      Value<int> rowid,
    });

final class $$PhotoAttachmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PhotoAttachmentsTable,
          PhotoAttachmentRow
        > {
  $$PhotoAttachmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BeetlesTable _beetleIdTable(_$AppDatabase db) =>
      db.beetles.createAlias(
        $_aliasNameGenerator(db.photoAttachments.beetleId, db.beetles.id),
      );

  $$BeetlesTableProcessedTableManager? get beetleId {
    final $_column = $_itemColumn<String>('beetle_id');
    if ($_column == null) return null;
    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beetleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhotoAttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $PhotoAttachmentsTable> {
  $$PhotoAttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PhotoOwnerType, PhotoOwnerType, String>
  get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  $$BeetlesTableFilterComposer get beetleId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotoAttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotoAttachmentsTable> {
  $$PhotoAttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeetlesTableOrderingComposer get beetleId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotoAttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotoAttachmentsTable> {
  $$PhotoAttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PhotoOwnerType, String> get ownerType =>
      $composableBuilder(column: $table.ownerType, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  $$BeetlesTableAnnotationComposer get beetleId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotoAttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotoAttachmentsTable,
          PhotoAttachmentRow,
          $$PhotoAttachmentsTableFilterComposer,
          $$PhotoAttachmentsTableOrderingComposer,
          $$PhotoAttachmentsTableAnnotationComposer,
          $$PhotoAttachmentsTableCreateCompanionBuilder,
          $$PhotoAttachmentsTableUpdateCompanionBuilder,
          (PhotoAttachmentRow, $$PhotoAttachmentsTableReferences),
          PhotoAttachmentRow,
          PrefetchHooks Function({bool beetleId})
        > {
  $$PhotoAttachmentsTableTableManager(
    _$AppDatabase db,
    $PhotoAttachmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$PhotoAttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PhotoAttachmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$PhotoAttachmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<PhotoOwnerType> ownerType = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String?> beetleId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<DateTime> takenAt = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotoAttachmentsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                ownerType: ownerType,
                ownerId: ownerId,
                beetleId: beetleId,
                relativePath: relativePath,
                sha256: sha256,
                takenAt: takenAt,
                caption: caption,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required PhotoOwnerType ownerType,
                required String ownerId,
                Value<String?> beetleId = const Value.absent(),
                required String relativePath,
                required String sha256,
                required DateTime takenAt,
                Value<String?> caption = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotoAttachmentsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                ownerType: ownerType,
                ownerId: ownerId,
                beetleId: beetleId,
                relativePath: relativePath,
                sha256: sha256,
                takenAt: takenAt,
                caption: caption,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PhotoAttachmentsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({beetleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (beetleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.beetleId,
                            referencedTable: $$PhotoAttachmentsTableReferences
                                ._beetleIdTable(db),
                            referencedColumn:
                                $$PhotoAttachmentsTableReferences
                                    ._beetleIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PhotoAttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotoAttachmentsTable,
      PhotoAttachmentRow,
      $$PhotoAttachmentsTableFilterComposer,
      $$PhotoAttachmentsTableOrderingComposer,
      $$PhotoAttachmentsTableAnnotationComposer,
      $$PhotoAttachmentsTableCreateCompanionBuilder,
      $$PhotoAttachmentsTableUpdateCompanionBuilder,
      (PhotoAttachmentRow, $$PhotoAttachmentsTableReferences),
      PhotoAttachmentRow,
      PrefetchHooks Function({bool beetleId})
    >;
typedef $$AiAnalysesTableCreateCompanionBuilder =
    AiAnalysesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String?> beetleId,
      required AnalysisKind kind,
      required String provider,
      Value<String?> model,
      Value<String?> question,
      required String response,
      Value<String?> sectionsJson,
      Value<AnalysisFeedback?> feedback,
      Value<PredictionOutcome> outcome,
      Value<String?> outcomeNote,
      Value<int> rowid,
    });
typedef $$AiAnalysesTableUpdateCompanionBuilder =
    AiAnalysesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String?> beetleId,
      Value<AnalysisKind> kind,
      Value<String> provider,
      Value<String?> model,
      Value<String?> question,
      Value<String> response,
      Value<String?> sectionsJson,
      Value<AnalysisFeedback?> feedback,
      Value<PredictionOutcome> outcome,
      Value<String?> outcomeNote,
      Value<int> rowid,
    });

final class $$AiAnalysesTableReferences
    extends BaseReferences<_$AppDatabase, $AiAnalysesTable, AiAnalysisRow> {
  $$AiAnalysesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BeetlesTable _beetleIdTable(_$AppDatabase db) => db.beetles
      .createAlias($_aliasNameGenerator(db.aiAnalyses.beetleId, db.beetles.id));

  $$BeetlesTableProcessedTableManager? get beetleId {
    final $_column = $_itemColumn<String>('beetle_id');
    if ($_column == null) return null;
    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beetleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderRow>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: $_aliasNameGenerator(db.aiAnalyses.id, db.reminders.analysisId),
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.analysisId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $EvidenceReferencesTable,
    List<EvidenceReferenceRow>
  >
  _evidenceReferencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.evidenceReferences,
        aliasName: $_aliasNameGenerator(
          db.aiAnalyses.id,
          db.evidenceReferences.analysisId,
        ),
      );

  $$EvidenceReferencesTableProcessedTableManager get evidenceReferencesRefs {
    final manager = $$EvidenceReferencesTableTableManager(
      $_db,
      $_db.evidenceReferences,
    ).filter((f) => f.analysisId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _evidenceReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AiAnalysesTableFilterComposer
    extends Composer<_$AppDatabase, $AiAnalysesTable> {
  $$AiAnalysesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AnalysisKind, AnalysisKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sectionsJson => $composableBuilder(
    column: $table.sectionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AnalysisFeedback?, AnalysisFeedback, String>
  get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<PredictionOutcome, PredictionOutcome, String>
  get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get outcomeNote => $composableBuilder(
    column: $table.outcomeNote,
    builder: (column) => ColumnFilters(column),
  );

  $$BeetlesTableFilterComposer get beetleId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.analysisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> evidenceReferencesRefs(
    Expression<bool> Function($$EvidenceReferencesTableFilterComposer f) f,
  ) {
    final $$EvidenceReferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.evidenceReferences,
      getReferencedColumn: (t) => t.analysisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvidenceReferencesTableFilterComposer(
            $db: $db,
            $table: $db.evidenceReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiAnalysesTableOrderingComposer
    extends Composer<_$AppDatabase, $AiAnalysesTable> {
  $$AiAnalysesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sectionsJson => $composableBuilder(
    column: $table.sectionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcomeNote => $composableBuilder(
    column: $table.outcomeNote,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeetlesTableOrderingComposer get beetleId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiAnalysesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiAnalysesTable> {
  $$AiAnalysesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AnalysisKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);

  GeneratedColumn<String> get sectionsJson => $composableBuilder(
    column: $table.sectionsJson,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AnalysisFeedback?, String> get feedback =>
      $composableBuilder(column: $table.feedback, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PredictionOutcome, String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<String> get outcomeNote => $composableBuilder(
    column: $table.outcomeNote,
    builder: (column) => column,
  );

  $$BeetlesTableAnnotationComposer get beetleId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.analysisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> evidenceReferencesRefs<T extends Object>(
    Expression<T> Function($$EvidenceReferencesTableAnnotationComposer a) f,
  ) {
    final $$EvidenceReferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.evidenceReferences,
          getReferencedColumn: (t) => t.analysisId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvidenceReferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.evidenceReferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AiAnalysesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiAnalysesTable,
          AiAnalysisRow,
          $$AiAnalysesTableFilterComposer,
          $$AiAnalysesTableOrderingComposer,
          $$AiAnalysesTableAnnotationComposer,
          $$AiAnalysesTableCreateCompanionBuilder,
          $$AiAnalysesTableUpdateCompanionBuilder,
          (AiAnalysisRow, $$AiAnalysesTableReferences),
          AiAnalysisRow,
          PrefetchHooks Function({
            bool beetleId,
            bool remindersRefs,
            bool evidenceReferencesRefs,
          })
        > {
  $$AiAnalysesTableTableManager(_$AppDatabase db, $AiAnalysesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AiAnalysesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AiAnalysesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AiAnalysesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String?> beetleId = const Value.absent(),
                Value<AnalysisKind> kind = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> question = const Value.absent(),
                Value<String> response = const Value.absent(),
                Value<String?> sectionsJson = const Value.absent(),
                Value<AnalysisFeedback?> feedback = const Value.absent(),
                Value<PredictionOutcome> outcome = const Value.absent(),
                Value<String?> outcomeNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiAnalysesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                kind: kind,
                provider: provider,
                model: model,
                question: question,
                response: response,
                sectionsJson: sectionsJson,
                feedback: feedback,
                outcome: outcome,
                outcomeNote: outcomeNote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String?> beetleId = const Value.absent(),
                required AnalysisKind kind,
                required String provider,
                Value<String?> model = const Value.absent(),
                Value<String?> question = const Value.absent(),
                required String response,
                Value<String?> sectionsJson = const Value.absent(),
                Value<AnalysisFeedback?> feedback = const Value.absent(),
                Value<PredictionOutcome> outcome = const Value.absent(),
                Value<String?> outcomeNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiAnalysesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                kind: kind,
                provider: provider,
                model: model,
                question: question,
                response: response,
                sectionsJson: sectionsJson,
                feedback: feedback,
                outcome: outcome,
                outcomeNote: outcomeNote,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$AiAnalysesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            beetleId = false,
            remindersRefs = false,
            evidenceReferencesRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (remindersRefs) db.reminders,
                if (evidenceReferencesRefs) db.evidenceReferences,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (beetleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.beetleId,
                            referencedTable: $$AiAnalysesTableReferences
                                ._beetleIdTable(db),
                            referencedColumn:
                                $$AiAnalysesTableReferences
                                    ._beetleIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (remindersRefs)
                    await $_getPrefetchedData<
                      AiAnalysisRow,
                      $AiAnalysesTable,
                      ReminderRow
                    >(
                      currentTable: table,
                      referencedTable: $$AiAnalysesTableReferences
                          ._remindersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$AiAnalysesTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.analysisId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (evidenceReferencesRefs)
                    await $_getPrefetchedData<
                      AiAnalysisRow,
                      $AiAnalysesTable,
                      EvidenceReferenceRow
                    >(
                      currentTable: table,
                      referencedTable: $$AiAnalysesTableReferences
                          ._evidenceReferencesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$AiAnalysesTableReferences(
                                db,
                                table,
                                p0,
                              ).evidenceReferencesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.analysisId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AiAnalysesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiAnalysesTable,
      AiAnalysisRow,
      $$AiAnalysesTableFilterComposer,
      $$AiAnalysesTableOrderingComposer,
      $$AiAnalysesTableAnnotationComposer,
      $$AiAnalysesTableCreateCompanionBuilder,
      $$AiAnalysesTableUpdateCompanionBuilder,
      (AiAnalysisRow, $$AiAnalysesTableReferences),
      AiAnalysisRow,
      PrefetchHooks Function({
        bool beetleId,
        bool remindersRefs,
        bool evidenceReferencesRefs,
      })
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String?> beetleId,
      Value<String?> sensorId,
      required String eventType,
      required String title,
      required String message,
      required DateTime dueAt,
      required ReminderStatus status,
      required ReminderSource source,
      Value<String?> basis,
      Value<Severity?> severity,
      Value<Confidence?> confidence,
      Value<String?> reason,
      Value<String?> recommendation,
      Value<String?> dedupeKey,
      Value<DateTime?> periodStart,
      Value<DateTime?> periodEnd,
      Value<int?> notificationId,
      Value<String?> analysisId,
      Value<DateTime?> completedAt,
      Value<int> postponedCount,
      Value<int> rowid,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String?> beetleId,
      Value<String?> sensorId,
      Value<String> eventType,
      Value<String> title,
      Value<String> message,
      Value<DateTime> dueAt,
      Value<ReminderStatus> status,
      Value<ReminderSource> source,
      Value<String?> basis,
      Value<Severity?> severity,
      Value<Confidence?> confidence,
      Value<String?> reason,
      Value<String?> recommendation,
      Value<String?> dedupeKey,
      Value<DateTime?> periodStart,
      Value<DateTime?> periodEnd,
      Value<int?> notificationId,
      Value<String?> analysisId,
      Value<DateTime?> completedAt,
      Value<int> postponedCount,
      Value<int> rowid,
    });

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, ReminderRow> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BeetlesTable _beetleIdTable(_$AppDatabase db) => db.beetles
      .createAlias($_aliasNameGenerator(db.reminders.beetleId, db.beetles.id));

  $$BeetlesTableProcessedTableManager? get beetleId {
    final $_column = $_itemColumn<String>('beetle_id');
    if ($_column == null) return null;
    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beetleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TemperatureSensorsTable _sensorIdTable(_$AppDatabase db) =>
      db.temperatureSensors.createAlias(
        $_aliasNameGenerator(db.reminders.sensorId, db.temperatureSensors.id),
      );

  $$TemperatureSensorsTableProcessedTableManager? get sensorId {
    final $_column = $_itemColumn<String>('sensor_id');
    if ($_column == null) return null;
    final manager = $$TemperatureSensorsTableTableManager(
      $_db,
      $_db.temperatureSensors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sensorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AiAnalysesTable _analysisIdTable(_$AppDatabase db) =>
      db.aiAnalyses.createAlias(
        $_aliasNameGenerator(db.reminders.analysisId, db.aiAnalyses.id),
      );

  $$AiAnalysesTableProcessedTableManager? get analysisId {
    final $_column = $_itemColumn<String>('analysis_id');
    if ($_column == null) return null;
    final manager = $$AiAnalysesTableTableManager(
      $_db,
      $_db.aiAnalyses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_analysisIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $EvidenceReferencesTable,
    List<EvidenceReferenceRow>
  >
  _evidenceReferencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.evidenceReferences,
        aliasName: $_aliasNameGenerator(
          db.reminders.id,
          db.evidenceReferences.reminderId,
        ),
      );

  $$EvidenceReferencesTableProcessedTableManager get evidenceReferencesRefs {
    final manager = $$EvidenceReferencesTableTableManager(
      $_db,
      $_db.evidenceReferences,
    ).filter((f) => f.reminderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _evidenceReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReminderStatus, ReminderStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<ReminderSource, ReminderSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get basis => $composableBuilder(
    column: $table.basis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Severity?, Severity, String> get severity =>
      $composableBuilder(
        column: $table.severity,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Confidence?, Confidence, String>
  get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dedupeKey => $composableBuilder(
    column: $table.dedupeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodEnd => $composableBuilder(
    column: $table.periodEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get postponedCount => $composableBuilder(
    column: $table.postponedCount,
    builder: (column) => ColumnFilters(column),
  );

  $$BeetlesTableFilterComposer get beetleId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemperatureSensorsTableFilterComposer get sensorId {
    final $$TemperatureSensorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sensorId,
      referencedTable: $db.temperatureSensors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemperatureSensorsTableFilterComposer(
            $db: $db,
            $table: $db.temperatureSensors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiAnalysesTableFilterComposer get analysisId {
    final $$AiAnalysesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.analysisId,
      referencedTable: $db.aiAnalyses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiAnalysesTableFilterComposer(
            $db: $db,
            $table: $db.aiAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> evidenceReferencesRefs(
    Expression<bool> Function($$EvidenceReferencesTableFilterComposer f) f,
  ) {
    final $$EvidenceReferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.evidenceReferences,
      getReferencedColumn: (t) => t.reminderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvidenceReferencesTableFilterComposer(
            $db: $db,
            $table: $db.evidenceReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get basis => $composableBuilder(
    column: $table.basis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dedupeKey => $composableBuilder(
    column: $table.dedupeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodEnd => $composableBuilder(
    column: $table.periodEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get postponedCount => $composableBuilder(
    column: $table.postponedCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeetlesTableOrderingComposer get beetleId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemperatureSensorsTableOrderingComposer get sensorId {
    final $$TemperatureSensorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sensorId,
      referencedTable: $db.temperatureSensors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemperatureSensorsTableOrderingComposer(
            $db: $db,
            $table: $db.temperatureSensors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiAnalysesTableOrderingComposer get analysisId {
    final $$AiAnalysesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.analysisId,
      referencedTable: $db.aiAnalyses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiAnalysesTableOrderingComposer(
            $db: $db,
            $table: $db.aiAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReminderStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReminderSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get basis =>
      $composableBuilder(column: $table.basis, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Severity?, String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Confidence?, String> get confidence =>
      $composableBuilder(
        column: $table.confidence,
        builder: (column) => column,
      );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dedupeKey =>
      $composableBuilder(column: $table.dedupeKey, builder: (column) => column);

  GeneratedColumn<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get periodEnd =>
      $composableBuilder(column: $table.periodEnd, builder: (column) => column);

  GeneratedColumn<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get postponedCount => $composableBuilder(
    column: $table.postponedCount,
    builder: (column) => column,
  );

  $$BeetlesTableAnnotationComposer get beetleId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemperatureSensorsTableAnnotationComposer get sensorId {
    final $$TemperatureSensorsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sensorId,
          referencedTable: $db.temperatureSensors,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TemperatureSensorsTableAnnotationComposer(
                $db: $db,
                $table: $db.temperatureSensors,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AiAnalysesTableAnnotationComposer get analysisId {
    final $$AiAnalysesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.analysisId,
      referencedTable: $db.aiAnalyses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiAnalysesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> evidenceReferencesRefs<T extends Object>(
    Expression<T> Function($$EvidenceReferencesTableAnnotationComposer a) f,
  ) {
    final $$EvidenceReferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.evidenceReferences,
          getReferencedColumn: (t) => t.reminderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvidenceReferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.evidenceReferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          ReminderRow,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (ReminderRow, $$RemindersTableReferences),
          ReminderRow,
          PrefetchHooks Function({
            bool beetleId,
            bool sensorId,
            bool analysisId,
            bool evidenceReferencesRefs,
          })
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String?> beetleId = const Value.absent(),
                Value<String?> sensorId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<DateTime> dueAt = const Value.absent(),
                Value<ReminderStatus> status = const Value.absent(),
                Value<ReminderSource> source = const Value.absent(),
                Value<String?> basis = const Value.absent(),
                Value<Severity?> severity = const Value.absent(),
                Value<Confidence?> confidence = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> recommendation = const Value.absent(),
                Value<String?> dedupeKey = const Value.absent(),
                Value<DateTime?> periodStart = const Value.absent(),
                Value<DateTime?> periodEnd = const Value.absent(),
                Value<int?> notificationId = const Value.absent(),
                Value<String?> analysisId = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> postponedCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                sensorId: sensorId,
                eventType: eventType,
                title: title,
                message: message,
                dueAt: dueAt,
                status: status,
                source: source,
                basis: basis,
                severity: severity,
                confidence: confidence,
                reason: reason,
                recommendation: recommendation,
                dedupeKey: dedupeKey,
                periodStart: periodStart,
                periodEnd: periodEnd,
                notificationId: notificationId,
                analysisId: analysisId,
                completedAt: completedAt,
                postponedCount: postponedCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String?> beetleId = const Value.absent(),
                Value<String?> sensorId = const Value.absent(),
                required String eventType,
                required String title,
                required String message,
                required DateTime dueAt,
                required ReminderStatus status,
                required ReminderSource source,
                Value<String?> basis = const Value.absent(),
                Value<Severity?> severity = const Value.absent(),
                Value<Confidence?> confidence = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> recommendation = const Value.absent(),
                Value<String?> dedupeKey = const Value.absent(),
                Value<DateTime?> periodStart = const Value.absent(),
                Value<DateTime?> periodEnd = const Value.absent(),
                Value<int?> notificationId = const Value.absent(),
                Value<String?> analysisId = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> postponedCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                sensorId: sensorId,
                eventType: eventType,
                title: title,
                message: message,
                dueAt: dueAt,
                status: status,
                source: source,
                basis: basis,
                severity: severity,
                confidence: confidence,
                reason: reason,
                recommendation: recommendation,
                dedupeKey: dedupeKey,
                periodStart: periodStart,
                periodEnd: periodEnd,
                notificationId: notificationId,
                analysisId: analysisId,
                completedAt: completedAt,
                postponedCount: postponedCount,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RemindersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            beetleId = false,
            sensorId = false,
            analysisId = false,
            evidenceReferencesRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (evidenceReferencesRefs) db.evidenceReferences,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (beetleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.beetleId,
                            referencedTable: $$RemindersTableReferences
                                ._beetleIdTable(db),
                            referencedColumn:
                                $$RemindersTableReferences
                                    ._beetleIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (sensorId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.sensorId,
                            referencedTable: $$RemindersTableReferences
                                ._sensorIdTable(db),
                            referencedColumn:
                                $$RemindersTableReferences
                                    ._sensorIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (analysisId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.analysisId,
                            referencedTable: $$RemindersTableReferences
                                ._analysisIdTable(db),
                            referencedColumn:
                                $$RemindersTableReferences
                                    ._analysisIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (evidenceReferencesRefs)
                    await $_getPrefetchedData<
                      ReminderRow,
                      $RemindersTable,
                      EvidenceReferenceRow
                    >(
                      currentTable: table,
                      referencedTable: $$RemindersTableReferences
                          ._evidenceReferencesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$RemindersTableReferences(
                                db,
                                table,
                                p0,
                              ).evidenceReferencesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.reminderId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      ReminderRow,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (ReminderRow, $$RemindersTableReferences),
      ReminderRow,
      PrefetchHooks Function({
        bool beetleId,
        bool sensorId,
        bool analysisId,
        bool evidenceReferencesRefs,
      })
    >;
typedef $$EvidenceReferencesTableCreateCompanionBuilder =
    EvidenceReferencesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String?> analysisId,
      Value<String?> reminderId,
      required RecordType recordType,
      required String recordId,
      Value<int> rowid,
    });
typedef $$EvidenceReferencesTableUpdateCompanionBuilder =
    EvidenceReferencesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String?> analysisId,
      Value<String?> reminderId,
      Value<RecordType> recordType,
      Value<String> recordId,
      Value<int> rowid,
    });

final class $$EvidenceReferencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EvidenceReferencesTable,
          EvidenceReferenceRow
        > {
  $$EvidenceReferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AiAnalysesTable _analysisIdTable(_$AppDatabase db) =>
      db.aiAnalyses.createAlias(
        $_aliasNameGenerator(
          db.evidenceReferences.analysisId,
          db.aiAnalyses.id,
        ),
      );

  $$AiAnalysesTableProcessedTableManager? get analysisId {
    final $_column = $_itemColumn<String>('analysis_id');
    if ($_column == null) return null;
    final manager = $$AiAnalysesTableTableManager(
      $_db,
      $_db.aiAnalyses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_analysisIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RemindersTable _reminderIdTable(_$AppDatabase db) =>
      db.reminders.createAlias(
        $_aliasNameGenerator(db.evidenceReferences.reminderId, db.reminders.id),
      );

  $$RemindersTableProcessedTableManager? get reminderId {
    final $_column = $_itemColumn<String>('reminder_id');
    if ($_column == null) return null;
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reminderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EvidenceReferencesTableFilterComposer
    extends Composer<_$AppDatabase, $EvidenceReferencesTable> {
  $$EvidenceReferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RecordType, RecordType, String>
  get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  $$AiAnalysesTableFilterComposer get analysisId {
    final $$AiAnalysesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.analysisId,
      referencedTable: $db.aiAnalyses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiAnalysesTableFilterComposer(
            $db: $db,
            $table: $db.aiAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RemindersTableFilterComposer get reminderId {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderId,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvidenceReferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $EvidenceReferencesTable> {
  $$EvidenceReferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiAnalysesTableOrderingComposer get analysisId {
    final $$AiAnalysesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.analysisId,
      referencedTable: $db.aiAnalyses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiAnalysesTableOrderingComposer(
            $db: $db,
            $table: $db.aiAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RemindersTableOrderingComposer get reminderId {
    final $$RemindersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderId,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableOrderingComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvidenceReferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvidenceReferencesTable> {
  $$EvidenceReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecordType, String> get recordType =>
      $composableBuilder(
        column: $table.recordType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  $$AiAnalysesTableAnnotationComposer get analysisId {
    final $$AiAnalysesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.analysisId,
      referencedTable: $db.aiAnalyses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiAnalysesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RemindersTableAnnotationComposer get reminderId {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderId,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvidenceReferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvidenceReferencesTable,
          EvidenceReferenceRow,
          $$EvidenceReferencesTableFilterComposer,
          $$EvidenceReferencesTableOrderingComposer,
          $$EvidenceReferencesTableAnnotationComposer,
          $$EvidenceReferencesTableCreateCompanionBuilder,
          $$EvidenceReferencesTableUpdateCompanionBuilder,
          (EvidenceReferenceRow, $$EvidenceReferencesTableReferences),
          EvidenceReferenceRow,
          PrefetchHooks Function({bool analysisId, bool reminderId})
        > {
  $$EvidenceReferencesTableTableManager(
    _$AppDatabase db,
    $EvidenceReferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EvidenceReferencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$EvidenceReferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$EvidenceReferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String?> analysisId = const Value.absent(),
                Value<String?> reminderId = const Value.absent(),
                Value<RecordType> recordType = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EvidenceReferencesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                analysisId: analysisId,
                reminderId: reminderId,
                recordType: recordType,
                recordId: recordId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String?> analysisId = const Value.absent(),
                Value<String?> reminderId = const Value.absent(),
                required RecordType recordType,
                required String recordId,
                Value<int> rowid = const Value.absent(),
              }) => EvidenceReferencesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                analysisId: analysisId,
                reminderId: reminderId,
                recordType: recordType,
                recordId: recordId,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$EvidenceReferencesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({analysisId = false, reminderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (analysisId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.analysisId,
                            referencedTable: $$EvidenceReferencesTableReferences
                                ._analysisIdTable(db),
                            referencedColumn:
                                $$EvidenceReferencesTableReferences
                                    ._analysisIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (reminderId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.reminderId,
                            referencedTable: $$EvidenceReferencesTableReferences
                                ._reminderIdTable(db),
                            referencedColumn:
                                $$EvidenceReferencesTableReferences
                                    ._reminderIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EvidenceReferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvidenceReferencesTable,
      EvidenceReferenceRow,
      $$EvidenceReferencesTableFilterComposer,
      $$EvidenceReferencesTableOrderingComposer,
      $$EvidenceReferencesTableAnnotationComposer,
      $$EvidenceReferencesTableCreateCompanionBuilder,
      $$EvidenceReferencesTableUpdateCompanionBuilder,
      (EvidenceReferenceRow, $$EvidenceReferencesTableReferences),
      EvidenceReferenceRow,
      PrefetchHooks Function({bool analysisId, bool reminderId})
    >;
typedef $$SuggestionSuppressionsTableCreateCompanionBuilder =
    SuggestionSuppressionsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String?> beetleId,
      required String eventType,
      Value<DateTime?> until,
      Value<int> rowid,
    });
typedef $$SuggestionSuppressionsTableUpdateCompanionBuilder =
    SuggestionSuppressionsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<String?> beetleId,
      Value<String> eventType,
      Value<DateTime?> until,
      Value<int> rowid,
    });

final class $$SuggestionSuppressionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SuggestionSuppressionsTable,
          SuggestionSuppressionRow
        > {
  $$SuggestionSuppressionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BeetlesTable _beetleIdTable(_$AppDatabase db) =>
      db.beetles.createAlias(
        $_aliasNameGenerator(db.suggestionSuppressions.beetleId, db.beetles.id),
      );

  $$BeetlesTableProcessedTableManager? get beetleId {
    final $_column = $_itemColumn<String>('beetle_id');
    if ($_column == null) return null;
    final manager = $$BeetlesTableTableManager(
      $_db,
      $_db.beetles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beetleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SuggestionSuppressionsTableFilterComposer
    extends Composer<_$AppDatabase, $SuggestionSuppressionsTable> {
  $$SuggestionSuppressionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get until => $composableBuilder(
    column: $table.until,
    builder: (column) => ColumnFilters(column),
  );

  $$BeetlesTableFilterComposer get beetleId {
    final $$BeetlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableFilterComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SuggestionSuppressionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SuggestionSuppressionsTable> {
  $$SuggestionSuppressionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get until => $composableBuilder(
    column: $table.until,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeetlesTableOrderingComposer get beetleId {
    final $$BeetlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableOrderingComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SuggestionSuppressionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuggestionSuppressionsTable> {
  $$SuggestionSuppressionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<DateTime> get until =>
      $composableBuilder(column: $table.until, builder: (column) => column);

  $$BeetlesTableAnnotationComposer get beetleId {
    final $$BeetlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beetleId,
      referencedTable: $db.beetles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeetlesTableAnnotationComposer(
            $db: $db,
            $table: $db.beetles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SuggestionSuppressionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuggestionSuppressionsTable,
          SuggestionSuppressionRow,
          $$SuggestionSuppressionsTableFilterComposer,
          $$SuggestionSuppressionsTableOrderingComposer,
          $$SuggestionSuppressionsTableAnnotationComposer,
          $$SuggestionSuppressionsTableCreateCompanionBuilder,
          $$SuggestionSuppressionsTableUpdateCompanionBuilder,
          (SuggestionSuppressionRow, $$SuggestionSuppressionsTableReferences),
          SuggestionSuppressionRow,
          PrefetchHooks Function({bool beetleId})
        > {
  $$SuggestionSuppressionsTableTableManager(
    _$AppDatabase db,
    $SuggestionSuppressionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SuggestionSuppressionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$SuggestionSuppressionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$SuggestionSuppressionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String?> beetleId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<DateTime?> until = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuggestionSuppressionsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                eventType: eventType,
                until: until,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<String?> beetleId = const Value.absent(),
                required String eventType,
                Value<DateTime?> until = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuggestionSuppressionsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                beetleId: beetleId,
                eventType: eventType,
                until: until,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SuggestionSuppressionsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({beetleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (beetleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.beetleId,
                            referencedTable:
                                $$SuggestionSuppressionsTableReferences
                                    ._beetleIdTable(db),
                            referencedColumn:
                                $$SuggestionSuppressionsTableReferences
                                    ._beetleIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SuggestionSuppressionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuggestionSuppressionsTable,
      SuggestionSuppressionRow,
      $$SuggestionSuppressionsTableFilterComposer,
      $$SuggestionSuppressionsTableOrderingComposer,
      $$SuggestionSuppressionsTableAnnotationComposer,
      $$SuggestionSuppressionsTableCreateCompanionBuilder,
      $$SuggestionSuppressionsTableUpdateCompanionBuilder,
      (SuggestionSuppressionRow, $$SuggestionSuppressionsTableReferences),
      SuggestionSuppressionRow,
      PrefetchHooks Function({bool beetleId})
    >;
typedef $$AiProviderSettingsTableCreateCompanionBuilder =
    AiProviderSettingsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      required AiProviderKind provider,
      Value<bool> enabled,
      Value<String?> baseUrl,
      Value<String?> model,
      Value<String?> certSha256,
      Value<int> timeoutSeconds,
      Value<DateTime?> consentGrantedAt,
      Value<int> rowid,
    });
typedef $$AiProviderSettingsTableUpdateCompanionBuilder =
    AiProviderSettingsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> revision,
      Value<AiProviderKind> provider,
      Value<bool> enabled,
      Value<String?> baseUrl,
      Value<String?> model,
      Value<String?> certSha256,
      Value<int> timeoutSeconds,
      Value<DateTime?> consentGrantedAt,
      Value<int> rowid,
    });

class $$AiProviderSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AiProviderSettingsTable> {
  $$AiProviderSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AiProviderKind, AiProviderKind, String>
  get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get certSha256 => $composableBuilder(
    column: $table.certSha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeoutSeconds => $composableBuilder(
    column: $table.timeoutSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get consentGrantedAt => $composableBuilder(
    column: $table.consentGrantedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiProviderSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiProviderSettingsTable> {
  $$AiProviderSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get certSha256 => $composableBuilder(
    column: $table.certSha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeoutSeconds => $composableBuilder(
    column: $table.timeoutSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get consentGrantedAt => $composableBuilder(
    column: $table.consentGrantedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiProviderSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiProviderSettingsTable> {
  $$AiProviderSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AiProviderKind, String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get certSha256 => $composableBuilder(
    column: $table.certSha256,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timeoutSeconds => $composableBuilder(
    column: $table.timeoutSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get consentGrantedAt => $composableBuilder(
    column: $table.consentGrantedAt,
    builder: (column) => column,
  );
}

class $$AiProviderSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiProviderSettingsTable,
          AiProviderSettingRow,
          $$AiProviderSettingsTableFilterComposer,
          $$AiProviderSettingsTableOrderingComposer,
          $$AiProviderSettingsTableAnnotationComposer,
          $$AiProviderSettingsTableCreateCompanionBuilder,
          $$AiProviderSettingsTableUpdateCompanionBuilder,
          (
            AiProviderSettingRow,
            BaseReferences<
              _$AppDatabase,
              $AiProviderSettingsTable,
              AiProviderSettingRow
            >,
          ),
          AiProviderSettingRow,
          PrefetchHooks Function()
        > {
  $$AiProviderSettingsTableTableManager(
    _$AppDatabase db,
    $AiProviderSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AiProviderSettingsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$AiProviderSettingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$AiProviderSettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<AiProviderKind> provider = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String?> baseUrl = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> certSha256 = const Value.absent(),
                Value<int> timeoutSeconds = const Value.absent(),
                Value<DateTime?> consentGrantedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiProviderSettingsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                provider: provider,
                enabled: enabled,
                baseUrl: baseUrl,
                model: model,
                certSha256: certSha256,
                timeoutSeconds: timeoutSeconds,
                consentGrantedAt: consentGrantedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required AiProviderKind provider,
                Value<bool> enabled = const Value.absent(),
                Value<String?> baseUrl = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> certSha256 = const Value.absent(),
                Value<int> timeoutSeconds = const Value.absent(),
                Value<DateTime?> consentGrantedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiProviderSettingsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                revision: revision,
                provider: provider,
                enabled: enabled,
                baseUrl: baseUrl,
                model: model,
                certSha256: certSha256,
                timeoutSeconds: timeoutSeconds,
                consentGrantedAt: consentGrantedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiProviderSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiProviderSettingsTable,
      AiProviderSettingRow,
      $$AiProviderSettingsTableFilterComposer,
      $$AiProviderSettingsTableOrderingComposer,
      $$AiProviderSettingsTableAnnotationComposer,
      $$AiProviderSettingsTableCreateCompanionBuilder,
      $$AiProviderSettingsTableUpdateCompanionBuilder,
      (
        AiProviderSettingRow,
        BaseReferences<
          _$AppDatabase,
          $AiProviderSettingsTable,
          AiProviderSettingRow
        >,
      ),
      AiProviderSettingRow,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSettingRow,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSettingRow,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingRow>,
          ),
          AppSettingRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSettingRow,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSettingRow,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingRow>,
      ),
      AppSettingRow,
      PrefetchHooks Function()
    >;
typedef $$BackupImportsTableCreateCompanionBuilder =
    BackupImportsCompanion Function({
      required String backupId,
      Value<DateTime> importedAt,
      required int insertedCount,
      required int updatedCount,
      required int skippedCount,
      Value<int> rowid,
    });
typedef $$BackupImportsTableUpdateCompanionBuilder =
    BackupImportsCompanion Function({
      Value<String> backupId,
      Value<DateTime> importedAt,
      Value<int> insertedCount,
      Value<int> updatedCount,
      Value<int> skippedCount,
      Value<int> rowid,
    });

class $$BackupImportsTableFilterComposer
    extends Composer<_$AppDatabase, $BackupImportsTable> {
  $$BackupImportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get backupId => $composableBuilder(
    column: $table.backupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get insertedCount => $composableBuilder(
    column: $table.insertedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedCount => $composableBuilder(
    column: $table.updatedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupImportsTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupImportsTable> {
  $$BackupImportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get backupId => $composableBuilder(
    column: $table.backupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get insertedCount => $composableBuilder(
    column: $table.insertedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedCount => $composableBuilder(
    column: $table.updatedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupImportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupImportsTable> {
  $$BackupImportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get backupId =>
      $composableBuilder(column: $table.backupId, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get insertedCount => $composableBuilder(
    column: $table.insertedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedCount => $composableBuilder(
    column: $table.updatedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => column,
  );
}

class $$BackupImportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupImportsTable,
          BackupImportRow,
          $$BackupImportsTableFilterComposer,
          $$BackupImportsTableOrderingComposer,
          $$BackupImportsTableAnnotationComposer,
          $$BackupImportsTableCreateCompanionBuilder,
          $$BackupImportsTableUpdateCompanionBuilder,
          (
            BackupImportRow,
            BaseReferences<_$AppDatabase, $BackupImportsTable, BackupImportRow>,
          ),
          BackupImportRow,
          PrefetchHooks Function()
        > {
  $$BackupImportsTableTableManager(_$AppDatabase db, $BackupImportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BackupImportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$BackupImportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BackupImportsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> backupId = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<int> insertedCount = const Value.absent(),
                Value<int> updatedCount = const Value.absent(),
                Value<int> skippedCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupImportsCompanion(
                backupId: backupId,
                importedAt: importedAt,
                insertedCount: insertedCount,
                updatedCount: updatedCount,
                skippedCount: skippedCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String backupId,
                Value<DateTime> importedAt = const Value.absent(),
                required int insertedCount,
                required int updatedCount,
                required int skippedCount,
                Value<int> rowid = const Value.absent(),
              }) => BackupImportsCompanion.insert(
                backupId: backupId,
                importedAt: importedAt,
                insertedCount: insertedCount,
                updatedCount: updatedCount,
                skippedCount: skippedCount,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupImportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupImportsTable,
      BackupImportRow,
      $$BackupImportsTableFilterComposer,
      $$BackupImportsTableOrderingComposer,
      $$BackupImportsTableAnnotationComposer,
      $$BackupImportsTableCreateCompanionBuilder,
      $$BackupImportsTableUpdateCompanionBuilder,
      (
        BackupImportRow,
        BaseReferences<_$AppDatabase, $BackupImportsTable, BackupImportRow>,
      ),
      BackupImportRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SpeciesTableTableManager get species =>
      $$SpeciesTableTableManager(_db, _db.species);
  $$TemperatureSensorsTableTableManager get temperatureSensors =>
      $$TemperatureSensorsTableTableManager(_db, _db.temperatureSensors);
  $$BeetlesTableTableManager get beetles =>
      $$BeetlesTableTableManager(_db, _db.beetles);
  $$WeightRecordsTableTableManager get weightRecords =>
      $$WeightRecordsTableTableManager(_db, _db.weightRecords);
  $$ObservationRecordsTableTableManager get observationRecords =>
      $$ObservationRecordsTableTableManager(_db, _db.observationRecords);
  $$TemperatureRecordsTableTableManager get temperatureRecords =>
      $$TemperatureRecordsTableTableManager(_db, _db.temperatureRecords);
  $$SubstrateChangesTableTableManager get substrateChanges =>
      $$SubstrateChangesTableTableManager(_db, _db.substrateChanges);
  $$ContainerChangesTableTableManager get containerChanges =>
      $$ContainerChangesTableTableManager(_db, _db.containerChanges);
  $$LifeStageEventsTableTableManager get lifeStageEvents =>
      $$LifeStageEventsTableTableManager(_db, _db.lifeStageEvents);
  $$PhotoAttachmentsTableTableManager get photoAttachments =>
      $$PhotoAttachmentsTableTableManager(_db, _db.photoAttachments);
  $$AiAnalysesTableTableManager get aiAnalyses =>
      $$AiAnalysesTableTableManager(_db, _db.aiAnalyses);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$EvidenceReferencesTableTableManager get evidenceReferences =>
      $$EvidenceReferencesTableTableManager(_db, _db.evidenceReferences);
  $$SuggestionSuppressionsTableTableManager get suggestionSuppressions =>
      $$SuggestionSuppressionsTableTableManager(
        _db,
        _db.suggestionSuppressions,
      );
  $$AiProviderSettingsTableTableManager get aiProviderSettings =>
      $$AiProviderSettingsTableTableManager(_db, _db.aiProviderSettings);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$BackupImportsTableTableManager get backupImports =>
      $$BackupImportsTableTableManager(_db, _db.backupImports);
}

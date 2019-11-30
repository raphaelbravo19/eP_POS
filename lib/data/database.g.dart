// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class CountryData extends DataClass implements Insertable<CountryData> {
  final String id;
  final String name;
  final int dialCode;
  final String domainExtension;
  final String alpha2Code;
  final String alpha3Code;
  final int numericCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  CountryData(
      {@required this.id,
      @required this.name,
      @required this.dialCode,
      this.domainExtension,
      @required this.alpha2Code,
      @required this.alpha3Code,
      @required this.numericCode,
      this.createdAt,
      this.updatedAt});
  factory CountryData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CountryData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      dialCode:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}dial_code']),
      domainExtension: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}domain_extension']),
      alpha2Code: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}alpha2_code']),
      alpha3Code: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}alpha3_code']),
      numericCode: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}numeric_code']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory CountryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CountryData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dialCode: serializer.fromJson<int>(json['dialCode']),
      domainExtension: serializer.fromJson<String>(json['domainExtension']),
      alpha2Code: serializer.fromJson<String>(json['alpha2Code']),
      alpha3Code: serializer.fromJson<String>(json['alpha3Code']),
      numericCode: serializer.fromJson<int>(json['numericCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'dialCode': serializer.toJson<int>(dialCode),
      'domainExtension': serializer.toJson<String>(domainExtension),
      'alpha2Code': serializer.toJson<String>(alpha2Code),
      'alpha3Code': serializer.toJson<String>(alpha3Code),
      'numericCode': serializer.toJson<int>(numericCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<CountryData>>(bool nullToAbsent) {
    return CountryCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      dialCode: dialCode == null && nullToAbsent
          ? const Value.absent()
          : Value(dialCode),
      domainExtension: domainExtension == null && nullToAbsent
          ? const Value.absent()
          : Value(domainExtension),
      alpha2Code: alpha2Code == null && nullToAbsent
          ? const Value.absent()
          : Value(alpha2Code),
      alpha3Code: alpha3Code == null && nullToAbsent
          ? const Value.absent()
          : Value(alpha3Code),
      numericCode: numericCode == null && nullToAbsent
          ? const Value.absent()
          : Value(numericCode),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  CountryData copyWith(
          {String id,
          String name,
          int dialCode,
          String domainExtension,
          String alpha2Code,
          String alpha3Code,
          int numericCode,
          DateTime createdAt,
          DateTime updatedAt}) =>
      CountryData(
        id: id ?? this.id,
        name: name ?? this.name,
        dialCode: dialCode ?? this.dialCode,
        domainExtension: domainExtension ?? this.domainExtension,
        alpha2Code: alpha2Code ?? this.alpha2Code,
        alpha3Code: alpha3Code ?? this.alpha3Code,
        numericCode: numericCode ?? this.numericCode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CountryData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dialCode: $dialCode, ')
          ..write('domainExtension: $domainExtension, ')
          ..write('alpha2Code: $alpha2Code, ')
          ..write('alpha3Code: $alpha3Code, ')
          ..write('numericCode: $numericCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              dialCode.hashCode,
              $mrjc(
                  domainExtension.hashCode,
                  $mrjc(
                      alpha2Code.hashCode,
                      $mrjc(
                          alpha3Code.hashCode,
                          $mrjc(
                              numericCode.hashCode,
                              $mrjc(createdAt.hashCode,
                                  updatedAt.hashCode)))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is CountryData &&
          other.id == id &&
          other.name == name &&
          other.dialCode == dialCode &&
          other.domainExtension == domainExtension &&
          other.alpha2Code == alpha2Code &&
          other.alpha3Code == alpha3Code &&
          other.numericCode == numericCode &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class CountryCompanion extends UpdateCompanion<CountryData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> dialCode;
  final Value<String> domainExtension;
  final Value<String> alpha2Code;
  final Value<String> alpha3Code;
  final Value<int> numericCode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CountryCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dialCode = const Value.absent(),
    this.domainExtension = const Value.absent(),
    this.alpha2Code = const Value.absent(),
    this.alpha3Code = const Value.absent(),
    this.numericCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CountryCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<int> dialCode,
      Value<String> domainExtension,
      Value<String> alpha2Code,
      Value<String> alpha3Code,
      Value<int> numericCode,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CountryCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dialCode: dialCode ?? this.dialCode,
      domainExtension: domainExtension ?? this.domainExtension,
      alpha2Code: alpha2Code ?? this.alpha2Code,
      alpha3Code: alpha3Code ?? this.alpha3Code,
      numericCode: numericCode ?? this.numericCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CountryTable extends Country with TableInfo<$CountryTable, CountryData> {
  final GeneratedDatabase _db;
  final String _alias;
  $CountryTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dialCodeMeta = const VerificationMeta('dialCode');
  GeneratedIntColumn _dialCode;
  @override
  GeneratedIntColumn get dialCode => _dialCode ??= _constructDialCode();
  GeneratedIntColumn _constructDialCode() {
    return GeneratedIntColumn(
      'dial_code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _domainExtensionMeta =
      const VerificationMeta('domainExtension');
  GeneratedTextColumn _domainExtension;
  @override
  GeneratedTextColumn get domainExtension =>
      _domainExtension ??= _constructDomainExtension();
  GeneratedTextColumn _constructDomainExtension() {
    return GeneratedTextColumn(
      'domain_extension',
      $tableName,
      true,
    );
  }

  final VerificationMeta _alpha2CodeMeta = const VerificationMeta('alpha2Code');
  GeneratedTextColumn _alpha2Code;
  @override
  GeneratedTextColumn get alpha2Code => _alpha2Code ??= _constructAlpha2Code();
  GeneratedTextColumn _constructAlpha2Code() {
    return GeneratedTextColumn('alpha2_code', $tableName, false,
        minTextLength: 2, maxTextLength: 2);
  }

  final VerificationMeta _alpha3CodeMeta = const VerificationMeta('alpha3Code');
  GeneratedTextColumn _alpha3Code;
  @override
  GeneratedTextColumn get alpha3Code => _alpha3Code ??= _constructAlpha3Code();
  GeneratedTextColumn _constructAlpha3Code() {
    return GeneratedTextColumn('alpha3_code', $tableName, false,
        minTextLength: 3, maxTextLength: 3);
  }

  final VerificationMeta _numericCodeMeta =
      const VerificationMeta('numericCode');
  GeneratedIntColumn _numericCode;
  @override
  GeneratedIntColumn get numericCode =>
      _numericCode ??= _constructNumericCode();
  GeneratedIntColumn _constructNumericCode() {
    return GeneratedIntColumn(
      'numeric_code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        dialCode,
        domainExtension,
        alpha2Code,
        alpha3Code,
        numericCode,
        createdAt,
        updatedAt
      ];
  @override
  $CountryTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'country';
  @override
  final String actualTableName = 'country';
  @override
  VerificationContext validateIntegrity(CountryCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.dialCode.present) {
      context.handle(_dialCodeMeta,
          dialCode.isAcceptableValue(d.dialCode.value, _dialCodeMeta));
    } else if (dialCode.isRequired && isInserting) {
      context.missing(_dialCodeMeta);
    }
    if (d.domainExtension.present) {
      context.handle(
          _domainExtensionMeta,
          domainExtension.isAcceptableValue(
              d.domainExtension.value, _domainExtensionMeta));
    } else if (domainExtension.isRequired && isInserting) {
      context.missing(_domainExtensionMeta);
    }
    if (d.alpha2Code.present) {
      context.handle(_alpha2CodeMeta,
          alpha2Code.isAcceptableValue(d.alpha2Code.value, _alpha2CodeMeta));
    } else if (alpha2Code.isRequired && isInserting) {
      context.missing(_alpha2CodeMeta);
    }
    if (d.alpha3Code.present) {
      context.handle(_alpha3CodeMeta,
          alpha3Code.isAcceptableValue(d.alpha3Code.value, _alpha3CodeMeta));
    } else if (alpha3Code.isRequired && isInserting) {
      context.missing(_alpha3CodeMeta);
    }
    if (d.numericCode.present) {
      context.handle(_numericCodeMeta,
          numericCode.isAcceptableValue(d.numericCode.value, _numericCodeMeta));
    } else if (numericCode.isRequired && isInserting) {
      context.missing(_numericCodeMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CountryData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CountryData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CountryCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.dialCode.present) {
      map['dial_code'] = Variable<int, IntType>(d.dialCode.value);
    }
    if (d.domainExtension.present) {
      map['domain_extension'] =
          Variable<String, StringType>(d.domainExtension.value);
    }
    if (d.alpha2Code.present) {
      map['alpha2_code'] = Variable<String, StringType>(d.alpha2Code.value);
    }
    if (d.alpha3Code.present) {
      map['alpha3_code'] = Variable<String, StringType>(d.alpha3Code.value);
    }
    if (d.numericCode.present) {
      map['numeric_code'] = Variable<int, IntType>(d.numericCode.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CountryTable createAlias(String alias) {
    return $CountryTable(_db, alias);
  }
}

class Unit extends DataClass implements Insertable<Unit> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  Unit(
      {@required this.id, @required this.name, this.createdAt, this.updatedAt});
  factory Unit.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Unit(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Unit.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Unit(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Unit>>(bool nullToAbsent) {
    return UnitsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Unit copyWith(
          {String id, String name, DateTime createdAt, DateTime updatedAt}) =>
      Unit(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Unit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(createdAt.hashCode, updatedAt.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Unit &&
          other.id == id &&
          other.name == name &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class UnitsCompanion extends UpdateCompanion<Unit> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UnitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UnitsCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return UnitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $UnitsTable extends Units with TableInfo<$UnitsTable, Unit> {
  final GeneratedDatabase _db;
  final String _alias;
  $UnitsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt, updatedAt];
  @override
  $UnitsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'units';
  @override
  final String actualTableName = 'units';
  @override
  VerificationContext validateIntegrity(UnitsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Unit map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Unit.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UnitsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $UnitsTable createAlias(String alias) {
    return $UnitsTable(_db, alias);
  }
}

class Area extends DataClass implements Insertable<Area> {
  final String id;
  final String name;
  final String cityId;
  final String pinCode;
  final String taluka;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  Area(
      {@required this.id,
      @required this.name,
      @required this.cityId,
      @required this.pinCode,
      @required this.taluka,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory Area.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Area(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      cityId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}city_id']),
      pinCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pin_code']),
      taluka:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}taluka']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Area.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Area(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      cityId: serializer.fromJson<String>(json['cityId']),
      pinCode: serializer.fromJson<String>(json['pinCode']),
      taluka: serializer.fromJson<String>(json['taluka']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'cityId': serializer.toJson<String>(cityId),
      'pinCode': serializer.toJson<String>(pinCode),
      'taluka': serializer.toJson<String>(taluka),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Area>>(bool nullToAbsent) {
    return AreasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      cityId:
          cityId == null && nullToAbsent ? const Value.absent() : Value(cityId),
      pinCode: pinCode == null && nullToAbsent
          ? const Value.absent()
          : Value(pinCode),
      taluka:
          taluka == null && nullToAbsent ? const Value.absent() : Value(taluka),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Area copyWith(
          {String id,
          String name,
          String cityId,
          String pinCode,
          String taluka,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Area(
        id: id ?? this.id,
        name: name ?? this.name,
        cityId: cityId ?? this.cityId,
        pinCode: pinCode ?? this.pinCode,
        taluka: taluka ?? this.taluka,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Area(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cityId: $cityId, ')
          ..write('pinCode: $pinCode, ')
          ..write('taluka: $taluka, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              cityId.hashCode,
              $mrjc(
                  pinCode.hashCode,
                  $mrjc(
                      taluka.hashCode,
                      $mrjc(status.hashCode,
                          $mrjc(createdAt.hashCode, updatedAt.hashCode))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Area &&
          other.id == id &&
          other.name == name &&
          other.cityId == cityId &&
          other.pinCode == pinCode &&
          other.taluka == taluka &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class AreasCompanion extends UpdateCompanion<Area> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> cityId;
  final Value<String> pinCode;
  final Value<String> taluka;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AreasCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.cityId = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.taluka = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AreasCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> cityId,
      Value<String> pinCode,
      Value<String> taluka,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return AreasCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      cityId: cityId ?? this.cityId,
      pinCode: pinCode ?? this.pinCode,
      taluka: taluka ?? this.taluka,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $AreasTable extends Areas with TableInfo<$AreasTable, Area> {
  final GeneratedDatabase _db;
  final String _alias;
  $AreasTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cityIdMeta = const VerificationMeta('cityId');
  GeneratedTextColumn _cityId;
  @override
  GeneratedTextColumn get cityId => _cityId ??= _constructCityId();
  GeneratedTextColumn _constructCityId() {
    return GeneratedTextColumn(
      'city_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pinCodeMeta = const VerificationMeta('pinCode');
  GeneratedTextColumn _pinCode;
  @override
  GeneratedTextColumn get pinCode => _pinCode ??= _constructPinCode();
  GeneratedTextColumn _constructPinCode() {
    return GeneratedTextColumn(
      'pin_code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _talukaMeta = const VerificationMeta('taluka');
  GeneratedTextColumn _taluka;
  @override
  GeneratedTextColumn get taluka => _taluka ??= _constructTaluka();
  GeneratedTextColumn _constructTaluka() {
    return GeneratedTextColumn(
      'taluka',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, cityId, pinCode, taluka, status, createdAt, updatedAt];
  @override
  $AreasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'areas';
  @override
  final String actualTableName = 'areas';
  @override
  VerificationContext validateIntegrity(AreasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.cityId.present) {
      context.handle(
          _cityIdMeta, cityId.isAcceptableValue(d.cityId.value, _cityIdMeta));
    } else if (cityId.isRequired && isInserting) {
      context.missing(_cityIdMeta);
    }
    if (d.pinCode.present) {
      context.handle(_pinCodeMeta,
          pinCode.isAcceptableValue(d.pinCode.value, _pinCodeMeta));
    } else if (pinCode.isRequired && isInserting) {
      context.missing(_pinCodeMeta);
    }
    if (d.taluka.present) {
      context.handle(
          _talukaMeta, taluka.isAcceptableValue(d.taluka.value, _talukaMeta));
    } else if (taluka.isRequired && isInserting) {
      context.missing(_talukaMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Area map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Area.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AreasCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.cityId.present) {
      map['city_id'] = Variable<String, StringType>(d.cityId.value);
    }
    if (d.pinCode.present) {
      map['pin_code'] = Variable<String, StringType>(d.pinCode.value);
    }
    if (d.taluka.present) {
      map['taluka'] = Variable<String, StringType>(d.taluka.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $AreasTable createAlias(String alias) {
    return $AreasTable(_db, alias);
  }
}

class CityData extends DataClass implements Insertable<CityData> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  CityData(
      {@required this.id, @required this.name, this.createdAt, this.updatedAt});
  factory CityData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CityData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory CityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CityData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<CityData>>(bool nullToAbsent) {
    return CityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  CityData copyWith(
          {String id, String name, DateTime createdAt, DateTime updatedAt}) =>
      CityData(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CityData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(createdAt.hashCode, updatedAt.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is CityData &&
          other.id == id &&
          other.name == name &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class CityCompanion extends UpdateCompanion<CityData> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CityCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CityTable extends City with TableInfo<$CityTable, CityData> {
  final GeneratedDatabase _db;
  final String _alias;
  $CityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt, updatedAt];
  @override
  $CityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'city';
  @override
  final String actualTableName = 'city';
  @override
  VerificationContext validateIntegrity(CityCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CityData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CityData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CityCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CityTable createAlias(String alias) {
    return $CityTable(_db, alias);
  }
}

class CountryState extends DataClass implements Insertable<CountryState> {
  final String id;
  final String name;
  final String countryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  CountryState(
      {@required this.id,
      @required this.name,
      @required this.countryId,
      this.createdAt,
      this.updatedAt});
  factory CountryState.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CountryState(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      countryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}country_id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory CountryState.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CountryState(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      countryId: serializer.fromJson<String>(json['countryId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'countryId': serializer.toJson<String>(countryId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<CountryState>>(
      bool nullToAbsent) {
    return CountryStatesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      countryId: countryId == null && nullToAbsent
          ? const Value.absent()
          : Value(countryId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  CountryState copyWith(
          {String id,
          String name,
          String countryId,
          DateTime createdAt,
          DateTime updatedAt}) =>
      CountryState(
        id: id ?? this.id,
        name: name ?? this.name,
        countryId: countryId ?? this.countryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CountryState(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryId: $countryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(countryId.hashCode,
              $mrjc(createdAt.hashCode, updatedAt.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is CountryState &&
          other.id == id &&
          other.name == name &&
          other.countryId == countryId &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class CountryStatesCompanion extends UpdateCompanion<CountryState> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> countryId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CountryStatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.countryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CountryStatesCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> countryId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CountryStatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      countryId: countryId ?? this.countryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CountryStatesTable extends CountryStates
    with TableInfo<$CountryStatesTable, CountryState> {
  final GeneratedDatabase _db;
  final String _alias;
  $CountryStatesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countryIdMeta = const VerificationMeta('countryId');
  GeneratedTextColumn _countryId;
  @override
  GeneratedTextColumn get countryId => _countryId ??= _constructCountryId();
  GeneratedTextColumn _constructCountryId() {
    return GeneratedTextColumn(
      'country_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, countryId, createdAt, updatedAt];
  @override
  $CountryStatesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'country_states';
  @override
  final String actualTableName = 'country_states';
  @override
  VerificationContext validateIntegrity(CountryStatesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.countryId.present) {
      context.handle(_countryIdMeta,
          countryId.isAcceptableValue(d.countryId.value, _countryIdMeta));
    } else if (countryId.isRequired && isInserting) {
      context.missing(_countryIdMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CountryState map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CountryState.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CountryStatesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.countryId.present) {
      map['country_id'] = Variable<String, StringType>(d.countryId.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CountryStatesTable createAlias(String alias) {
    return $CountryStatesTable(_db, alias);
  }
}

class IndustryData extends DataClass implements Insertable<IndustryData> {
  final String id;
  final String name;
  final int level;
  final String industryParentId;
  final String parentId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  IndustryData(
      {@required this.id,
      @required this.name,
      this.level,
      this.industryParentId,
      this.parentId,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory IndustryData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return IndustryData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      level: intType.mapFromDatabaseResponse(data['${effectivePrefix}level']),
      industryParentId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}industry_parent_id']),
      parentId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_id']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory IndustryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return IndustryData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      level: serializer.fromJson<int>(json['level']),
      industryParentId: serializer.fromJson<String>(json['industryParentId']),
      parentId: serializer.fromJson<String>(json['parentId']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'level': serializer.toJson<int>(level),
      'industryParentId': serializer.toJson<String>(industryParentId),
      'parentId': serializer.toJson<String>(parentId),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<IndustryData>>(
      bool nullToAbsent) {
    return IndustryCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      level:
          level == null && nullToAbsent ? const Value.absent() : Value(level),
      industryParentId: industryParentId == null && nullToAbsent
          ? const Value.absent()
          : Value(industryParentId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  IndustryData copyWith(
          {String id,
          String name,
          int level,
          String industryParentId,
          String parentId,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      IndustryData(
        id: id ?? this.id,
        name: name ?? this.name,
        level: level ?? this.level,
        industryParentId: industryParentId ?? this.industryParentId,
        parentId: parentId ?? this.parentId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('IndustryData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('industryParentId: $industryParentId, ')
          ..write('parentId: $parentId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              level.hashCode,
              $mrjc(
                  industryParentId.hashCode,
                  $mrjc(
                      parentId.hashCode,
                      $mrjc(status.hashCode,
                          $mrjc(createdAt.hashCode, updatedAt.hashCode))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is IndustryData &&
          other.id == id &&
          other.name == name &&
          other.level == level &&
          other.industryParentId == industryParentId &&
          other.parentId == parentId &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class IndustryCompanion extends UpdateCompanion<IndustryData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> level;
  final Value<String> industryParentId;
  final Value<String> parentId;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const IndustryCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.level = const Value.absent(),
    this.industryParentId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  IndustryCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<int> level,
      Value<String> industryParentId,
      Value<String> parentId,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return IndustryCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      industryParentId: industryParentId ?? this.industryParentId,
      parentId: parentId ?? this.parentId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $IndustryTable extends Industry
    with TableInfo<$IndustryTable, IndustryData> {
  final GeneratedDatabase _db;
  final String _alias;
  $IndustryTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _levelMeta = const VerificationMeta('level');
  GeneratedIntColumn _level;
  @override
  GeneratedIntColumn get level => _level ??= _constructLevel();
  GeneratedIntColumn _constructLevel() {
    return GeneratedIntColumn(
      'level',
      $tableName,
      true,
    );
  }

  final VerificationMeta _industryParentIdMeta =
      const VerificationMeta('industryParentId');
  GeneratedTextColumn _industryParentId;
  @override
  GeneratedTextColumn get industryParentId =>
      _industryParentId ??= _constructIndustryParentId();
  GeneratedTextColumn _constructIndustryParentId() {
    return GeneratedTextColumn(
      'industry_parent_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  GeneratedTextColumn _parentId;
  @override
  GeneratedTextColumn get parentId => _parentId ??= _constructParentId();
  GeneratedTextColumn _constructParentId() {
    return GeneratedTextColumn(
      'parent_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        level,
        industryParentId,
        parentId,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $IndustryTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'industry';
  @override
  final String actualTableName = 'industry';
  @override
  VerificationContext validateIntegrity(IndustryCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.level.present) {
      context.handle(
          _levelMeta, level.isAcceptableValue(d.level.value, _levelMeta));
    } else if (level.isRequired && isInserting) {
      context.missing(_levelMeta);
    }
    if (d.industryParentId.present) {
      context.handle(
          _industryParentIdMeta,
          industryParentId.isAcceptableValue(
              d.industryParentId.value, _industryParentIdMeta));
    } else if (industryParentId.isRequired && isInserting) {
      context.missing(_industryParentIdMeta);
    }
    if (d.parentId.present) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableValue(d.parentId.value, _parentIdMeta));
    } else if (parentId.isRequired && isInserting) {
      context.missing(_parentIdMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IndustryData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return IndustryData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(IndustryCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.level.present) {
      map['level'] = Variable<int, IntType>(d.level.value);
    }
    if (d.industryParentId.present) {
      map['industry_parent_id'] =
          Variable<String, StringType>(d.industryParentId.value);
    }
    if (d.parentId.present) {
      map['parent_id'] = Variable<String, StringType>(d.parentId.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $IndustryTable createAlias(String alias) {
    return $IndustryTable(_db, alias);
  }
}

class BusinessTypeData extends DataClass
    implements Insertable<BusinessTypeData> {
  final String id;
  final String name;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  BusinessTypeData(
      {@required this.id,
      @required this.name,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory BusinessTypeData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return BusinessTypeData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory BusinessTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return BusinessTypeData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<BusinessTypeData>>(
      bool nullToAbsent) {
    return BusinessTypeCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  BusinessTypeData copyWith(
          {String id,
          String name,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      BusinessTypeData(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('BusinessTypeData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(status.hashCode,
              $mrjc(createdAt.hashCode, updatedAt.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is BusinessTypeData &&
          other.id == id &&
          other.name == name &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class BusinessTypeCompanion extends UpdateCompanion<BusinessTypeData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BusinessTypeCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BusinessTypeCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return BusinessTypeCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $BusinessTypeTable extends BusinessType
    with TableInfo<$BusinessTypeTable, BusinessTypeData> {
  final GeneratedDatabase _db;
  final String _alias;
  $BusinessTypeTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, status, createdAt, updatedAt];
  @override
  $BusinessTypeTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'business_type';
  @override
  final String actualTableName = 'business_type';
  @override
  VerificationContext validateIntegrity(BusinessTypeCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  BusinessTypeData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BusinessTypeData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(BusinessTypeCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $BusinessTypeTable createAlias(String alias) {
    return $BusinessTypeTable(_db, alias);
  }
}

class Tax extends DataClass implements Insertable<Tax> {
  final String id;
  final String name;
  final String countryId;
  final String taxType;
  final int slab;
  final int taxValue;
  final String taxMode;
  final String displayName1;
  final String displayName2;
  final String displayName3;
  final int cgstValue;
  final int sgstValue;
  final int igstValue;
  final DateTime createdAt;
  final DateTime updatedAt;
  Tax(
      {@required this.id,
      @required this.name,
      @required this.countryId,
      @required this.taxType,
      @required this.slab,
      @required this.taxValue,
      @required this.taxMode,
      @required this.displayName1,
      @required this.displayName2,
      @required this.displayName3,
      @required this.cgstValue,
      @required this.sgstValue,
      @required this.igstValue,
      this.createdAt,
      this.updatedAt});
  factory Tax.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Tax(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      countryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}country_id']),
      taxType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tax_type']),
      slab: intType.mapFromDatabaseResponse(data['${effectivePrefix}slab']),
      taxValue:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}tax_value']),
      taxMode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tax_mode']),
      displayName1: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name1']),
      displayName2: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name2']),
      displayName3: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name3']),
      cgstValue:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}cgst_value']),
      sgstValue:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sgst_value']),
      igstValue:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}igst_value']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Tax.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Tax(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      countryId: serializer.fromJson<String>(json['countryId']),
      taxType: serializer.fromJson<String>(json['taxType']),
      slab: serializer.fromJson<int>(json['slab']),
      taxValue: serializer.fromJson<int>(json['taxValue']),
      taxMode: serializer.fromJson<String>(json['taxMode']),
      displayName1: serializer.fromJson<String>(json['displayName1']),
      displayName2: serializer.fromJson<String>(json['displayName2']),
      displayName3: serializer.fromJson<String>(json['displayName3']),
      cgstValue: serializer.fromJson<int>(json['cgstValue']),
      sgstValue: serializer.fromJson<int>(json['sgstValue']),
      igstValue: serializer.fromJson<int>(json['igstValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'countryId': serializer.toJson<String>(countryId),
      'taxType': serializer.toJson<String>(taxType),
      'slab': serializer.toJson<int>(slab),
      'taxValue': serializer.toJson<int>(taxValue),
      'taxMode': serializer.toJson<String>(taxMode),
      'displayName1': serializer.toJson<String>(displayName1),
      'displayName2': serializer.toJson<String>(displayName2),
      'displayName3': serializer.toJson<String>(displayName3),
      'cgstValue': serializer.toJson<int>(cgstValue),
      'sgstValue': serializer.toJson<int>(sgstValue),
      'igstValue': serializer.toJson<int>(igstValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Tax>>(bool nullToAbsent) {
    return TaxsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      countryId: countryId == null && nullToAbsent
          ? const Value.absent()
          : Value(countryId),
      taxType: taxType == null && nullToAbsent
          ? const Value.absent()
          : Value(taxType),
      slab: slab == null && nullToAbsent ? const Value.absent() : Value(slab),
      taxValue: taxValue == null && nullToAbsent
          ? const Value.absent()
          : Value(taxValue),
      taxMode: taxMode == null && nullToAbsent
          ? const Value.absent()
          : Value(taxMode),
      displayName1: displayName1 == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName1),
      displayName2: displayName2 == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName2),
      displayName3: displayName3 == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName3),
      cgstValue: cgstValue == null && nullToAbsent
          ? const Value.absent()
          : Value(cgstValue),
      sgstValue: sgstValue == null && nullToAbsent
          ? const Value.absent()
          : Value(sgstValue),
      igstValue: igstValue == null && nullToAbsent
          ? const Value.absent()
          : Value(igstValue),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Tax copyWith(
          {String id,
          String name,
          String countryId,
          String taxType,
          int slab,
          int taxValue,
          String taxMode,
          String displayName1,
          String displayName2,
          String displayName3,
          int cgstValue,
          int sgstValue,
          int igstValue,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Tax(
        id: id ?? this.id,
        name: name ?? this.name,
        countryId: countryId ?? this.countryId,
        taxType: taxType ?? this.taxType,
        slab: slab ?? this.slab,
        taxValue: taxValue ?? this.taxValue,
        taxMode: taxMode ?? this.taxMode,
        displayName1: displayName1 ?? this.displayName1,
        displayName2: displayName2 ?? this.displayName2,
        displayName3: displayName3 ?? this.displayName3,
        cgstValue: cgstValue ?? this.cgstValue,
        sgstValue: sgstValue ?? this.sgstValue,
        igstValue: igstValue ?? this.igstValue,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Tax(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryId: $countryId, ')
          ..write('taxType: $taxType, ')
          ..write('slab: $slab, ')
          ..write('taxValue: $taxValue, ')
          ..write('taxMode: $taxMode, ')
          ..write('displayName1: $displayName1, ')
          ..write('displayName2: $displayName2, ')
          ..write('displayName3: $displayName3, ')
          ..write('cgstValue: $cgstValue, ')
          ..write('sgstValue: $sgstValue, ')
          ..write('igstValue: $igstValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              countryId.hashCode,
              $mrjc(
                  taxType.hashCode,
                  $mrjc(
                      slab.hashCode,
                      $mrjc(
                          taxValue.hashCode,
                          $mrjc(
                              taxMode.hashCode,
                              $mrjc(
                                  displayName1.hashCode,
                                  $mrjc(
                                      displayName2.hashCode,
                                      $mrjc(
                                          displayName3.hashCode,
                                          $mrjc(
                                              cgstValue.hashCode,
                                              $mrjc(
                                                  sgstValue.hashCode,
                                                  $mrjc(
                                                      igstValue.hashCode,
                                                      $mrjc(
                                                          createdAt.hashCode,
                                                          updatedAt
                                                              .hashCode)))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Tax &&
          other.id == id &&
          other.name == name &&
          other.countryId == countryId &&
          other.taxType == taxType &&
          other.slab == slab &&
          other.taxValue == taxValue &&
          other.taxMode == taxMode &&
          other.displayName1 == displayName1 &&
          other.displayName2 == displayName2 &&
          other.displayName3 == displayName3 &&
          other.cgstValue == cgstValue &&
          other.sgstValue == sgstValue &&
          other.igstValue == igstValue &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class TaxsCompanion extends UpdateCompanion<Tax> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> countryId;
  final Value<String> taxType;
  final Value<int> slab;
  final Value<int> taxValue;
  final Value<String> taxMode;
  final Value<String> displayName1;
  final Value<String> displayName2;
  final Value<String> displayName3;
  final Value<int> cgstValue;
  final Value<int> sgstValue;
  final Value<int> igstValue;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TaxsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.countryId = const Value.absent(),
    this.taxType = const Value.absent(),
    this.slab = const Value.absent(),
    this.taxValue = const Value.absent(),
    this.taxMode = const Value.absent(),
    this.displayName1 = const Value.absent(),
    this.displayName2 = const Value.absent(),
    this.displayName3 = const Value.absent(),
    this.cgstValue = const Value.absent(),
    this.sgstValue = const Value.absent(),
    this.igstValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TaxsCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> countryId,
      Value<String> taxType,
      Value<int> slab,
      Value<int> taxValue,
      Value<String> taxMode,
      Value<String> displayName1,
      Value<String> displayName2,
      Value<String> displayName3,
      Value<int> cgstValue,
      Value<int> sgstValue,
      Value<int> igstValue,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return TaxsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      countryId: countryId ?? this.countryId,
      taxType: taxType ?? this.taxType,
      slab: slab ?? this.slab,
      taxValue: taxValue ?? this.taxValue,
      taxMode: taxMode ?? this.taxMode,
      displayName1: displayName1 ?? this.displayName1,
      displayName2: displayName2 ?? this.displayName2,
      displayName3: displayName3 ?? this.displayName3,
      cgstValue: cgstValue ?? this.cgstValue,
      sgstValue: sgstValue ?? this.sgstValue,
      igstValue: igstValue ?? this.igstValue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $TaxsTable extends Taxs with TableInfo<$TaxsTable, Tax> {
  final GeneratedDatabase _db;
  final String _alias;
  $TaxsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countryIdMeta = const VerificationMeta('countryId');
  GeneratedTextColumn _countryId;
  @override
  GeneratedTextColumn get countryId => _countryId ??= _constructCountryId();
  GeneratedTextColumn _constructCountryId() {
    return GeneratedTextColumn(
      'country_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taxTypeMeta = const VerificationMeta('taxType');
  GeneratedTextColumn _taxType;
  @override
  GeneratedTextColumn get taxType => _taxType ??= _constructTaxType();
  GeneratedTextColumn _constructTaxType() {
    return GeneratedTextColumn(
      'tax_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _slabMeta = const VerificationMeta('slab');
  GeneratedIntColumn _slab;
  @override
  GeneratedIntColumn get slab => _slab ??= _constructSlab();
  GeneratedIntColumn _constructSlab() {
    return GeneratedIntColumn(
      'slab',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taxValueMeta = const VerificationMeta('taxValue');
  GeneratedIntColumn _taxValue;
  @override
  GeneratedIntColumn get taxValue => _taxValue ??= _constructTaxValue();
  GeneratedIntColumn _constructTaxValue() {
    return GeneratedIntColumn(
      'tax_value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taxModeMeta = const VerificationMeta('taxMode');
  GeneratedTextColumn _taxMode;
  @override
  GeneratedTextColumn get taxMode => _taxMode ??= _constructTaxMode();
  GeneratedTextColumn _constructTaxMode() {
    return GeneratedTextColumn(
      'tax_mode',
      $tableName,
      false,
    );
  }

  final VerificationMeta _displayName1Meta =
      const VerificationMeta('displayName1');
  GeneratedTextColumn _displayName1;
  @override
  GeneratedTextColumn get displayName1 =>
      _displayName1 ??= _constructDisplayName1();
  GeneratedTextColumn _constructDisplayName1() {
    return GeneratedTextColumn(
      'display_name1',
      $tableName,
      false,
    );
  }

  final VerificationMeta _displayName2Meta =
      const VerificationMeta('displayName2');
  GeneratedTextColumn _displayName2;
  @override
  GeneratedTextColumn get displayName2 =>
      _displayName2 ??= _constructDisplayName2();
  GeneratedTextColumn _constructDisplayName2() {
    return GeneratedTextColumn(
      'display_name2',
      $tableName,
      false,
    );
  }

  final VerificationMeta _displayName3Meta =
      const VerificationMeta('displayName3');
  GeneratedTextColumn _displayName3;
  @override
  GeneratedTextColumn get displayName3 =>
      _displayName3 ??= _constructDisplayName3();
  GeneratedTextColumn _constructDisplayName3() {
    return GeneratedTextColumn(
      'display_name3',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cgstValueMeta = const VerificationMeta('cgstValue');
  GeneratedIntColumn _cgstValue;
  @override
  GeneratedIntColumn get cgstValue => _cgstValue ??= _constructCgstValue();
  GeneratedIntColumn _constructCgstValue() {
    return GeneratedIntColumn(
      'cgst_value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sgstValueMeta = const VerificationMeta('sgstValue');
  GeneratedIntColumn _sgstValue;
  @override
  GeneratedIntColumn get sgstValue => _sgstValue ??= _constructSgstValue();
  GeneratedIntColumn _constructSgstValue() {
    return GeneratedIntColumn(
      'sgst_value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _igstValueMeta = const VerificationMeta('igstValue');
  GeneratedIntColumn _igstValue;
  @override
  GeneratedIntColumn get igstValue => _igstValue ??= _constructIgstValue();
  GeneratedIntColumn _constructIgstValue() {
    return GeneratedIntColumn(
      'igst_value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        countryId,
        taxType,
        slab,
        taxValue,
        taxMode,
        displayName1,
        displayName2,
        displayName3,
        cgstValue,
        sgstValue,
        igstValue,
        createdAt,
        updatedAt
      ];
  @override
  $TaxsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'taxs';
  @override
  final String actualTableName = 'taxs';
  @override
  VerificationContext validateIntegrity(TaxsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.countryId.present) {
      context.handle(_countryIdMeta,
          countryId.isAcceptableValue(d.countryId.value, _countryIdMeta));
    } else if (countryId.isRequired && isInserting) {
      context.missing(_countryIdMeta);
    }
    if (d.taxType.present) {
      context.handle(_taxTypeMeta,
          taxType.isAcceptableValue(d.taxType.value, _taxTypeMeta));
    } else if (taxType.isRequired && isInserting) {
      context.missing(_taxTypeMeta);
    }
    if (d.slab.present) {
      context.handle(
          _slabMeta, slab.isAcceptableValue(d.slab.value, _slabMeta));
    } else if (slab.isRequired && isInserting) {
      context.missing(_slabMeta);
    }
    if (d.taxValue.present) {
      context.handle(_taxValueMeta,
          taxValue.isAcceptableValue(d.taxValue.value, _taxValueMeta));
    } else if (taxValue.isRequired && isInserting) {
      context.missing(_taxValueMeta);
    }
    if (d.taxMode.present) {
      context.handle(_taxModeMeta,
          taxMode.isAcceptableValue(d.taxMode.value, _taxModeMeta));
    } else if (taxMode.isRequired && isInserting) {
      context.missing(_taxModeMeta);
    }
    if (d.displayName1.present) {
      context.handle(
          _displayName1Meta,
          displayName1.isAcceptableValue(
              d.displayName1.value, _displayName1Meta));
    } else if (displayName1.isRequired && isInserting) {
      context.missing(_displayName1Meta);
    }
    if (d.displayName2.present) {
      context.handle(
          _displayName2Meta,
          displayName2.isAcceptableValue(
              d.displayName2.value, _displayName2Meta));
    } else if (displayName2.isRequired && isInserting) {
      context.missing(_displayName2Meta);
    }
    if (d.displayName3.present) {
      context.handle(
          _displayName3Meta,
          displayName3.isAcceptableValue(
              d.displayName3.value, _displayName3Meta));
    } else if (displayName3.isRequired && isInserting) {
      context.missing(_displayName3Meta);
    }
    if (d.cgstValue.present) {
      context.handle(_cgstValueMeta,
          cgstValue.isAcceptableValue(d.cgstValue.value, _cgstValueMeta));
    } else if (cgstValue.isRequired && isInserting) {
      context.missing(_cgstValueMeta);
    }
    if (d.sgstValue.present) {
      context.handle(_sgstValueMeta,
          sgstValue.isAcceptableValue(d.sgstValue.value, _sgstValueMeta));
    } else if (sgstValue.isRequired && isInserting) {
      context.missing(_sgstValueMeta);
    }
    if (d.igstValue.present) {
      context.handle(_igstValueMeta,
          igstValue.isAcceptableValue(d.igstValue.value, _igstValueMeta));
    } else if (igstValue.isRequired && isInserting) {
      context.missing(_igstValueMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tax map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tax.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TaxsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.countryId.present) {
      map['country_id'] = Variable<String, StringType>(d.countryId.value);
    }
    if (d.taxType.present) {
      map['tax_type'] = Variable<String, StringType>(d.taxType.value);
    }
    if (d.slab.present) {
      map['slab'] = Variable<int, IntType>(d.slab.value);
    }
    if (d.taxValue.present) {
      map['tax_value'] = Variable<int, IntType>(d.taxValue.value);
    }
    if (d.taxMode.present) {
      map['tax_mode'] = Variable<String, StringType>(d.taxMode.value);
    }
    if (d.displayName1.present) {
      map['display_name1'] = Variable<String, StringType>(d.displayName1.value);
    }
    if (d.displayName2.present) {
      map['display_name2'] = Variable<String, StringType>(d.displayName2.value);
    }
    if (d.displayName3.present) {
      map['display_name3'] = Variable<String, StringType>(d.displayName3.value);
    }
    if (d.cgstValue.present) {
      map['cgst_value'] = Variable<int, IntType>(d.cgstValue.value);
    }
    if (d.sgstValue.present) {
      map['sgst_value'] = Variable<int, IntType>(d.sgstValue.value);
    }
    if (d.igstValue.present) {
      map['igst_value'] = Variable<int, IntType>(d.igstValue.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $TaxsTable createAlias(String alias) {
    return $TaxsTable(_db, alias);
  }
}

class Store extends DataClass implements Insertable<Store> {
  final String id;
  final String name;
  final String merchantId;
  final String companyId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  Store(
      {@required this.id,
      @required this.name,
      @required this.merchantId,
      @required this.companyId,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory Store.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Store(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      companyId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_id']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Store.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Store(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      companyId: serializer.fromJson<String>(json['companyId']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'merchantId': serializer.toJson<String>(merchantId),
      'companyId': serializer.toJson<String>(companyId),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Store>>(bool nullToAbsent) {
    return StoresCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Store copyWith(
          {String id,
          String name,
          String merchantId,
          String companyId,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Store(
        id: id ?? this.id,
        name: name ?? this.name,
        merchantId: merchantId ?? this.merchantId,
        companyId: companyId ?? this.companyId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Store(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('merchantId: $merchantId, ')
          ..write('companyId: $companyId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              merchantId.hashCode,
              $mrjc(
                  companyId.hashCode,
                  $mrjc(status.hashCode,
                      $mrjc(createdAt.hashCode, updatedAt.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Store &&
          other.id == id &&
          other.name == name &&
          other.merchantId == merchantId &&
          other.companyId == companyId &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class StoresCompanion extends UpdateCompanion<Store> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> merchantId;
  final Value<String> companyId;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StoresCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> merchantId,
      Value<String> companyId,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return StoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      merchantId: merchantId ?? this.merchantId,
      companyId: companyId ?? this.companyId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $StoresTable extends Stores with TableInfo<$StoresTable, Store> {
  final GeneratedDatabase _db;
  final String _alias;
  $StoresTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _companyIdMeta = const VerificationMeta('companyId');
  GeneratedTextColumn _companyId;
  @override
  GeneratedTextColumn get companyId => _companyId ??= _constructCompanyId();
  GeneratedTextColumn _constructCompanyId() {
    return GeneratedTextColumn(
      'company_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, merchantId, companyId, status, createdAt, updatedAt];
  @override
  $StoresTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'stores';
  @override
  final String actualTableName = 'stores';
  @override
  VerificationContext validateIntegrity(StoresCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.companyId.present) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableValue(d.companyId.value, _companyIdMeta));
    } else if (companyId.isRequired && isInserting) {
      context.missing(_companyIdMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Store map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Store.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(StoresCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.companyId.present) {
      map['company_id'] = Variable<String, StringType>(d.companyId.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $StoresTable createAlias(String alias) {
    return $StoresTable(_db, alias);
  }
}

class CompanyData extends DataClass implements Insertable<CompanyData> {
  final String id;
  final String name;
  final String industryId;
  final String businessTypeId;
  final String merchantId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  CompanyData(
      {@required this.id,
      @required this.name,
      @required this.industryId,
      @required this.businessTypeId,
      @required this.merchantId,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory CompanyData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CompanyData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      industryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}industry_id']),
      businessTypeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_type_id']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory CompanyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CompanyData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      industryId: serializer.fromJson<String>(json['industryId']),
      businessTypeId: serializer.fromJson<String>(json['businessTypeId']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'industryId': serializer.toJson<String>(industryId),
      'businessTypeId': serializer.toJson<String>(businessTypeId),
      'merchantId': serializer.toJson<String>(merchantId),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<CompanyData>>(bool nullToAbsent) {
    return CompanyCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      industryId: industryId == null && nullToAbsent
          ? const Value.absent()
          : Value(industryId),
      businessTypeId: businessTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(businessTypeId),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  CompanyData copyWith(
          {String id,
          String name,
          String industryId,
          String businessTypeId,
          String merchantId,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      CompanyData(
        id: id ?? this.id,
        name: name ?? this.name,
        industryId: industryId ?? this.industryId,
        businessTypeId: businessTypeId ?? this.businessTypeId,
        merchantId: merchantId ?? this.merchantId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CompanyData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('industryId: $industryId, ')
          ..write('businessTypeId: $businessTypeId, ')
          ..write('merchantId: $merchantId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              industryId.hashCode,
              $mrjc(
                  businessTypeId.hashCode,
                  $mrjc(
                      merchantId.hashCode,
                      $mrjc(status.hashCode,
                          $mrjc(createdAt.hashCode, updatedAt.hashCode))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is CompanyData &&
          other.id == id &&
          other.name == name &&
          other.industryId == industryId &&
          other.businessTypeId == businessTypeId &&
          other.merchantId == merchantId &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class CompanyCompanion extends UpdateCompanion<CompanyData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> industryId;
  final Value<String> businessTypeId;
  final Value<String> merchantId;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CompanyCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.industryId = const Value.absent(),
    this.businessTypeId = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CompanyCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> industryId,
      Value<String> businessTypeId,
      Value<String> merchantId,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CompanyCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      industryId: industryId ?? this.industryId,
      businessTypeId: businessTypeId ?? this.businessTypeId,
      merchantId: merchantId ?? this.merchantId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CompanyTable extends Company with TableInfo<$CompanyTable, CompanyData> {
  final GeneratedDatabase _db;
  final String _alias;
  $CompanyTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _industryIdMeta = const VerificationMeta('industryId');
  GeneratedTextColumn _industryId;
  @override
  GeneratedTextColumn get industryId => _industryId ??= _constructIndustryId();
  GeneratedTextColumn _constructIndustryId() {
    return GeneratedTextColumn(
      'industry_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _businessTypeIdMeta =
      const VerificationMeta('businessTypeId');
  GeneratedTextColumn _businessTypeId;
  @override
  GeneratedTextColumn get businessTypeId =>
      _businessTypeId ??= _constructBusinessTypeId();
  GeneratedTextColumn _constructBusinessTypeId() {
    return GeneratedTextColumn(
      'business_type_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        industryId,
        businessTypeId,
        merchantId,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $CompanyTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'company';
  @override
  final String actualTableName = 'company';
  @override
  VerificationContext validateIntegrity(CompanyCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.industryId.present) {
      context.handle(_industryIdMeta,
          industryId.isAcceptableValue(d.industryId.value, _industryIdMeta));
    } else if (industryId.isRequired && isInserting) {
      context.missing(_industryIdMeta);
    }
    if (d.businessTypeId.present) {
      context.handle(
          _businessTypeIdMeta,
          businessTypeId.isAcceptableValue(
              d.businessTypeId.value, _businessTypeIdMeta));
    } else if (businessTypeId.isRequired && isInserting) {
      context.missing(_businessTypeIdMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompanyData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CompanyData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CompanyCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.industryId.present) {
      map['industry_id'] = Variable<String, StringType>(d.industryId.value);
    }
    if (d.businessTypeId.present) {
      map['business_type_id'] =
          Variable<String, StringType>(d.businessTypeId.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CompanyTable createAlias(String alias) {
    return $CompanyTable(_db, alias);
  }
}

class Merchant extends DataClass implements Insertable<Merchant> {
  final String id;
  final String planId;
  final int status;
  Merchant({@required this.id, @required this.planId, @required this.status});
  factory Merchant.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Merchant(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      planId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}plan_id']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
    );
  }
  factory Merchant.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Merchant(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      status: serializer.fromJson<int>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'status': serializer.toJson<int>(status),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Merchant>>(bool nullToAbsent) {
    return MerchantsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      planId:
          planId == null && nullToAbsent ? const Value.absent() : Value(planId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    ) as T;
  }

  Merchant copyWith({String id, String planId, int status}) => Merchant(
        id: id ?? this.id,
        planId: planId ?? this.planId,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('Merchant(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(planId.hashCode, status.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Merchant &&
          other.id == id &&
          other.planId == planId &&
          other.status == status);
}

class MerchantsCompanion extends UpdateCompanion<Merchant> {
  final Value<String> id;
  final Value<String> planId;
  final Value<int> status;
  const MerchantsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.status = const Value.absent(),
  });
  MerchantsCompanion copyWith(
      {Value<String> id, Value<String> planId, Value<int> status}) {
    return MerchantsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      status: status ?? this.status,
    );
  }
}

class $MerchantsTable extends Merchants
    with TableInfo<$MerchantsTable, Merchant> {
  final GeneratedDatabase _db;
  final String _alias;
  $MerchantsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _planIdMeta = const VerificationMeta('planId');
  GeneratedTextColumn _planId;
  @override
  GeneratedTextColumn get planId => _planId ??= _constructPlanId();
  GeneratedTextColumn _constructPlanId() {
    return GeneratedTextColumn(
      'plan_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, planId, status];
  @override
  $MerchantsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'merchants';
  @override
  final String actualTableName = 'merchants';
  @override
  VerificationContext validateIntegrity(MerchantsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.planId.present) {
      context.handle(
          _planIdMeta, planId.isAcceptableValue(d.planId.value, _planIdMeta));
    } else if (planId.isRequired && isInserting) {
      context.missing(_planIdMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Merchant map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Merchant.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(MerchantsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.planId.present) {
      map['plan_id'] = Variable<String, StringType>(d.planId.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    return map;
  }

  @override
  $MerchantsTable createAlias(String alias) {
    return $MerchantsTable(_db, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String mobile;
  final String unverifiedMobile;
  final String username;
  final String unverifiedUsername;
  final String firstName;
  final String lastName;
  final String merchantId;
  final String storeId;
  final String token;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  User(
      {@required this.id,
      @required this.mobile,
      @required this.unverifiedMobile,
      @required this.username,
      @required this.unverifiedUsername,
      @required this.firstName,
      @required this.lastName,
      @required this.merchantId,
      @required this.storeId,
      @required this.token,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return User(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      mobile:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}mobile']),
      unverifiedMobile: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}unverified_mobile']),
      username: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      unverifiedUsername: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}unverified_username']),
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      storeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}store_id']),
      token:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}token']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return User(
      id: serializer.fromJson<String>(json['id']),
      mobile: serializer.fromJson<String>(json['mobile']),
      unverifiedMobile: serializer.fromJson<String>(json['unverifiedMobile']),
      username: serializer.fromJson<String>(json['username']),
      unverifiedUsername:
          serializer.fromJson<String>(json['unverifiedUsername']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      storeId: serializer.fromJson<String>(json['storeId']),
      token: serializer.fromJson<String>(json['token']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'mobile': serializer.toJson<String>(mobile),
      'unverifiedMobile': serializer.toJson<String>(unverifiedMobile),
      'username': serializer.toJson<String>(username),
      'unverifiedUsername': serializer.toJson<String>(unverifiedUsername),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'merchantId': serializer.toJson<String>(merchantId),
      'storeId': serializer.toJson<String>(storeId),
      'token': serializer.toJson<String>(token),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<User>>(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      mobile:
          mobile == null && nullToAbsent ? const Value.absent() : Value(mobile),
      unverifiedMobile: unverifiedMobile == null && nullToAbsent
          ? const Value.absent()
          : Value(unverifiedMobile),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      unverifiedUsername: unverifiedUsername == null && nullToAbsent
          ? const Value.absent()
          : Value(unverifiedUsername),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  User copyWith(
          {String id,
          String mobile,
          String unverifiedMobile,
          String username,
          String unverifiedUsername,
          String firstName,
          String lastName,
          String merchantId,
          String storeId,
          String token,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      User(
        id: id ?? this.id,
        mobile: mobile ?? this.mobile,
        unverifiedMobile: unverifiedMobile ?? this.unverifiedMobile,
        username: username ?? this.username,
        unverifiedUsername: unverifiedUsername ?? this.unverifiedUsername,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        merchantId: merchantId ?? this.merchantId,
        storeId: storeId ?? this.storeId,
        token: token ?? this.token,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('mobile: $mobile, ')
          ..write('unverifiedMobile: $unverifiedMobile, ')
          ..write('username: $username, ')
          ..write('unverifiedUsername: $unverifiedUsername, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('merchantId: $merchantId, ')
          ..write('storeId: $storeId, ')
          ..write('token: $token, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          mobile.hashCode,
          $mrjc(
              unverifiedMobile.hashCode,
              $mrjc(
                  username.hashCode,
                  $mrjc(
                      unverifiedUsername.hashCode,
                      $mrjc(
                          firstName.hashCode,
                          $mrjc(
                              lastName.hashCode,
                              $mrjc(
                                  merchantId.hashCode,
                                  $mrjc(
                                      storeId.hashCode,
                                      $mrjc(
                                          token.hashCode,
                                          $mrjc(
                                              status.hashCode,
                                              $mrjc(
                                                  createdAt.hashCode,
                                                  updatedAt
                                                      .hashCode)))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is User &&
          other.id == id &&
          other.mobile == mobile &&
          other.unverifiedMobile == unverifiedMobile &&
          other.username == username &&
          other.unverifiedUsername == unverifiedUsername &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.merchantId == merchantId &&
          other.storeId == storeId &&
          other.token == token &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> mobile;
  final Value<String> unverifiedMobile;
  final Value<String> username;
  final Value<String> unverifiedUsername;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> merchantId;
  final Value<String> storeId;
  final Value<String> token;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.mobile = const Value.absent(),
    this.unverifiedMobile = const Value.absent(),
    this.username = const Value.absent(),
    this.unverifiedUsername = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.storeId = const Value.absent(),
    this.token = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion copyWith(
      {Value<String> id,
      Value<String> mobile,
      Value<String> unverifiedMobile,
      Value<String> username,
      Value<String> unverifiedUsername,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> merchantId,
      Value<String> storeId,
      Value<String> token,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      mobile: mobile ?? this.mobile,
      unverifiedMobile: unverifiedMobile ?? this.unverifiedMobile,
      username: username ?? this.username,
      unverifiedUsername: unverifiedUsername ?? this.unverifiedUsername,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      merchantId: merchantId ?? this.merchantId,
      storeId: storeId ?? this.storeId,
      token: token ?? this.token,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  GeneratedTextColumn _mobile;
  @override
  GeneratedTextColumn get mobile => _mobile ??= _constructMobile();
  GeneratedTextColumn _constructMobile() {
    return GeneratedTextColumn(
      'mobile',
      $tableName,
      false,
    );
  }

  final VerificationMeta _unverifiedMobileMeta =
      const VerificationMeta('unverifiedMobile');
  GeneratedTextColumn _unverifiedMobile;
  @override
  GeneratedTextColumn get unverifiedMobile =>
      _unverifiedMobile ??= _constructUnverifiedMobile();
  GeneratedTextColumn _constructUnverifiedMobile() {
    return GeneratedTextColumn(
      'unverified_mobile',
      $tableName,
      false,
    );
  }

  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  GeneratedTextColumn _username;
  @override
  GeneratedTextColumn get username => _username ??= _constructUsername();
  GeneratedTextColumn _constructUsername() {
    return GeneratedTextColumn(
      'username',
      $tableName,
      false,
    );
  }

  final VerificationMeta _unverifiedUsernameMeta =
      const VerificationMeta('unverifiedUsername');
  GeneratedTextColumn _unverifiedUsername;
  @override
  GeneratedTextColumn get unverifiedUsername =>
      _unverifiedUsername ??= _constructUnverifiedUsername();
  GeneratedTextColumn _constructUnverifiedUsername() {
    return GeneratedTextColumn(
      'unverified_username',
      $tableName,
      false,
    );
  }

  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  GeneratedTextColumn _firstName;
  @override
  GeneratedTextColumn get firstName => _firstName ??= _constructFirstName();
  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn(
      'first_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  GeneratedTextColumn _lastName;
  @override
  GeneratedTextColumn get lastName => _lastName ??= _constructLastName();
  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn(
      'last_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _storeIdMeta = const VerificationMeta('storeId');
  GeneratedTextColumn _storeId;
  @override
  GeneratedTextColumn get storeId => _storeId ??= _constructStoreId();
  GeneratedTextColumn _constructStoreId() {
    return GeneratedTextColumn(
      'store_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  GeneratedTextColumn _token;
  @override
  GeneratedTextColumn get token => _token ??= _constructToken();
  GeneratedTextColumn _constructToken() {
    return GeneratedTextColumn(
      'token',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        mobile,
        unverifiedMobile,
        username,
        unverifiedUsername,
        firstName,
        lastName,
        merchantId,
        storeId,
        token,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(UsersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.mobile.present) {
      context.handle(
          _mobileMeta, mobile.isAcceptableValue(d.mobile.value, _mobileMeta));
    } else if (mobile.isRequired && isInserting) {
      context.missing(_mobileMeta);
    }
    if (d.unverifiedMobile.present) {
      context.handle(
          _unverifiedMobileMeta,
          unverifiedMobile.isAcceptableValue(
              d.unverifiedMobile.value, _unverifiedMobileMeta));
    } else if (unverifiedMobile.isRequired && isInserting) {
      context.missing(_unverifiedMobileMeta);
    }
    if (d.username.present) {
      context.handle(_usernameMeta,
          username.isAcceptableValue(d.username.value, _usernameMeta));
    } else if (username.isRequired && isInserting) {
      context.missing(_usernameMeta);
    }
    if (d.unverifiedUsername.present) {
      context.handle(
          _unverifiedUsernameMeta,
          unverifiedUsername.isAcceptableValue(
              d.unverifiedUsername.value, _unverifiedUsernameMeta));
    } else if (unverifiedUsername.isRequired && isInserting) {
      context.missing(_unverifiedUsernameMeta);
    }
    if (d.firstName.present) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableValue(d.firstName.value, _firstNameMeta));
    } else if (firstName.isRequired && isInserting) {
      context.missing(_firstNameMeta);
    }
    if (d.lastName.present) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableValue(d.lastName.value, _lastNameMeta));
    } else if (lastName.isRequired && isInserting) {
      context.missing(_lastNameMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.storeId.present) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableValue(d.storeId.value, _storeIdMeta));
    } else if (storeId.isRequired && isInserting) {
      context.missing(_storeIdMeta);
    }
    if (d.token.present) {
      context.handle(
          _tokenMeta, token.isAcceptableValue(d.token.value, _tokenMeta));
    } else if (token.isRequired && isInserting) {
      context.missing(_tokenMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UsersCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.mobile.present) {
      map['mobile'] = Variable<String, StringType>(d.mobile.value);
    }
    if (d.unverifiedMobile.present) {
      map['unverified_mobile'] =
          Variable<String, StringType>(d.unverifiedMobile.value);
    }
    if (d.username.present) {
      map['username'] = Variable<String, StringType>(d.username.value);
    }
    if (d.unverifiedUsername.present) {
      map['unverified_username'] =
          Variable<String, StringType>(d.unverifiedUsername.value);
    }
    if (d.firstName.present) {
      map['first_name'] = Variable<String, StringType>(d.firstName.value);
    }
    if (d.lastName.present) {
      map['last_name'] = Variable<String, StringType>(d.lastName.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.storeId.present) {
      map['store_id'] = Variable<String, StringType>(d.storeId.value);
    }
    if (d.token.present) {
      map['token'] = Variable<String, StringType>(d.token.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class AuthenticatedUser extends DataClass
    implements Insertable<AuthenticatedUser> {
  final String id;
  final String userId;
  final bool authenticated;
  AuthenticatedUser(
      {@required this.id, this.userId, @required this.authenticated});
  factory AuthenticatedUser.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return AuthenticatedUser(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      authenticated: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}authenticated']),
    );
  }
  factory AuthenticatedUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return AuthenticatedUser(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      authenticated: serializer.fromJson<bool>(json['authenticated']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'authenticated': serializer.toJson<bool>(authenticated),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<AuthenticatedUser>>(
      bool nullToAbsent) {
    return AuthenticatedUsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      authenticated: authenticated == null && nullToAbsent
          ? const Value.absent()
          : Value(authenticated),
    ) as T;
  }

  AuthenticatedUser copyWith({String id, String userId, bool authenticated}) =>
      AuthenticatedUser(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        authenticated: authenticated ?? this.authenticated,
      );
  @override
  String toString() {
    return (StringBuffer('AuthenticatedUser(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('authenticated: $authenticated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(userId.hashCode, authenticated.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is AuthenticatedUser &&
          other.id == id &&
          other.userId == userId &&
          other.authenticated == authenticated);
}

class AuthenticatedUsersCompanion extends UpdateCompanion<AuthenticatedUser> {
  final Value<String> id;
  final Value<String> userId;
  final Value<bool> authenticated;
  const AuthenticatedUsersCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.authenticated = const Value.absent(),
  });
  AuthenticatedUsersCompanion copyWith(
      {Value<String> id, Value<String> userId, Value<bool> authenticated}) {
    return AuthenticatedUsersCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      authenticated: authenticated ?? this.authenticated,
    );
  }
}

class $AuthenticatedUsersTable extends AuthenticatedUsers
    with TableInfo<$AuthenticatedUsersTable, AuthenticatedUser> {
  final GeneratedDatabase _db;
  final String _alias;
  $AuthenticatedUsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedTextColumn _userId;
  @override
  GeneratedTextColumn get userId => _userId ??= _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _authenticatedMeta =
      const VerificationMeta('authenticated');
  GeneratedBoolColumn _authenticated;
  @override
  GeneratedBoolColumn get authenticated =>
      _authenticated ??= _constructAuthenticated();
  GeneratedBoolColumn _constructAuthenticated() {
    return GeneratedBoolColumn('authenticated', $tableName, false,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, userId, authenticated];
  @override
  $AuthenticatedUsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'authenticated_users';
  @override
  final String actualTableName = 'authenticated_users';
  @override
  VerificationContext validateIntegrity(AuthenticatedUsersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.userId.present) {
      context.handle(
          _userIdMeta, userId.isAcceptableValue(d.userId.value, _userIdMeta));
    } else if (userId.isRequired && isInserting) {
      context.missing(_userIdMeta);
    }
    if (d.authenticated.present) {
      context.handle(
          _authenticatedMeta,
          authenticated.isAcceptableValue(
              d.authenticated.value, _authenticatedMeta));
    } else if (authenticated.isRequired && isInserting) {
      context.missing(_authenticatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuthenticatedUser map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AuthenticatedUser.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AuthenticatedUsersCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.userId.present) {
      map['user_id'] = Variable<String, StringType>(d.userId.value);
    }
    if (d.authenticated.present) {
      map['authenticated'] = Variable<bool, BoolType>(d.authenticated.value);
    }
    return map;
  }

  @override
  $AuthenticatedUsersTable createAlias(String alias) {
    return $AuthenticatedUsersTable(_db, alias);
  }
}

class CurrentMerchant extends DataClass implements Insertable<CurrentMerchant> {
  final String id;
  final String plan;
  final int status;
  CurrentMerchant(
      {@required this.id, @required this.plan, @required this.status});
  factory CurrentMerchant.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return CurrentMerchant(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      plan: stringType.mapFromDatabaseResponse(data['${effectivePrefix}plan']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
    );
  }
  factory CurrentMerchant.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CurrentMerchant(
      id: serializer.fromJson<String>(json['id']),
      plan: serializer.fromJson<String>(json['plan']),
      status: serializer.fromJson<int>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'plan': serializer.toJson<String>(plan),
      'status': serializer.toJson<int>(status),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<CurrentMerchant>>(
      bool nullToAbsent) {
    return CurrentMerchantsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      plan: plan == null && nullToAbsent ? const Value.absent() : Value(plan),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    ) as T;
  }

  CurrentMerchant copyWith({String id, String plan, int status}) =>
      CurrentMerchant(
        id: id ?? this.id,
        plan: plan ?? this.plan,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('CurrentMerchant(')
          ..write('id: $id, ')
          ..write('plan: $plan, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(plan.hashCode, status.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is CurrentMerchant &&
          other.id == id &&
          other.plan == plan &&
          other.status == status);
}

class CurrentMerchantsCompanion extends UpdateCompanion<CurrentMerchant> {
  final Value<String> id;
  final Value<String> plan;
  final Value<int> status;
  const CurrentMerchantsCompanion({
    this.id = const Value.absent(),
    this.plan = const Value.absent(),
    this.status = const Value.absent(),
  });
  CurrentMerchantsCompanion copyWith(
      {Value<String> id, Value<String> plan, Value<int> status}) {
    return CurrentMerchantsCompanion(
      id: id ?? this.id,
      plan: plan ?? this.plan,
      status: status ?? this.status,
    );
  }
}

class $CurrentMerchantsTable extends CurrentMerchants
    with TableInfo<$CurrentMerchantsTable, CurrentMerchant> {
  final GeneratedDatabase _db;
  final String _alias;
  $CurrentMerchantsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _planMeta = const VerificationMeta('plan');
  GeneratedTextColumn _plan;
  @override
  GeneratedTextColumn get plan => _plan ??= _constructPlan();
  GeneratedTextColumn _constructPlan() {
    return GeneratedTextColumn(
      'plan',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, plan, status];
  @override
  $CurrentMerchantsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'current_merchants';
  @override
  final String actualTableName = 'current_merchants';
  @override
  VerificationContext validateIntegrity(CurrentMerchantsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.plan.present) {
      context.handle(
          _planMeta, plan.isAcceptableValue(d.plan.value, _planMeta));
    } else if (plan.isRequired && isInserting) {
      context.missing(_planMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CurrentMerchant map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CurrentMerchant.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CurrentMerchantsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.plan.present) {
      map['plan'] = Variable<String, StringType>(d.plan.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    return map;
  }

  @override
  $CurrentMerchantsTable createAlias(String alias) {
    return $CurrentMerchantsTable(_db, alias);
  }
}

class CurrentCompany extends DataClass implements Insertable<CurrentCompany> {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String industryId;
  final String businessTypeId;
  final String country;
  final String panNumber;
  final String gstin;
  final String currency;
  final String language;
  final String pinCode;
  final String address1;
  final String address2;
  final String state;
  final String city;
  final String stateName;
  final String cityName;
  final String district;
  final String merchantId;
  final String image;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  CurrentCompany(
      {@required this.id,
      @required this.name,
      this.email,
      this.mobile,
      this.industryId,
      this.businessTypeId,
      this.country,
      this.panNumber,
      this.gstin,
      this.currency,
      this.language,
      this.pinCode,
      this.address1,
      this.address2,
      this.state,
      this.city,
      this.stateName,
      this.cityName,
      this.district,
      @required this.merchantId,
      this.image,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory CurrentCompany.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CurrentCompany(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      mobile:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}mobile']),
      industryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}industry_id']),
      businessTypeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}business_type_id']),
      country:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}country']),
      panNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pan_number']),
      gstin:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}gstin']),
      currency: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}currency']),
      language: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}language']),
      pinCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pin_code']),
      address1: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address1']),
      address2: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address2']),
      state:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}state']),
      city: stringType.mapFromDatabaseResponse(data['${effectivePrefix}city']),
      stateName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}state_name']),
      cityName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}city_name']),
      district: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}district']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory CurrentCompany.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CurrentCompany(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      mobile: serializer.fromJson<String>(json['mobile']),
      industryId: serializer.fromJson<String>(json['industryId']),
      businessTypeId: serializer.fromJson<String>(json['businessTypeId']),
      country: serializer.fromJson<String>(json['country']),
      panNumber: serializer.fromJson<String>(json['panNumber']),
      gstin: serializer.fromJson<String>(json['gstin']),
      currency: serializer.fromJson<String>(json['currency']),
      language: serializer.fromJson<String>(json['language']),
      pinCode: serializer.fromJson<String>(json['pinCode']),
      address1: serializer.fromJson<String>(json['address1']),
      address2: serializer.fromJson<String>(json['address2']),
      state: serializer.fromJson<String>(json['state']),
      city: serializer.fromJson<String>(json['city']),
      stateName: serializer.fromJson<String>(json['stateName']),
      cityName: serializer.fromJson<String>(json['cityName']),
      district: serializer.fromJson<String>(json['district']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      image: serializer.fromJson<String>(json['image']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'mobile': serializer.toJson<String>(mobile),
      'industryId': serializer.toJson<String>(industryId),
      'businessTypeId': serializer.toJson<String>(businessTypeId),
      'country': serializer.toJson<String>(country),
      'panNumber': serializer.toJson<String>(panNumber),
      'gstin': serializer.toJson<String>(gstin),
      'currency': serializer.toJson<String>(currency),
      'language': serializer.toJson<String>(language),
      'pinCode': serializer.toJson<String>(pinCode),
      'address1': serializer.toJson<String>(address1),
      'address2': serializer.toJson<String>(address2),
      'state': serializer.toJson<String>(state),
      'city': serializer.toJson<String>(city),
      'stateName': serializer.toJson<String>(stateName),
      'cityName': serializer.toJson<String>(cityName),
      'district': serializer.toJson<String>(district),
      'merchantId': serializer.toJson<String>(merchantId),
      'image': serializer.toJson<String>(image),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<CurrentCompany>>(
      bool nullToAbsent) {
    return CurrentCompanysCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      mobile:
          mobile == null && nullToAbsent ? const Value.absent() : Value(mobile),
      industryId: industryId == null && nullToAbsent
          ? const Value.absent()
          : Value(industryId),
      businessTypeId: businessTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(businessTypeId),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      panNumber: panNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(panNumber),
      gstin:
          gstin == null && nullToAbsent ? const Value.absent() : Value(gstin),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      pinCode: pinCode == null && nullToAbsent
          ? const Value.absent()
          : Value(pinCode),
      address1: address1 == null && nullToAbsent
          ? const Value.absent()
          : Value(address1),
      address2: address2 == null && nullToAbsent
          ? const Value.absent()
          : Value(address2),
      state:
          state == null && nullToAbsent ? const Value.absent() : Value(state),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      stateName: stateName == null && nullToAbsent
          ? const Value.absent()
          : Value(stateName),
      cityName: cityName == null && nullToAbsent
          ? const Value.absent()
          : Value(cityName),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  CurrentCompany copyWith(
          {String id,
          String name,
          String email,
          String mobile,
          String industryId,
          String businessTypeId,
          String country,
          String panNumber,
          String gstin,
          String currency,
          String language,
          String pinCode,
          String address1,
          String address2,
          String state,
          String city,
          String stateName,
          String cityName,
          String district,
          String merchantId,
          String image,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      CurrentCompany(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        industryId: industryId ?? this.industryId,
        businessTypeId: businessTypeId ?? this.businessTypeId,
        country: country ?? this.country,
        panNumber: panNumber ?? this.panNumber,
        gstin: gstin ?? this.gstin,
        currency: currency ?? this.currency,
        language: language ?? this.language,
        pinCode: pinCode ?? this.pinCode,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        state: state ?? this.state,
        city: city ?? this.city,
        stateName: stateName ?? this.stateName,
        cityName: cityName ?? this.cityName,
        district: district ?? this.district,
        merchantId: merchantId ?? this.merchantId,
        image: image ?? this.image,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CurrentCompany(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('mobile: $mobile, ')
          ..write('industryId: $industryId, ')
          ..write('businessTypeId: $businessTypeId, ')
          ..write('country: $country, ')
          ..write('panNumber: $panNumber, ')
          ..write('gstin: $gstin, ')
          ..write('currency: $currency, ')
          ..write('language: $language, ')
          ..write('pinCode: $pinCode, ')
          ..write('address1: $address1, ')
          ..write('address2: $address2, ')
          ..write('state: $state, ')
          ..write('city: $city, ')
          ..write('stateName: $stateName, ')
          ..write('cityName: $cityName, ')
          ..write('district: $district, ')
          ..write('merchantId: $merchantId, ')
          ..write('image: $image, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              email.hashCode,
              $mrjc(
                  mobile.hashCode,
                  $mrjc(
                      industryId.hashCode,
                      $mrjc(
                          businessTypeId.hashCode,
                          $mrjc(
                              country.hashCode,
                              $mrjc(
                                  panNumber.hashCode,
                                  $mrjc(
                                      gstin.hashCode,
                                      $mrjc(
                                          currency.hashCode,
                                          $mrjc(
                                              language.hashCode,
                                              $mrjc(
                                                  pinCode.hashCode,
                                                  $mrjc(
                                                      address1.hashCode,
                                                      $mrjc(
                                                          address2.hashCode,
                                                          $mrjc(
                                                              state.hashCode,
                                                              $mrjc(
                                                                  city.hashCode,
                                                                  $mrjc(
                                                                      stateName
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          cityName
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              district.hashCode,
                                                                              $mrjc(merchantId.hashCode, $mrjc(image.hashCode, $mrjc(status.hashCode, $mrjc(createdAt.hashCode, updatedAt.hashCode))))))))))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is CurrentCompany &&
          other.id == id &&
          other.name == name &&
          other.email == email &&
          other.mobile == mobile &&
          other.industryId == industryId &&
          other.businessTypeId == businessTypeId &&
          other.country == country &&
          other.panNumber == panNumber &&
          other.gstin == gstin &&
          other.currency == currency &&
          other.language == language &&
          other.pinCode == pinCode &&
          other.address1 == address1 &&
          other.address2 == address2 &&
          other.state == state &&
          other.city == city &&
          other.stateName == stateName &&
          other.cityName == cityName &&
          other.district == district &&
          other.merchantId == merchantId &&
          other.image == image &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class CurrentCompanysCompanion extends UpdateCompanion<CurrentCompany> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> mobile;
  final Value<String> industryId;
  final Value<String> businessTypeId;
  final Value<String> country;
  final Value<String> panNumber;
  final Value<String> gstin;
  final Value<String> currency;
  final Value<String> language;
  final Value<String> pinCode;
  final Value<String> address1;
  final Value<String> address2;
  final Value<String> state;
  final Value<String> city;
  final Value<String> stateName;
  final Value<String> cityName;
  final Value<String> district;
  final Value<String> merchantId;
  final Value<String> image;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CurrentCompanysCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.mobile = const Value.absent(),
    this.industryId = const Value.absent(),
    this.businessTypeId = const Value.absent(),
    this.country = const Value.absent(),
    this.panNumber = const Value.absent(),
    this.gstin = const Value.absent(),
    this.currency = const Value.absent(),
    this.language = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.address1 = const Value.absent(),
    this.address2 = const Value.absent(),
    this.state = const Value.absent(),
    this.city = const Value.absent(),
    this.stateName = const Value.absent(),
    this.cityName = const Value.absent(),
    this.district = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.image = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CurrentCompanysCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> email,
      Value<String> mobile,
      Value<String> industryId,
      Value<String> businessTypeId,
      Value<String> country,
      Value<String> panNumber,
      Value<String> gstin,
      Value<String> currency,
      Value<String> language,
      Value<String> pinCode,
      Value<String> address1,
      Value<String> address2,
      Value<String> state,
      Value<String> city,
      Value<String> stateName,
      Value<String> cityName,
      Value<String> district,
      Value<String> merchantId,
      Value<String> image,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CurrentCompanysCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      industryId: industryId ?? this.industryId,
      businessTypeId: businessTypeId ?? this.businessTypeId,
      country: country ?? this.country,
      panNumber: panNumber ?? this.panNumber,
      gstin: gstin ?? this.gstin,
      currency: currency ?? this.currency,
      language: language ?? this.language,
      pinCode: pinCode ?? this.pinCode,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      state: state ?? this.state,
      city: city ?? this.city,
      stateName: stateName ?? this.stateName,
      cityName: cityName ?? this.cityName,
      district: district ?? this.district,
      merchantId: merchantId ?? this.merchantId,
      image: image ?? this.image,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CurrentCompanysTable extends CurrentCompanys
    with TableInfo<$CurrentCompanysTable, CurrentCompany> {
  final GeneratedDatabase _db;
  final String _alias;
  $CurrentCompanysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  GeneratedTextColumn _mobile;
  @override
  GeneratedTextColumn get mobile => _mobile ??= _constructMobile();
  GeneratedTextColumn _constructMobile() {
    return GeneratedTextColumn(
      'mobile',
      $tableName,
      true,
    );
  }

  final VerificationMeta _industryIdMeta = const VerificationMeta('industryId');
  GeneratedTextColumn _industryId;
  @override
  GeneratedTextColumn get industryId => _industryId ??= _constructIndustryId();
  GeneratedTextColumn _constructIndustryId() {
    return GeneratedTextColumn(
      'industry_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _businessTypeIdMeta =
      const VerificationMeta('businessTypeId');
  GeneratedTextColumn _businessTypeId;
  @override
  GeneratedTextColumn get businessTypeId =>
      _businessTypeId ??= _constructBusinessTypeId();
  GeneratedTextColumn _constructBusinessTypeId() {
    return GeneratedTextColumn(
      'business_type_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _countryMeta = const VerificationMeta('country');
  GeneratedTextColumn _country;
  @override
  GeneratedTextColumn get country => _country ??= _constructCountry();
  GeneratedTextColumn _constructCountry() {
    return GeneratedTextColumn(
      'country',
      $tableName,
      true,
    );
  }

  final VerificationMeta _panNumberMeta = const VerificationMeta('panNumber');
  GeneratedTextColumn _panNumber;
  @override
  GeneratedTextColumn get panNumber => _panNumber ??= _constructPanNumber();
  GeneratedTextColumn _constructPanNumber() {
    return GeneratedTextColumn(
      'pan_number',
      $tableName,
      true,
    );
  }

  final VerificationMeta _gstinMeta = const VerificationMeta('gstin');
  GeneratedTextColumn _gstin;
  @override
  GeneratedTextColumn get gstin => _gstin ??= _constructGstin();
  GeneratedTextColumn _constructGstin() {
    return GeneratedTextColumn(
      'gstin',
      $tableName,
      true,
    );
  }

  final VerificationMeta _currencyMeta = const VerificationMeta('currency');
  GeneratedTextColumn _currency;
  @override
  GeneratedTextColumn get currency => _currency ??= _constructCurrency();
  GeneratedTextColumn _constructCurrency() {
    return GeneratedTextColumn(
      'currency',
      $tableName,
      true,
    );
  }

  final VerificationMeta _languageMeta = const VerificationMeta('language');
  GeneratedTextColumn _language;
  @override
  GeneratedTextColumn get language => _language ??= _constructLanguage();
  GeneratedTextColumn _constructLanguage() {
    return GeneratedTextColumn(
      'language',
      $tableName,
      true,
    );
  }

  final VerificationMeta _pinCodeMeta = const VerificationMeta('pinCode');
  GeneratedTextColumn _pinCode;
  @override
  GeneratedTextColumn get pinCode => _pinCode ??= _constructPinCode();
  GeneratedTextColumn _constructPinCode() {
    return GeneratedTextColumn(
      'pin_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _address1Meta = const VerificationMeta('address1');
  GeneratedTextColumn _address1;
  @override
  GeneratedTextColumn get address1 => _address1 ??= _constructAddress1();
  GeneratedTextColumn _constructAddress1() {
    return GeneratedTextColumn(
      'address1',
      $tableName,
      true,
    );
  }

  final VerificationMeta _address2Meta = const VerificationMeta('address2');
  GeneratedTextColumn _address2;
  @override
  GeneratedTextColumn get address2 => _address2 ??= _constructAddress2();
  GeneratedTextColumn _constructAddress2() {
    return GeneratedTextColumn(
      'address2',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateMeta = const VerificationMeta('state');
  GeneratedTextColumn _state;
  @override
  GeneratedTextColumn get state => _state ??= _constructState();
  GeneratedTextColumn _constructState() {
    return GeneratedTextColumn(
      'state',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityMeta = const VerificationMeta('city');
  GeneratedTextColumn _city;
  @override
  GeneratedTextColumn get city => _city ??= _constructCity();
  GeneratedTextColumn _constructCity() {
    return GeneratedTextColumn(
      'city',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateNameMeta = const VerificationMeta('stateName');
  GeneratedTextColumn _stateName;
  @override
  GeneratedTextColumn get stateName => _stateName ??= _constructStateName();
  GeneratedTextColumn _constructStateName() {
    return GeneratedTextColumn(
      'state_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityNameMeta = const VerificationMeta('cityName');
  GeneratedTextColumn _cityName;
  @override
  GeneratedTextColumn get cityName => _cityName ??= _constructCityName();
  GeneratedTextColumn _constructCityName() {
    return GeneratedTextColumn(
      'city_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _districtMeta = const VerificationMeta('district');
  GeneratedTextColumn _district;
  @override
  GeneratedTextColumn get district => _district ??= _constructDistrict();
  GeneratedTextColumn _constructDistrict() {
    return GeneratedTextColumn(
      'district',
      $tableName,
      true,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        email,
        mobile,
        industryId,
        businessTypeId,
        country,
        panNumber,
        gstin,
        currency,
        language,
        pinCode,
        address1,
        address2,
        state,
        city,
        stateName,
        cityName,
        district,
        merchantId,
        image,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $CurrentCompanysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'current_companys';
  @override
  final String actualTableName = 'current_companys';
  @override
  VerificationContext validateIntegrity(CurrentCompanysCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.email.present) {
      context.handle(
          _emailMeta, email.isAcceptableValue(d.email.value, _emailMeta));
    } else if (email.isRequired && isInserting) {
      context.missing(_emailMeta);
    }
    if (d.mobile.present) {
      context.handle(
          _mobileMeta, mobile.isAcceptableValue(d.mobile.value, _mobileMeta));
    } else if (mobile.isRequired && isInserting) {
      context.missing(_mobileMeta);
    }
    if (d.industryId.present) {
      context.handle(_industryIdMeta,
          industryId.isAcceptableValue(d.industryId.value, _industryIdMeta));
    } else if (industryId.isRequired && isInserting) {
      context.missing(_industryIdMeta);
    }
    if (d.businessTypeId.present) {
      context.handle(
          _businessTypeIdMeta,
          businessTypeId.isAcceptableValue(
              d.businessTypeId.value, _businessTypeIdMeta));
    } else if (businessTypeId.isRequired && isInserting) {
      context.missing(_businessTypeIdMeta);
    }
    if (d.country.present) {
      context.handle(_countryMeta,
          country.isAcceptableValue(d.country.value, _countryMeta));
    } else if (country.isRequired && isInserting) {
      context.missing(_countryMeta);
    }
    if (d.panNumber.present) {
      context.handle(_panNumberMeta,
          panNumber.isAcceptableValue(d.panNumber.value, _panNumberMeta));
    } else if (panNumber.isRequired && isInserting) {
      context.missing(_panNumberMeta);
    }
    if (d.gstin.present) {
      context.handle(
          _gstinMeta, gstin.isAcceptableValue(d.gstin.value, _gstinMeta));
    } else if (gstin.isRequired && isInserting) {
      context.missing(_gstinMeta);
    }
    if (d.currency.present) {
      context.handle(_currencyMeta,
          currency.isAcceptableValue(d.currency.value, _currencyMeta));
    } else if (currency.isRequired && isInserting) {
      context.missing(_currencyMeta);
    }
    if (d.language.present) {
      context.handle(_languageMeta,
          language.isAcceptableValue(d.language.value, _languageMeta));
    } else if (language.isRequired && isInserting) {
      context.missing(_languageMeta);
    }
    if (d.pinCode.present) {
      context.handle(_pinCodeMeta,
          pinCode.isAcceptableValue(d.pinCode.value, _pinCodeMeta));
    } else if (pinCode.isRequired && isInserting) {
      context.missing(_pinCodeMeta);
    }
    if (d.address1.present) {
      context.handle(_address1Meta,
          address1.isAcceptableValue(d.address1.value, _address1Meta));
    } else if (address1.isRequired && isInserting) {
      context.missing(_address1Meta);
    }
    if (d.address2.present) {
      context.handle(_address2Meta,
          address2.isAcceptableValue(d.address2.value, _address2Meta));
    } else if (address2.isRequired && isInserting) {
      context.missing(_address2Meta);
    }
    if (d.state.present) {
      context.handle(
          _stateMeta, state.isAcceptableValue(d.state.value, _stateMeta));
    } else if (state.isRequired && isInserting) {
      context.missing(_stateMeta);
    }
    if (d.city.present) {
      context.handle(
          _cityMeta, city.isAcceptableValue(d.city.value, _cityMeta));
    } else if (city.isRequired && isInserting) {
      context.missing(_cityMeta);
    }
    if (d.stateName.present) {
      context.handle(_stateNameMeta,
          stateName.isAcceptableValue(d.stateName.value, _stateNameMeta));
    } else if (stateName.isRequired && isInserting) {
      context.missing(_stateNameMeta);
    }
    if (d.cityName.present) {
      context.handle(_cityNameMeta,
          cityName.isAcceptableValue(d.cityName.value, _cityNameMeta));
    } else if (cityName.isRequired && isInserting) {
      context.missing(_cityNameMeta);
    }
    if (d.district.present) {
      context.handle(_districtMeta,
          district.isAcceptableValue(d.district.value, _districtMeta));
    } else if (district.isRequired && isInserting) {
      context.missing(_districtMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.image.present) {
      context.handle(
          _imageMeta, image.isAcceptableValue(d.image.value, _imageMeta));
    } else if (image.isRequired && isInserting) {
      context.missing(_imageMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CurrentCompany map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CurrentCompany.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CurrentCompanysCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.email.present) {
      map['email'] = Variable<String, StringType>(d.email.value);
    }
    if (d.mobile.present) {
      map['mobile'] = Variable<String, StringType>(d.mobile.value);
    }
    if (d.industryId.present) {
      map['industry_id'] = Variable<String, StringType>(d.industryId.value);
    }
    if (d.businessTypeId.present) {
      map['business_type_id'] =
          Variable<String, StringType>(d.businessTypeId.value);
    }
    if (d.country.present) {
      map['country'] = Variable<String, StringType>(d.country.value);
    }
    if (d.panNumber.present) {
      map['pan_number'] = Variable<String, StringType>(d.panNumber.value);
    }
    if (d.gstin.present) {
      map['gstin'] = Variable<String, StringType>(d.gstin.value);
    }
    if (d.currency.present) {
      map['currency'] = Variable<String, StringType>(d.currency.value);
    }
    if (d.language.present) {
      map['language'] = Variable<String, StringType>(d.language.value);
    }
    if (d.pinCode.present) {
      map['pin_code'] = Variable<String, StringType>(d.pinCode.value);
    }
    if (d.address1.present) {
      map['address1'] = Variable<String, StringType>(d.address1.value);
    }
    if (d.address2.present) {
      map['address2'] = Variable<String, StringType>(d.address2.value);
    }
    if (d.state.present) {
      map['state'] = Variable<String, StringType>(d.state.value);
    }
    if (d.city.present) {
      map['city'] = Variable<String, StringType>(d.city.value);
    }
    if (d.stateName.present) {
      map['state_name'] = Variable<String, StringType>(d.stateName.value);
    }
    if (d.cityName.present) {
      map['city_name'] = Variable<String, StringType>(d.cityName.value);
    }
    if (d.district.present) {
      map['district'] = Variable<String, StringType>(d.district.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.image.present) {
      map['image'] = Variable<String, StringType>(d.image.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CurrentCompanysTable createAlias(String alias) {
    return $CurrentCompanysTable(_db, alias);
  }
}

class CurrentStore extends DataClass implements Insertable<CurrentStore> {
  final String id;
  final String name;
  final String merchantId;
  final String companyId;
  final String pinCode;
  final String district;
  final String currency;
  final String language;
  final String area;
  final String cityId;
  final String stateId;
  final String countryId;
  final String cityName;
  final String stateName;
  final String countryName;
  final String address1;
  final String address2;
  final bool invoice;
  final String invoicePrefix;
  final String invoiceStart;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  CurrentStore(
      {@required this.id,
      @required this.name,
      @required this.merchantId,
      @required this.companyId,
      this.pinCode,
      this.district,
      this.currency,
      this.language,
      this.area,
      this.cityId,
      this.stateId,
      this.countryId,
      this.cityName,
      this.stateName,
      this.countryName,
      this.address1,
      this.address2,
      this.invoice,
      this.invoicePrefix,
      this.invoiceStart,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory CurrentStore.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CurrentStore(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      companyId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_id']),
      pinCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pin_code']),
      district: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}district']),
      currency: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}currency']),
      language: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}language']),
      area: stringType.mapFromDatabaseResponse(data['${effectivePrefix}area']),
      cityId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}city_id']),
      stateId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}state_id']),
      countryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}country_id']),
      cityName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}city_name']),
      stateName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}state_name']),
      countryName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}country_name']),
      address1: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address1']),
      address2: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address2']),
      invoice:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}invoice']),
      invoicePrefix: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}invoice_prefix']),
      invoiceStart: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}invoice_start']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory CurrentStore.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CurrentStore(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      companyId: serializer.fromJson<String>(json['companyId']),
      pinCode: serializer.fromJson<String>(json['pinCode']),
      district: serializer.fromJson<String>(json['district']),
      currency: serializer.fromJson<String>(json['currency']),
      language: serializer.fromJson<String>(json['language']),
      area: serializer.fromJson<String>(json['area']),
      cityId: serializer.fromJson<String>(json['cityId']),
      stateId: serializer.fromJson<String>(json['stateId']),
      countryId: serializer.fromJson<String>(json['countryId']),
      cityName: serializer.fromJson<String>(json['cityName']),
      stateName: serializer.fromJson<String>(json['stateName']),
      countryName: serializer.fromJson<String>(json['countryName']),
      address1: serializer.fromJson<String>(json['address1']),
      address2: serializer.fromJson<String>(json['address2']),
      invoice: serializer.fromJson<bool>(json['invoice']),
      invoicePrefix: serializer.fromJson<String>(json['invoicePrefix']),
      invoiceStart: serializer.fromJson<String>(json['invoiceStart']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'merchantId': serializer.toJson<String>(merchantId),
      'companyId': serializer.toJson<String>(companyId),
      'pinCode': serializer.toJson<String>(pinCode),
      'district': serializer.toJson<String>(district),
      'currency': serializer.toJson<String>(currency),
      'language': serializer.toJson<String>(language),
      'area': serializer.toJson<String>(area),
      'cityId': serializer.toJson<String>(cityId),
      'stateId': serializer.toJson<String>(stateId),
      'countryId': serializer.toJson<String>(countryId),
      'cityName': serializer.toJson<String>(cityName),
      'stateName': serializer.toJson<String>(stateName),
      'countryName': serializer.toJson<String>(countryName),
      'address1': serializer.toJson<String>(address1),
      'address2': serializer.toJson<String>(address2),
      'invoice': serializer.toJson<bool>(invoice),
      'invoicePrefix': serializer.toJson<String>(invoicePrefix),
      'invoiceStart': serializer.toJson<String>(invoiceStart),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<CurrentStore>>(
      bool nullToAbsent) {
    return CurrentStoresCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      pinCode: pinCode == null && nullToAbsent
          ? const Value.absent()
          : Value(pinCode),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      cityId:
          cityId == null && nullToAbsent ? const Value.absent() : Value(cityId),
      stateId: stateId == null && nullToAbsent
          ? const Value.absent()
          : Value(stateId),
      countryId: countryId == null && nullToAbsent
          ? const Value.absent()
          : Value(countryId),
      cityName: cityName == null && nullToAbsent
          ? const Value.absent()
          : Value(cityName),
      stateName: stateName == null && nullToAbsent
          ? const Value.absent()
          : Value(stateName),
      countryName: countryName == null && nullToAbsent
          ? const Value.absent()
          : Value(countryName),
      address1: address1 == null && nullToAbsent
          ? const Value.absent()
          : Value(address1),
      address2: address2 == null && nullToAbsent
          ? const Value.absent()
          : Value(address2),
      invoice: invoice == null && nullToAbsent
          ? const Value.absent()
          : Value(invoice),
      invoicePrefix: invoicePrefix == null && nullToAbsent
          ? const Value.absent()
          : Value(invoicePrefix),
      invoiceStart: invoiceStart == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceStart),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  CurrentStore copyWith(
          {String id,
          String name,
          String merchantId,
          String companyId,
          String pinCode,
          String district,
          String currency,
          String language,
          String area,
          String cityId,
          String stateId,
          String countryId,
          String cityName,
          String stateName,
          String countryName,
          String address1,
          String address2,
          bool invoice,
          String invoicePrefix,
          String invoiceStart,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      CurrentStore(
        id: id ?? this.id,
        name: name ?? this.name,
        merchantId: merchantId ?? this.merchantId,
        companyId: companyId ?? this.companyId,
        pinCode: pinCode ?? this.pinCode,
        district: district ?? this.district,
        currency: currency ?? this.currency,
        language: language ?? this.language,
        area: area ?? this.area,
        cityId: cityId ?? this.cityId,
        stateId: stateId ?? this.stateId,
        countryId: countryId ?? this.countryId,
        cityName: cityName ?? this.cityName,
        stateName: stateName ?? this.stateName,
        countryName: countryName ?? this.countryName,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        invoice: invoice ?? this.invoice,
        invoicePrefix: invoicePrefix ?? this.invoicePrefix,
        invoiceStart: invoiceStart ?? this.invoiceStart,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CurrentStore(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('merchantId: $merchantId, ')
          ..write('companyId: $companyId, ')
          ..write('pinCode: $pinCode, ')
          ..write('district: $district, ')
          ..write('currency: $currency, ')
          ..write('language: $language, ')
          ..write('area: $area, ')
          ..write('cityId: $cityId, ')
          ..write('stateId: $stateId, ')
          ..write('countryId: $countryId, ')
          ..write('cityName: $cityName, ')
          ..write('stateName: $stateName, ')
          ..write('countryName: $countryName, ')
          ..write('address1: $address1, ')
          ..write('address2: $address2, ')
          ..write('invoice: $invoice, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('invoiceStart: $invoiceStart, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              merchantId.hashCode,
              $mrjc(
                  companyId.hashCode,
                  $mrjc(
                      pinCode.hashCode,
                      $mrjc(
                          district.hashCode,
                          $mrjc(
                              currency.hashCode,
                              $mrjc(
                                  language.hashCode,
                                  $mrjc(
                                      area.hashCode,
                                      $mrjc(
                                          cityId.hashCode,
                                          $mrjc(
                                              stateId.hashCode,
                                              $mrjc(
                                                  countryId.hashCode,
                                                  $mrjc(
                                                      cityName.hashCode,
                                                      $mrjc(
                                                          stateName.hashCode,
                                                          $mrjc(
                                                              countryName
                                                                  .hashCode,
                                                              $mrjc(
                                                                  address1
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      address2
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          invoice
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              invoicePrefix.hashCode,
                                                                              $mrjc(invoiceStart.hashCode, $mrjc(status.hashCode, $mrjc(createdAt.hashCode, updatedAt.hashCode)))))))))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is CurrentStore &&
          other.id == id &&
          other.name == name &&
          other.merchantId == merchantId &&
          other.companyId == companyId &&
          other.pinCode == pinCode &&
          other.district == district &&
          other.currency == currency &&
          other.language == language &&
          other.area == area &&
          other.cityId == cityId &&
          other.stateId == stateId &&
          other.countryId == countryId &&
          other.cityName == cityName &&
          other.stateName == stateName &&
          other.countryName == countryName &&
          other.address1 == address1 &&
          other.address2 == address2 &&
          other.invoice == invoice &&
          other.invoicePrefix == invoicePrefix &&
          other.invoiceStart == invoiceStart &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class CurrentStoresCompanion extends UpdateCompanion<CurrentStore> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> merchantId;
  final Value<String> companyId;
  final Value<String> pinCode;
  final Value<String> district;
  final Value<String> currency;
  final Value<String> language;
  final Value<String> area;
  final Value<String> cityId;
  final Value<String> stateId;
  final Value<String> countryId;
  final Value<String> cityName;
  final Value<String> stateName;
  final Value<String> countryName;
  final Value<String> address1;
  final Value<String> address2;
  final Value<bool> invoice;
  final Value<String> invoicePrefix;
  final Value<String> invoiceStart;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CurrentStoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.district = const Value.absent(),
    this.currency = const Value.absent(),
    this.language = const Value.absent(),
    this.area = const Value.absent(),
    this.cityId = const Value.absent(),
    this.stateId = const Value.absent(),
    this.countryId = const Value.absent(),
    this.cityName = const Value.absent(),
    this.stateName = const Value.absent(),
    this.countryName = const Value.absent(),
    this.address1 = const Value.absent(),
    this.address2 = const Value.absent(),
    this.invoice = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.invoiceStart = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CurrentStoresCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> merchantId,
      Value<String> companyId,
      Value<String> pinCode,
      Value<String> district,
      Value<String> currency,
      Value<String> language,
      Value<String> area,
      Value<String> cityId,
      Value<String> stateId,
      Value<String> countryId,
      Value<String> cityName,
      Value<String> stateName,
      Value<String> countryName,
      Value<String> address1,
      Value<String> address2,
      Value<bool> invoice,
      Value<String> invoicePrefix,
      Value<String> invoiceStart,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CurrentStoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      merchantId: merchantId ?? this.merchantId,
      companyId: companyId ?? this.companyId,
      pinCode: pinCode ?? this.pinCode,
      district: district ?? this.district,
      currency: currency ?? this.currency,
      language: language ?? this.language,
      area: area ?? this.area,
      cityId: cityId ?? this.cityId,
      stateId: stateId ?? this.stateId,
      countryId: countryId ?? this.countryId,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      countryName: countryName ?? this.countryName,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      invoice: invoice ?? this.invoice,
      invoicePrefix: invoicePrefix ?? this.invoicePrefix,
      invoiceStart: invoiceStart ?? this.invoiceStart,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CurrentStoresTable extends CurrentStores
    with TableInfo<$CurrentStoresTable, CurrentStore> {
  final GeneratedDatabase _db;
  final String _alias;
  $CurrentStoresTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _companyIdMeta = const VerificationMeta('companyId');
  GeneratedTextColumn _companyId;
  @override
  GeneratedTextColumn get companyId => _companyId ??= _constructCompanyId();
  GeneratedTextColumn _constructCompanyId() {
    return GeneratedTextColumn(
      'company_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pinCodeMeta = const VerificationMeta('pinCode');
  GeneratedTextColumn _pinCode;
  @override
  GeneratedTextColumn get pinCode => _pinCode ??= _constructPinCode();
  GeneratedTextColumn _constructPinCode() {
    return GeneratedTextColumn(
      'pin_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _districtMeta = const VerificationMeta('district');
  GeneratedTextColumn _district;
  @override
  GeneratedTextColumn get district => _district ??= _constructDistrict();
  GeneratedTextColumn _constructDistrict() {
    return GeneratedTextColumn(
      'district',
      $tableName,
      true,
    );
  }

  final VerificationMeta _currencyMeta = const VerificationMeta('currency');
  GeneratedTextColumn _currency;
  @override
  GeneratedTextColumn get currency => _currency ??= _constructCurrency();
  GeneratedTextColumn _constructCurrency() {
    return GeneratedTextColumn(
      'currency',
      $tableName,
      true,
    );
  }

  final VerificationMeta _languageMeta = const VerificationMeta('language');
  GeneratedTextColumn _language;
  @override
  GeneratedTextColumn get language => _language ??= _constructLanguage();
  GeneratedTextColumn _constructLanguage() {
    return GeneratedTextColumn(
      'language',
      $tableName,
      true,
    );
  }

  final VerificationMeta _areaMeta = const VerificationMeta('area');
  GeneratedTextColumn _area;
  @override
  GeneratedTextColumn get area => _area ??= _constructArea();
  GeneratedTextColumn _constructArea() {
    return GeneratedTextColumn(
      'area',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityIdMeta = const VerificationMeta('cityId');
  GeneratedTextColumn _cityId;
  @override
  GeneratedTextColumn get cityId => _cityId ??= _constructCityId();
  GeneratedTextColumn _constructCityId() {
    return GeneratedTextColumn(
      'city_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateIdMeta = const VerificationMeta('stateId');
  GeneratedTextColumn _stateId;
  @override
  GeneratedTextColumn get stateId => _stateId ??= _constructStateId();
  GeneratedTextColumn _constructStateId() {
    return GeneratedTextColumn(
      'state_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _countryIdMeta = const VerificationMeta('countryId');
  GeneratedTextColumn _countryId;
  @override
  GeneratedTextColumn get countryId => _countryId ??= _constructCountryId();
  GeneratedTextColumn _constructCountryId() {
    return GeneratedTextColumn(
      'country_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityNameMeta = const VerificationMeta('cityName');
  GeneratedTextColumn _cityName;
  @override
  GeneratedTextColumn get cityName => _cityName ??= _constructCityName();
  GeneratedTextColumn _constructCityName() {
    return GeneratedTextColumn(
      'city_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateNameMeta = const VerificationMeta('stateName');
  GeneratedTextColumn _stateName;
  @override
  GeneratedTextColumn get stateName => _stateName ??= _constructStateName();
  GeneratedTextColumn _constructStateName() {
    return GeneratedTextColumn(
      'state_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _countryNameMeta =
      const VerificationMeta('countryName');
  GeneratedTextColumn _countryName;
  @override
  GeneratedTextColumn get countryName =>
      _countryName ??= _constructCountryName();
  GeneratedTextColumn _constructCountryName() {
    return GeneratedTextColumn(
      'country_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _address1Meta = const VerificationMeta('address1');
  GeneratedTextColumn _address1;
  @override
  GeneratedTextColumn get address1 => _address1 ??= _constructAddress1();
  GeneratedTextColumn _constructAddress1() {
    return GeneratedTextColumn(
      'address1',
      $tableName,
      true,
    );
  }

  final VerificationMeta _address2Meta = const VerificationMeta('address2');
  GeneratedTextColumn _address2;
  @override
  GeneratedTextColumn get address2 => _address2 ??= _constructAddress2();
  GeneratedTextColumn _constructAddress2() {
    return GeneratedTextColumn(
      'address2',
      $tableName,
      true,
    );
  }

  final VerificationMeta _invoiceMeta = const VerificationMeta('invoice');
  GeneratedBoolColumn _invoice;
  @override
  GeneratedBoolColumn get invoice => _invoice ??= _constructInvoice();
  GeneratedBoolColumn _constructInvoice() {
    return GeneratedBoolColumn(
      'invoice',
      $tableName,
      true,
    );
  }

  final VerificationMeta _invoicePrefixMeta =
      const VerificationMeta('invoicePrefix');
  GeneratedTextColumn _invoicePrefix;
  @override
  GeneratedTextColumn get invoicePrefix =>
      _invoicePrefix ??= _constructInvoicePrefix();
  GeneratedTextColumn _constructInvoicePrefix() {
    return GeneratedTextColumn(
      'invoice_prefix',
      $tableName,
      true,
    );
  }

  final VerificationMeta _invoiceStartMeta =
      const VerificationMeta('invoiceStart');
  GeneratedTextColumn _invoiceStart;
  @override
  GeneratedTextColumn get invoiceStart =>
      _invoiceStart ??= _constructInvoiceStart();
  GeneratedTextColumn _constructInvoiceStart() {
    return GeneratedTextColumn(
      'invoice_start',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        merchantId,
        companyId,
        pinCode,
        district,
        currency,
        language,
        area,
        cityId,
        stateId,
        countryId,
        cityName,
        stateName,
        countryName,
        address1,
        address2,
        invoice,
        invoicePrefix,
        invoiceStart,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $CurrentStoresTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'current_stores';
  @override
  final String actualTableName = 'current_stores';
  @override
  VerificationContext validateIntegrity(CurrentStoresCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.companyId.present) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableValue(d.companyId.value, _companyIdMeta));
    } else if (companyId.isRequired && isInserting) {
      context.missing(_companyIdMeta);
    }
    if (d.pinCode.present) {
      context.handle(_pinCodeMeta,
          pinCode.isAcceptableValue(d.pinCode.value, _pinCodeMeta));
    } else if (pinCode.isRequired && isInserting) {
      context.missing(_pinCodeMeta);
    }
    if (d.district.present) {
      context.handle(_districtMeta,
          district.isAcceptableValue(d.district.value, _districtMeta));
    } else if (district.isRequired && isInserting) {
      context.missing(_districtMeta);
    }
    if (d.currency.present) {
      context.handle(_currencyMeta,
          currency.isAcceptableValue(d.currency.value, _currencyMeta));
    } else if (currency.isRequired && isInserting) {
      context.missing(_currencyMeta);
    }
    if (d.language.present) {
      context.handle(_languageMeta,
          language.isAcceptableValue(d.language.value, _languageMeta));
    } else if (language.isRequired && isInserting) {
      context.missing(_languageMeta);
    }
    if (d.area.present) {
      context.handle(
          _areaMeta, area.isAcceptableValue(d.area.value, _areaMeta));
    } else if (area.isRequired && isInserting) {
      context.missing(_areaMeta);
    }
    if (d.cityId.present) {
      context.handle(
          _cityIdMeta, cityId.isAcceptableValue(d.cityId.value, _cityIdMeta));
    } else if (cityId.isRequired && isInserting) {
      context.missing(_cityIdMeta);
    }
    if (d.stateId.present) {
      context.handle(_stateIdMeta,
          stateId.isAcceptableValue(d.stateId.value, _stateIdMeta));
    } else if (stateId.isRequired && isInserting) {
      context.missing(_stateIdMeta);
    }
    if (d.countryId.present) {
      context.handle(_countryIdMeta,
          countryId.isAcceptableValue(d.countryId.value, _countryIdMeta));
    } else if (countryId.isRequired && isInserting) {
      context.missing(_countryIdMeta);
    }
    if (d.cityName.present) {
      context.handle(_cityNameMeta,
          cityName.isAcceptableValue(d.cityName.value, _cityNameMeta));
    } else if (cityName.isRequired && isInserting) {
      context.missing(_cityNameMeta);
    }
    if (d.stateName.present) {
      context.handle(_stateNameMeta,
          stateName.isAcceptableValue(d.stateName.value, _stateNameMeta));
    } else if (stateName.isRequired && isInserting) {
      context.missing(_stateNameMeta);
    }
    if (d.countryName.present) {
      context.handle(_countryNameMeta,
          countryName.isAcceptableValue(d.countryName.value, _countryNameMeta));
    } else if (countryName.isRequired && isInserting) {
      context.missing(_countryNameMeta);
    }
    if (d.address1.present) {
      context.handle(_address1Meta,
          address1.isAcceptableValue(d.address1.value, _address1Meta));
    } else if (address1.isRequired && isInserting) {
      context.missing(_address1Meta);
    }
    if (d.address2.present) {
      context.handle(_address2Meta,
          address2.isAcceptableValue(d.address2.value, _address2Meta));
    } else if (address2.isRequired && isInserting) {
      context.missing(_address2Meta);
    }
    if (d.invoice.present) {
      context.handle(_invoiceMeta,
          invoice.isAcceptableValue(d.invoice.value, _invoiceMeta));
    } else if (invoice.isRequired && isInserting) {
      context.missing(_invoiceMeta);
    }
    if (d.invoicePrefix.present) {
      context.handle(
          _invoicePrefixMeta,
          invoicePrefix.isAcceptableValue(
              d.invoicePrefix.value, _invoicePrefixMeta));
    } else if (invoicePrefix.isRequired && isInserting) {
      context.missing(_invoicePrefixMeta);
    }
    if (d.invoiceStart.present) {
      context.handle(
          _invoiceStartMeta,
          invoiceStart.isAcceptableValue(
              d.invoiceStart.value, _invoiceStartMeta));
    } else if (invoiceStart.isRequired && isInserting) {
      context.missing(_invoiceStartMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CurrentStore map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CurrentStore.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CurrentStoresCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.companyId.present) {
      map['company_id'] = Variable<String, StringType>(d.companyId.value);
    }
    if (d.pinCode.present) {
      map['pin_code'] = Variable<String, StringType>(d.pinCode.value);
    }
    if (d.district.present) {
      map['district'] = Variable<String, StringType>(d.district.value);
    }
    if (d.currency.present) {
      map['currency'] = Variable<String, StringType>(d.currency.value);
    }
    if (d.language.present) {
      map['language'] = Variable<String, StringType>(d.language.value);
    }
    if (d.area.present) {
      map['area'] = Variable<String, StringType>(d.area.value);
    }
    if (d.cityId.present) {
      map['city_id'] = Variable<String, StringType>(d.cityId.value);
    }
    if (d.stateId.present) {
      map['state_id'] = Variable<String, StringType>(d.stateId.value);
    }
    if (d.countryId.present) {
      map['country_id'] = Variable<String, StringType>(d.countryId.value);
    }
    if (d.cityName.present) {
      map['city_name'] = Variable<String, StringType>(d.cityName.value);
    }
    if (d.stateName.present) {
      map['state_name'] = Variable<String, StringType>(d.stateName.value);
    }
    if (d.countryName.present) {
      map['country_name'] = Variable<String, StringType>(d.countryName.value);
    }
    if (d.address1.present) {
      map['address1'] = Variable<String, StringType>(d.address1.value);
    }
    if (d.address2.present) {
      map['address2'] = Variable<String, StringType>(d.address2.value);
    }
    if (d.invoice.present) {
      map['invoice'] = Variable<bool, BoolType>(d.invoice.value);
    }
    if (d.invoicePrefix.present) {
      map['invoice_prefix'] =
          Variable<String, StringType>(d.invoicePrefix.value);
    }
    if (d.invoiceStart.present) {
      map['invoice_start'] = Variable<String, StringType>(d.invoiceStart.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CurrentStoresTable createAlias(String alias) {
    return $CurrentStoresTable(_db, alias);
  }
}

class CurrentUser extends DataClass implements Insertable<CurrentUser> {
  final String id;
  final String mobile;
  final String unverifiedMobile;
  final String username;
  final String unverifiedUsername;
  final String firstName;
  final String lastName;
  final String merchantId;
  final String storeId;
  final String token;
  final int status;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String country;
  final String district;
  final String pinCode;
  final String cityName;
  final String stateName;
  final String countryName;
  final DateTime createdAt;
  final DateTime updatedAt;
  CurrentUser(
      {@required this.id,
      @required this.mobile,
      @required this.unverifiedMobile,
      @required this.username,
      @required this.unverifiedUsername,
      @required this.firstName,
      @required this.lastName,
      @required this.merchantId,
      @required this.storeId,
      @required this.token,
      @required this.status,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.country,
      this.district,
      this.pinCode,
      this.cityName,
      this.stateName,
      this.countryName,
      this.createdAt,
      this.updatedAt});
  factory CurrentUser.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CurrentUser(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      mobile:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}mobile']),
      unverifiedMobile: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}unverified_mobile']),
      username: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      unverifiedUsername: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}unverified_username']),
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      storeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}store_id']),
      token:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}token']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      address1: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address1']),
      address2: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address2']),
      city: stringType.mapFromDatabaseResponse(data['${effectivePrefix}city']),
      state:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}state']),
      country:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}country']),
      district: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}district']),
      pinCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pin_code']),
      cityName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}city_name']),
      stateName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}state_name']),
      countryName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}country_name']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory CurrentUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return CurrentUser(
      id: serializer.fromJson<String>(json['id']),
      mobile: serializer.fromJson<String>(json['mobile']),
      unverifiedMobile: serializer.fromJson<String>(json['unverifiedMobile']),
      username: serializer.fromJson<String>(json['username']),
      unverifiedUsername:
          serializer.fromJson<String>(json['unverifiedUsername']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      storeId: serializer.fromJson<String>(json['storeId']),
      token: serializer.fromJson<String>(json['token']),
      status: serializer.fromJson<int>(json['status']),
      address1: serializer.fromJson<String>(json['address1']),
      address2: serializer.fromJson<String>(json['address2']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      country: serializer.fromJson<String>(json['country']),
      district: serializer.fromJson<String>(json['district']),
      pinCode: serializer.fromJson<String>(json['pinCode']),
      cityName: serializer.fromJson<String>(json['cityName']),
      stateName: serializer.fromJson<String>(json['stateName']),
      countryName: serializer.fromJson<String>(json['countryName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'mobile': serializer.toJson<String>(mobile),
      'unverifiedMobile': serializer.toJson<String>(unverifiedMobile),
      'username': serializer.toJson<String>(username),
      'unverifiedUsername': serializer.toJson<String>(unverifiedUsername),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'merchantId': serializer.toJson<String>(merchantId),
      'storeId': serializer.toJson<String>(storeId),
      'token': serializer.toJson<String>(token),
      'status': serializer.toJson<int>(status),
      'address1': serializer.toJson<String>(address1),
      'address2': serializer.toJson<String>(address2),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'country': serializer.toJson<String>(country),
      'district': serializer.toJson<String>(district),
      'pinCode': serializer.toJson<String>(pinCode),
      'cityName': serializer.toJson<String>(cityName),
      'stateName': serializer.toJson<String>(stateName),
      'countryName': serializer.toJson<String>(countryName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<CurrentUser>>(bool nullToAbsent) {
    return CurrentUsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      mobile:
          mobile == null && nullToAbsent ? const Value.absent() : Value(mobile),
      unverifiedMobile: unverifiedMobile == null && nullToAbsent
          ? const Value.absent()
          : Value(unverifiedMobile),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      unverifiedUsername: unverifiedUsername == null && nullToAbsent
          ? const Value.absent()
          : Value(unverifiedUsername),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      address1: address1 == null && nullToAbsent
          ? const Value.absent()
          : Value(address1),
      address2: address2 == null && nullToAbsent
          ? const Value.absent()
          : Value(address2),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      state:
          state == null && nullToAbsent ? const Value.absent() : Value(state),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      pinCode: pinCode == null && nullToAbsent
          ? const Value.absent()
          : Value(pinCode),
      cityName: cityName == null && nullToAbsent
          ? const Value.absent()
          : Value(cityName),
      stateName: stateName == null && nullToAbsent
          ? const Value.absent()
          : Value(stateName),
      countryName: countryName == null && nullToAbsent
          ? const Value.absent()
          : Value(countryName),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  CurrentUser copyWith(
          {String id,
          String mobile,
          String unverifiedMobile,
          String username,
          String unverifiedUsername,
          String firstName,
          String lastName,
          String merchantId,
          String storeId,
          String token,
          int status,
          String address1,
          String address2,
          String city,
          String state,
          String country,
          String district,
          String pinCode,
          String cityName,
          String stateName,
          String countryName,
          DateTime createdAt,
          DateTime updatedAt}) =>
      CurrentUser(
        id: id ?? this.id,
        mobile: mobile ?? this.mobile,
        unverifiedMobile: unverifiedMobile ?? this.unverifiedMobile,
        username: username ?? this.username,
        unverifiedUsername: unverifiedUsername ?? this.unverifiedUsername,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        merchantId: merchantId ?? this.merchantId,
        storeId: storeId ?? this.storeId,
        token: token ?? this.token,
        status: status ?? this.status,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        district: district ?? this.district,
        pinCode: pinCode ?? this.pinCode,
        cityName: cityName ?? this.cityName,
        stateName: stateName ?? this.stateName,
        countryName: countryName ?? this.countryName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CurrentUser(')
          ..write('id: $id, ')
          ..write('mobile: $mobile, ')
          ..write('unverifiedMobile: $unverifiedMobile, ')
          ..write('username: $username, ')
          ..write('unverifiedUsername: $unverifiedUsername, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('merchantId: $merchantId, ')
          ..write('storeId: $storeId, ')
          ..write('token: $token, ')
          ..write('status: $status, ')
          ..write('address1: $address1, ')
          ..write('address2: $address2, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('district: $district, ')
          ..write('pinCode: $pinCode, ')
          ..write('cityName: $cityName, ')
          ..write('stateName: $stateName, ')
          ..write('countryName: $countryName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          mobile.hashCode,
          $mrjc(
              unverifiedMobile.hashCode,
              $mrjc(
                  username.hashCode,
                  $mrjc(
                      unverifiedUsername.hashCode,
                      $mrjc(
                          firstName.hashCode,
                          $mrjc(
                              lastName.hashCode,
                              $mrjc(
                                  merchantId.hashCode,
                                  $mrjc(
                                      storeId.hashCode,
                                      $mrjc(
                                          token.hashCode,
                                          $mrjc(
                                              status.hashCode,
                                              $mrjc(
                                                  address1.hashCode,
                                                  $mrjc(
                                                      address2.hashCode,
                                                      $mrjc(
                                                          city.hashCode,
                                                          $mrjc(
                                                              state.hashCode,
                                                              $mrjc(
                                                                  country
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      district
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          pinCode
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              cityName.hashCode,
                                                                              $mrjc(stateName.hashCode, $mrjc(countryName.hashCode, $mrjc(createdAt.hashCode, updatedAt.hashCode)))))))))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is CurrentUser &&
          other.id == id &&
          other.mobile == mobile &&
          other.unverifiedMobile == unverifiedMobile &&
          other.username == username &&
          other.unverifiedUsername == unverifiedUsername &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.merchantId == merchantId &&
          other.storeId == storeId &&
          other.token == token &&
          other.status == status &&
          other.address1 == address1 &&
          other.address2 == address2 &&
          other.city == city &&
          other.state == state &&
          other.country == country &&
          other.district == district &&
          other.pinCode == pinCode &&
          other.cityName == cityName &&
          other.stateName == stateName &&
          other.countryName == countryName &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class CurrentUsersCompanion extends UpdateCompanion<CurrentUser> {
  final Value<String> id;
  final Value<String> mobile;
  final Value<String> unverifiedMobile;
  final Value<String> username;
  final Value<String> unverifiedUsername;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> merchantId;
  final Value<String> storeId;
  final Value<String> token;
  final Value<int> status;
  final Value<String> address1;
  final Value<String> address2;
  final Value<String> city;
  final Value<String> state;
  final Value<String> country;
  final Value<String> district;
  final Value<String> pinCode;
  final Value<String> cityName;
  final Value<String> stateName;
  final Value<String> countryName;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CurrentUsersCompanion({
    this.id = const Value.absent(),
    this.mobile = const Value.absent(),
    this.unverifiedMobile = const Value.absent(),
    this.username = const Value.absent(),
    this.unverifiedUsername = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.storeId = const Value.absent(),
    this.token = const Value.absent(),
    this.status = const Value.absent(),
    this.address1 = const Value.absent(),
    this.address2 = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.district = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.cityName = const Value.absent(),
    this.stateName = const Value.absent(),
    this.countryName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CurrentUsersCompanion copyWith(
      {Value<String> id,
      Value<String> mobile,
      Value<String> unverifiedMobile,
      Value<String> username,
      Value<String> unverifiedUsername,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> merchantId,
      Value<String> storeId,
      Value<String> token,
      Value<int> status,
      Value<String> address1,
      Value<String> address2,
      Value<String> city,
      Value<String> state,
      Value<String> country,
      Value<String> district,
      Value<String> pinCode,
      Value<String> cityName,
      Value<String> stateName,
      Value<String> countryName,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CurrentUsersCompanion(
      id: id ?? this.id,
      mobile: mobile ?? this.mobile,
      unverifiedMobile: unverifiedMobile ?? this.unverifiedMobile,
      username: username ?? this.username,
      unverifiedUsername: unverifiedUsername ?? this.unverifiedUsername,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      merchantId: merchantId ?? this.merchantId,
      storeId: storeId ?? this.storeId,
      token: token ?? this.token,
      status: status ?? this.status,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      district: district ?? this.district,
      pinCode: pinCode ?? this.pinCode,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      countryName: countryName ?? this.countryName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CurrentUsersTable extends CurrentUsers
    with TableInfo<$CurrentUsersTable, CurrentUser> {
  final GeneratedDatabase _db;
  final String _alias;
  $CurrentUsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  GeneratedTextColumn _mobile;
  @override
  GeneratedTextColumn get mobile => _mobile ??= _constructMobile();
  GeneratedTextColumn _constructMobile() {
    return GeneratedTextColumn(
      'mobile',
      $tableName,
      false,
    );
  }

  final VerificationMeta _unverifiedMobileMeta =
      const VerificationMeta('unverifiedMobile');
  GeneratedTextColumn _unverifiedMobile;
  @override
  GeneratedTextColumn get unverifiedMobile =>
      _unverifiedMobile ??= _constructUnverifiedMobile();
  GeneratedTextColumn _constructUnverifiedMobile() {
    return GeneratedTextColumn(
      'unverified_mobile',
      $tableName,
      false,
    );
  }

  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  GeneratedTextColumn _username;
  @override
  GeneratedTextColumn get username => _username ??= _constructUsername();
  GeneratedTextColumn _constructUsername() {
    return GeneratedTextColumn(
      'username',
      $tableName,
      false,
    );
  }

  final VerificationMeta _unverifiedUsernameMeta =
      const VerificationMeta('unverifiedUsername');
  GeneratedTextColumn _unverifiedUsername;
  @override
  GeneratedTextColumn get unverifiedUsername =>
      _unverifiedUsername ??= _constructUnverifiedUsername();
  GeneratedTextColumn _constructUnverifiedUsername() {
    return GeneratedTextColumn(
      'unverified_username',
      $tableName,
      false,
    );
  }

  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  GeneratedTextColumn _firstName;
  @override
  GeneratedTextColumn get firstName => _firstName ??= _constructFirstName();
  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn(
      'first_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  GeneratedTextColumn _lastName;
  @override
  GeneratedTextColumn get lastName => _lastName ??= _constructLastName();
  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn(
      'last_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _storeIdMeta = const VerificationMeta('storeId');
  GeneratedTextColumn _storeId;
  @override
  GeneratedTextColumn get storeId => _storeId ??= _constructStoreId();
  GeneratedTextColumn _constructStoreId() {
    return GeneratedTextColumn(
      'store_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  GeneratedTextColumn _token;
  @override
  GeneratedTextColumn get token => _token ??= _constructToken();
  GeneratedTextColumn _constructToken() {
    return GeneratedTextColumn(
      'token',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _address1Meta = const VerificationMeta('address1');
  GeneratedTextColumn _address1;
  @override
  GeneratedTextColumn get address1 => _address1 ??= _constructAddress1();
  GeneratedTextColumn _constructAddress1() {
    return GeneratedTextColumn(
      'address1',
      $tableName,
      true,
    );
  }

  final VerificationMeta _address2Meta = const VerificationMeta('address2');
  GeneratedTextColumn _address2;
  @override
  GeneratedTextColumn get address2 => _address2 ??= _constructAddress2();
  GeneratedTextColumn _constructAddress2() {
    return GeneratedTextColumn(
      'address2',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityMeta = const VerificationMeta('city');
  GeneratedTextColumn _city;
  @override
  GeneratedTextColumn get city => _city ??= _constructCity();
  GeneratedTextColumn _constructCity() {
    return GeneratedTextColumn(
      'city',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateMeta = const VerificationMeta('state');
  GeneratedTextColumn _state;
  @override
  GeneratedTextColumn get state => _state ??= _constructState();
  GeneratedTextColumn _constructState() {
    return GeneratedTextColumn(
      'state',
      $tableName,
      true,
    );
  }

  final VerificationMeta _countryMeta = const VerificationMeta('country');
  GeneratedTextColumn _country;
  @override
  GeneratedTextColumn get country => _country ??= _constructCountry();
  GeneratedTextColumn _constructCountry() {
    return GeneratedTextColumn(
      'country',
      $tableName,
      true,
    );
  }

  final VerificationMeta _districtMeta = const VerificationMeta('district');
  GeneratedTextColumn _district;
  @override
  GeneratedTextColumn get district => _district ??= _constructDistrict();
  GeneratedTextColumn _constructDistrict() {
    return GeneratedTextColumn(
      'district',
      $tableName,
      true,
    );
  }

  final VerificationMeta _pinCodeMeta = const VerificationMeta('pinCode');
  GeneratedTextColumn _pinCode;
  @override
  GeneratedTextColumn get pinCode => _pinCode ??= _constructPinCode();
  GeneratedTextColumn _constructPinCode() {
    return GeneratedTextColumn(
      'pin_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityNameMeta = const VerificationMeta('cityName');
  GeneratedTextColumn _cityName;
  @override
  GeneratedTextColumn get cityName => _cityName ??= _constructCityName();
  GeneratedTextColumn _constructCityName() {
    return GeneratedTextColumn(
      'city_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateNameMeta = const VerificationMeta('stateName');
  GeneratedTextColumn _stateName;
  @override
  GeneratedTextColumn get stateName => _stateName ??= _constructStateName();
  GeneratedTextColumn _constructStateName() {
    return GeneratedTextColumn(
      'state_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _countryNameMeta =
      const VerificationMeta('countryName');
  GeneratedTextColumn _countryName;
  @override
  GeneratedTextColumn get countryName =>
      _countryName ??= _constructCountryName();
  GeneratedTextColumn _constructCountryName() {
    return GeneratedTextColumn(
      'country_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        mobile,
        unverifiedMobile,
        username,
        unverifiedUsername,
        firstName,
        lastName,
        merchantId,
        storeId,
        token,
        status,
        address1,
        address2,
        city,
        state,
        country,
        district,
        pinCode,
        cityName,
        stateName,
        countryName,
        createdAt,
        updatedAt
      ];
  @override
  $CurrentUsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'current_users';
  @override
  final String actualTableName = 'current_users';
  @override
  VerificationContext validateIntegrity(CurrentUsersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.mobile.present) {
      context.handle(
          _mobileMeta, mobile.isAcceptableValue(d.mobile.value, _mobileMeta));
    } else if (mobile.isRequired && isInserting) {
      context.missing(_mobileMeta);
    }
    if (d.unverifiedMobile.present) {
      context.handle(
          _unverifiedMobileMeta,
          unverifiedMobile.isAcceptableValue(
              d.unverifiedMobile.value, _unverifiedMobileMeta));
    } else if (unverifiedMobile.isRequired && isInserting) {
      context.missing(_unverifiedMobileMeta);
    }
    if (d.username.present) {
      context.handle(_usernameMeta,
          username.isAcceptableValue(d.username.value, _usernameMeta));
    } else if (username.isRequired && isInserting) {
      context.missing(_usernameMeta);
    }
    if (d.unverifiedUsername.present) {
      context.handle(
          _unverifiedUsernameMeta,
          unverifiedUsername.isAcceptableValue(
              d.unverifiedUsername.value, _unverifiedUsernameMeta));
    } else if (unverifiedUsername.isRequired && isInserting) {
      context.missing(_unverifiedUsernameMeta);
    }
    if (d.firstName.present) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableValue(d.firstName.value, _firstNameMeta));
    } else if (firstName.isRequired && isInserting) {
      context.missing(_firstNameMeta);
    }
    if (d.lastName.present) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableValue(d.lastName.value, _lastNameMeta));
    } else if (lastName.isRequired && isInserting) {
      context.missing(_lastNameMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.storeId.present) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableValue(d.storeId.value, _storeIdMeta));
    } else if (storeId.isRequired && isInserting) {
      context.missing(_storeIdMeta);
    }
    if (d.token.present) {
      context.handle(
          _tokenMeta, token.isAcceptableValue(d.token.value, _tokenMeta));
    } else if (token.isRequired && isInserting) {
      context.missing(_tokenMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.address1.present) {
      context.handle(_address1Meta,
          address1.isAcceptableValue(d.address1.value, _address1Meta));
    } else if (address1.isRequired && isInserting) {
      context.missing(_address1Meta);
    }
    if (d.address2.present) {
      context.handle(_address2Meta,
          address2.isAcceptableValue(d.address2.value, _address2Meta));
    } else if (address2.isRequired && isInserting) {
      context.missing(_address2Meta);
    }
    if (d.city.present) {
      context.handle(
          _cityMeta, city.isAcceptableValue(d.city.value, _cityMeta));
    } else if (city.isRequired && isInserting) {
      context.missing(_cityMeta);
    }
    if (d.state.present) {
      context.handle(
          _stateMeta, state.isAcceptableValue(d.state.value, _stateMeta));
    } else if (state.isRequired && isInserting) {
      context.missing(_stateMeta);
    }
    if (d.country.present) {
      context.handle(_countryMeta,
          country.isAcceptableValue(d.country.value, _countryMeta));
    } else if (country.isRequired && isInserting) {
      context.missing(_countryMeta);
    }
    if (d.district.present) {
      context.handle(_districtMeta,
          district.isAcceptableValue(d.district.value, _districtMeta));
    } else if (district.isRequired && isInserting) {
      context.missing(_districtMeta);
    }
    if (d.pinCode.present) {
      context.handle(_pinCodeMeta,
          pinCode.isAcceptableValue(d.pinCode.value, _pinCodeMeta));
    } else if (pinCode.isRequired && isInserting) {
      context.missing(_pinCodeMeta);
    }
    if (d.cityName.present) {
      context.handle(_cityNameMeta,
          cityName.isAcceptableValue(d.cityName.value, _cityNameMeta));
    } else if (cityName.isRequired && isInserting) {
      context.missing(_cityNameMeta);
    }
    if (d.stateName.present) {
      context.handle(_stateNameMeta,
          stateName.isAcceptableValue(d.stateName.value, _stateNameMeta));
    } else if (stateName.isRequired && isInserting) {
      context.missing(_stateNameMeta);
    }
    if (d.countryName.present) {
      context.handle(_countryNameMeta,
          countryName.isAcceptableValue(d.countryName.value, _countryNameMeta));
    } else if (countryName.isRequired && isInserting) {
      context.missing(_countryNameMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CurrentUser map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CurrentUser.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CurrentUsersCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.mobile.present) {
      map['mobile'] = Variable<String, StringType>(d.mobile.value);
    }
    if (d.unverifiedMobile.present) {
      map['unverified_mobile'] =
          Variable<String, StringType>(d.unverifiedMobile.value);
    }
    if (d.username.present) {
      map['username'] = Variable<String, StringType>(d.username.value);
    }
    if (d.unverifiedUsername.present) {
      map['unverified_username'] =
          Variable<String, StringType>(d.unverifiedUsername.value);
    }
    if (d.firstName.present) {
      map['first_name'] = Variable<String, StringType>(d.firstName.value);
    }
    if (d.lastName.present) {
      map['last_name'] = Variable<String, StringType>(d.lastName.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.storeId.present) {
      map['store_id'] = Variable<String, StringType>(d.storeId.value);
    }
    if (d.token.present) {
      map['token'] = Variable<String, StringType>(d.token.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.address1.present) {
      map['address1'] = Variable<String, StringType>(d.address1.value);
    }
    if (d.address2.present) {
      map['address2'] = Variable<String, StringType>(d.address2.value);
    }
    if (d.city.present) {
      map['city'] = Variable<String, StringType>(d.city.value);
    }
    if (d.state.present) {
      map['state'] = Variable<String, StringType>(d.state.value);
    }
    if (d.country.present) {
      map['country'] = Variable<String, StringType>(d.country.value);
    }
    if (d.district.present) {
      map['district'] = Variable<String, StringType>(d.district.value);
    }
    if (d.pinCode.present) {
      map['pin_code'] = Variable<String, StringType>(d.pinCode.value);
    }
    if (d.cityName.present) {
      map['city_name'] = Variable<String, StringType>(d.cityName.value);
    }
    if (d.stateName.present) {
      map['state_name'] = Variable<String, StringType>(d.stateName.value);
    }
    if (d.countryName.present) {
      map['country_name'] = Variable<String, StringType>(d.countryName.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CurrentUsersTable createAlias(String alias) {
    return $CurrentUsersTable(_db, alias);
  }
}

class Distributor extends DataClass implements Insertable<Distributor> {
  final String id;
  final String name;
  final String image;
  final String firstName;
  final String lastName;
  final String mail;
  final String mobile;
  final String merchantId;
  final String since;
  final String gstin;
  final String address1;
  final String address2;
  final String pinCode;
  final String district;
  final String areaId;
  final String cityId;
  final String countryId;
  final String stateId;
  final String cityName;
  final String stateName;
  final String countryName;
  final String products;
  final String localId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  Distributor(
      {@required this.id,
      @required this.name,
      this.image,
      @required this.firstName,
      @required this.lastName,
      this.mail,
      this.mobile,
      @required this.merchantId,
      this.since,
      this.gstin,
      this.address1,
      this.address2,
      this.pinCode,
      this.district,
      this.areaId,
      this.cityId,
      this.countryId,
      this.stateId,
      this.cityName,
      this.stateName,
      this.countryName,
      this.products,
      this.localId,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory Distributor.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Distributor(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      mail: stringType.mapFromDatabaseResponse(data['${effectivePrefix}mail']),
      mobile:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}mobile']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      since:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}since']),
      gstin:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}gstin']),
      address1: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address1']),
      address2: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address2']),
      pinCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pin_code']),
      district: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}district']),
      areaId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}area_id']),
      cityId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}city_id']),
      countryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}country_id']),
      stateId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}state_id']),
      cityName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}city_name']),
      stateName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}state_name']),
      countryName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}country_name']),
      products: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}products']),
      localId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Distributor.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Distributor(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      mail: serializer.fromJson<String>(json['mail']),
      mobile: serializer.fromJson<String>(json['mobile']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      since: serializer.fromJson<String>(json['since']),
      gstin: serializer.fromJson<String>(json['gstin']),
      address1: serializer.fromJson<String>(json['address1']),
      address2: serializer.fromJson<String>(json['address2']),
      pinCode: serializer.fromJson<String>(json['pinCode']),
      district: serializer.fromJson<String>(json['district']),
      areaId: serializer.fromJson<String>(json['areaId']),
      cityId: serializer.fromJson<String>(json['cityId']),
      countryId: serializer.fromJson<String>(json['countryId']),
      stateId: serializer.fromJson<String>(json['stateId']),
      cityName: serializer.fromJson<String>(json['cityName']),
      stateName: serializer.fromJson<String>(json['stateName']),
      countryName: serializer.fromJson<String>(json['countryName']),
      products: serializer.fromJson<String>(json['products']),
      localId: serializer.fromJson<String>(json['localId']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'mail': serializer.toJson<String>(mail),
      'mobile': serializer.toJson<String>(mobile),
      'merchantId': serializer.toJson<String>(merchantId),
      'since': serializer.toJson<String>(since),
      'gstin': serializer.toJson<String>(gstin),
      'address1': serializer.toJson<String>(address1),
      'address2': serializer.toJson<String>(address2),
      'pinCode': serializer.toJson<String>(pinCode),
      'district': serializer.toJson<String>(district),
      'areaId': serializer.toJson<String>(areaId),
      'cityId': serializer.toJson<String>(cityId),
      'countryId': serializer.toJson<String>(countryId),
      'stateId': serializer.toJson<String>(stateId),
      'cityName': serializer.toJson<String>(cityName),
      'stateName': serializer.toJson<String>(stateName),
      'countryName': serializer.toJson<String>(countryName),
      'products': serializer.toJson<String>(products),
      'localId': serializer.toJson<String>(localId),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Distributor>>(bool nullToAbsent) {
    return DistributorsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      mail: mail == null && nullToAbsent ? const Value.absent() : Value(mail),
      mobile:
          mobile == null && nullToAbsent ? const Value.absent() : Value(mobile),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      since:
          since == null && nullToAbsent ? const Value.absent() : Value(since),
      gstin:
          gstin == null && nullToAbsent ? const Value.absent() : Value(gstin),
      address1: address1 == null && nullToAbsent
          ? const Value.absent()
          : Value(address1),
      address2: address2 == null && nullToAbsent
          ? const Value.absent()
          : Value(address2),
      pinCode: pinCode == null && nullToAbsent
          ? const Value.absent()
          : Value(pinCode),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      areaId:
          areaId == null && nullToAbsent ? const Value.absent() : Value(areaId),
      cityId:
          cityId == null && nullToAbsent ? const Value.absent() : Value(cityId),
      countryId: countryId == null && nullToAbsent
          ? const Value.absent()
          : Value(countryId),
      stateId: stateId == null && nullToAbsent
          ? const Value.absent()
          : Value(stateId),
      cityName: cityName == null && nullToAbsent
          ? const Value.absent()
          : Value(cityName),
      stateName: stateName == null && nullToAbsent
          ? const Value.absent()
          : Value(stateName),
      countryName: countryName == null && nullToAbsent
          ? const Value.absent()
          : Value(countryName),
      products: products == null && nullToAbsent
          ? const Value.absent()
          : Value(products),
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Distributor copyWith(
          {String id,
          String name,
          String image,
          String firstName,
          String lastName,
          String mail,
          String mobile,
          String merchantId,
          String since,
          String gstin,
          String address1,
          String address2,
          String pinCode,
          String district,
          String areaId,
          String cityId,
          String countryId,
          String stateId,
          String cityName,
          String stateName,
          String countryName,
          String products,
          String localId,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Distributor(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        mail: mail ?? this.mail,
        mobile: mobile ?? this.mobile,
        merchantId: merchantId ?? this.merchantId,
        since: since ?? this.since,
        gstin: gstin ?? this.gstin,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        pinCode: pinCode ?? this.pinCode,
        district: district ?? this.district,
        areaId: areaId ?? this.areaId,
        cityId: cityId ?? this.cityId,
        countryId: countryId ?? this.countryId,
        stateId: stateId ?? this.stateId,
        cityName: cityName ?? this.cityName,
        stateName: stateName ?? this.stateName,
        countryName: countryName ?? this.countryName,
        products: products ?? this.products,
        localId: localId ?? this.localId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Distributor(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('mail: $mail, ')
          ..write('mobile: $mobile, ')
          ..write('merchantId: $merchantId, ')
          ..write('since: $since, ')
          ..write('gstin: $gstin, ')
          ..write('address1: $address1, ')
          ..write('address2: $address2, ')
          ..write('pinCode: $pinCode, ')
          ..write('district: $district, ')
          ..write('areaId: $areaId, ')
          ..write('cityId: $cityId, ')
          ..write('countryId: $countryId, ')
          ..write('stateId: $stateId, ')
          ..write('cityName: $cityName, ')
          ..write('stateName: $stateName, ')
          ..write('countryName: $countryName, ')
          ..write('products: $products, ')
          ..write('localId: $localId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              image.hashCode,
              $mrjc(
                  firstName.hashCode,
                  $mrjc(
                      lastName.hashCode,
                      $mrjc(
                          mail.hashCode,
                          $mrjc(
                              mobile.hashCode,
                              $mrjc(
                                  merchantId.hashCode,
                                  $mrjc(
                                      since.hashCode,
                                      $mrjc(
                                          gstin.hashCode,
                                          $mrjc(
                                              address1.hashCode,
                                              $mrjc(
                                                  address2.hashCode,
                                                  $mrjc(
                                                      pinCode.hashCode,
                                                      $mrjc(
                                                          district.hashCode,
                                                          $mrjc(
                                                              areaId.hashCode,
                                                              $mrjc(
                                                                  cityId
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      countryId
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          stateId
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              cityName.hashCode,
                                                                              $mrjc(stateName.hashCode, $mrjc(countryName.hashCode, $mrjc(products.hashCode, $mrjc(localId.hashCode, $mrjc(status.hashCode, $mrjc(createdAt.hashCode, updatedAt.hashCode))))))))))))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Distributor &&
          other.id == id &&
          other.name == name &&
          other.image == image &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.mail == mail &&
          other.mobile == mobile &&
          other.merchantId == merchantId &&
          other.since == since &&
          other.gstin == gstin &&
          other.address1 == address1 &&
          other.address2 == address2 &&
          other.pinCode == pinCode &&
          other.district == district &&
          other.areaId == areaId &&
          other.cityId == cityId &&
          other.countryId == countryId &&
          other.stateId == stateId &&
          other.cityName == cityName &&
          other.stateName == stateName &&
          other.countryName == countryName &&
          other.products == products &&
          other.localId == localId &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class DistributorsCompanion extends UpdateCompanion<Distributor> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> image;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> mail;
  final Value<String> mobile;
  final Value<String> merchantId;
  final Value<String> since;
  final Value<String> gstin;
  final Value<String> address1;
  final Value<String> address2;
  final Value<String> pinCode;
  final Value<String> district;
  final Value<String> areaId;
  final Value<String> cityId;
  final Value<String> countryId;
  final Value<String> stateId;
  final Value<String> cityName;
  final Value<String> stateName;
  final Value<String> countryName;
  final Value<String> products;
  final Value<String> localId;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DistributorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.mail = const Value.absent(),
    this.mobile = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.since = const Value.absent(),
    this.gstin = const Value.absent(),
    this.address1 = const Value.absent(),
    this.address2 = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.district = const Value.absent(),
    this.areaId = const Value.absent(),
    this.cityId = const Value.absent(),
    this.countryId = const Value.absent(),
    this.stateId = const Value.absent(),
    this.cityName = const Value.absent(),
    this.stateName = const Value.absent(),
    this.countryName = const Value.absent(),
    this.products = const Value.absent(),
    this.localId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DistributorsCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> image,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> mail,
      Value<String> mobile,
      Value<String> merchantId,
      Value<String> since,
      Value<String> gstin,
      Value<String> address1,
      Value<String> address2,
      Value<String> pinCode,
      Value<String> district,
      Value<String> areaId,
      Value<String> cityId,
      Value<String> countryId,
      Value<String> stateId,
      Value<String> cityName,
      Value<String> stateName,
      Value<String> countryName,
      Value<String> products,
      Value<String> localId,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return DistributorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mail: mail ?? this.mail,
      mobile: mobile ?? this.mobile,
      merchantId: merchantId ?? this.merchantId,
      since: since ?? this.since,
      gstin: gstin ?? this.gstin,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      pinCode: pinCode ?? this.pinCode,
      district: district ?? this.district,
      areaId: areaId ?? this.areaId,
      cityId: cityId ?? this.cityId,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      countryName: countryName ?? this.countryName,
      products: products ?? this.products,
      localId: localId ?? this.localId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $DistributorsTable extends Distributors
    with TableInfo<$DistributorsTable, Distributor> {
  final GeneratedDatabase _db;
  final String _alias;
  $DistributorsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  GeneratedTextColumn _firstName;
  @override
  GeneratedTextColumn get firstName => _firstName ??= _constructFirstName();
  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn(
      'first_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  GeneratedTextColumn _lastName;
  @override
  GeneratedTextColumn get lastName => _lastName ??= _constructLastName();
  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn(
      'last_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _mailMeta = const VerificationMeta('mail');
  GeneratedTextColumn _mail;
  @override
  GeneratedTextColumn get mail => _mail ??= _constructMail();
  GeneratedTextColumn _constructMail() {
    return GeneratedTextColumn(
      'mail',
      $tableName,
      true,
    );
  }

  final VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  GeneratedTextColumn _mobile;
  @override
  GeneratedTextColumn get mobile => _mobile ??= _constructMobile();
  GeneratedTextColumn _constructMobile() {
    return GeneratedTextColumn(
      'mobile',
      $tableName,
      true,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sinceMeta = const VerificationMeta('since');
  GeneratedTextColumn _since;
  @override
  GeneratedTextColumn get since => _since ??= _constructSince();
  GeneratedTextColumn _constructSince() {
    return GeneratedTextColumn(
      'since',
      $tableName,
      true,
    );
  }

  final VerificationMeta _gstinMeta = const VerificationMeta('gstin');
  GeneratedTextColumn _gstin;
  @override
  GeneratedTextColumn get gstin => _gstin ??= _constructGstin();
  GeneratedTextColumn _constructGstin() {
    return GeneratedTextColumn(
      'gstin',
      $tableName,
      true,
    );
  }

  final VerificationMeta _address1Meta = const VerificationMeta('address1');
  GeneratedTextColumn _address1;
  @override
  GeneratedTextColumn get address1 => _address1 ??= _constructAddress1();
  GeneratedTextColumn _constructAddress1() {
    return GeneratedTextColumn(
      'address1',
      $tableName,
      true,
    );
  }

  final VerificationMeta _address2Meta = const VerificationMeta('address2');
  GeneratedTextColumn _address2;
  @override
  GeneratedTextColumn get address2 => _address2 ??= _constructAddress2();
  GeneratedTextColumn _constructAddress2() {
    return GeneratedTextColumn(
      'address2',
      $tableName,
      true,
    );
  }

  final VerificationMeta _pinCodeMeta = const VerificationMeta('pinCode');
  GeneratedTextColumn _pinCode;
  @override
  GeneratedTextColumn get pinCode => _pinCode ??= _constructPinCode();
  GeneratedTextColumn _constructPinCode() {
    return GeneratedTextColumn(
      'pin_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _districtMeta = const VerificationMeta('district');
  GeneratedTextColumn _district;
  @override
  GeneratedTextColumn get district => _district ??= _constructDistrict();
  GeneratedTextColumn _constructDistrict() {
    return GeneratedTextColumn(
      'district',
      $tableName,
      true,
    );
  }

  final VerificationMeta _areaIdMeta = const VerificationMeta('areaId');
  GeneratedTextColumn _areaId;
  @override
  GeneratedTextColumn get areaId => _areaId ??= _constructAreaId();
  GeneratedTextColumn _constructAreaId() {
    return GeneratedTextColumn(
      'area_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityIdMeta = const VerificationMeta('cityId');
  GeneratedTextColumn _cityId;
  @override
  GeneratedTextColumn get cityId => _cityId ??= _constructCityId();
  GeneratedTextColumn _constructCityId() {
    return GeneratedTextColumn(
      'city_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _countryIdMeta = const VerificationMeta('countryId');
  GeneratedTextColumn _countryId;
  @override
  GeneratedTextColumn get countryId => _countryId ??= _constructCountryId();
  GeneratedTextColumn _constructCountryId() {
    return GeneratedTextColumn(
      'country_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateIdMeta = const VerificationMeta('stateId');
  GeneratedTextColumn _stateId;
  @override
  GeneratedTextColumn get stateId => _stateId ??= _constructStateId();
  GeneratedTextColumn _constructStateId() {
    return GeneratedTextColumn(
      'state_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityNameMeta = const VerificationMeta('cityName');
  GeneratedTextColumn _cityName;
  @override
  GeneratedTextColumn get cityName => _cityName ??= _constructCityName();
  GeneratedTextColumn _constructCityName() {
    return GeneratedTextColumn(
      'city_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateNameMeta = const VerificationMeta('stateName');
  GeneratedTextColumn _stateName;
  @override
  GeneratedTextColumn get stateName => _stateName ??= _constructStateName();
  GeneratedTextColumn _constructStateName() {
    return GeneratedTextColumn(
      'state_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _countryNameMeta =
      const VerificationMeta('countryName');
  GeneratedTextColumn _countryName;
  @override
  GeneratedTextColumn get countryName =>
      _countryName ??= _constructCountryName();
  GeneratedTextColumn _constructCountryName() {
    return GeneratedTextColumn(
      'country_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productsMeta = const VerificationMeta('products');
  GeneratedTextColumn _products;
  @override
  GeneratedTextColumn get products => _products ??= _constructProducts();
  GeneratedTextColumn _constructProducts() {
    return GeneratedTextColumn(
      'products',
      $tableName,
      true,
    );
  }

  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  GeneratedTextColumn _localId;
  @override
  GeneratedTextColumn get localId => _localId ??= _constructLocalId();
  GeneratedTextColumn _constructLocalId() {
    return GeneratedTextColumn(
      'local_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        image,
        firstName,
        lastName,
        mail,
        mobile,
        merchantId,
        since,
        gstin,
        address1,
        address2,
        pinCode,
        district,
        areaId,
        cityId,
        countryId,
        stateId,
        cityName,
        stateName,
        countryName,
        products,
        localId,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $DistributorsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'distributors';
  @override
  final String actualTableName = 'distributors';
  @override
  VerificationContext validateIntegrity(DistributorsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.image.present) {
      context.handle(
          _imageMeta, image.isAcceptableValue(d.image.value, _imageMeta));
    } else if (image.isRequired && isInserting) {
      context.missing(_imageMeta);
    }
    if (d.firstName.present) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableValue(d.firstName.value, _firstNameMeta));
    } else if (firstName.isRequired && isInserting) {
      context.missing(_firstNameMeta);
    }
    if (d.lastName.present) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableValue(d.lastName.value, _lastNameMeta));
    } else if (lastName.isRequired && isInserting) {
      context.missing(_lastNameMeta);
    }
    if (d.mail.present) {
      context.handle(
          _mailMeta, mail.isAcceptableValue(d.mail.value, _mailMeta));
    } else if (mail.isRequired && isInserting) {
      context.missing(_mailMeta);
    }
    if (d.mobile.present) {
      context.handle(
          _mobileMeta, mobile.isAcceptableValue(d.mobile.value, _mobileMeta));
    } else if (mobile.isRequired && isInserting) {
      context.missing(_mobileMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.since.present) {
      context.handle(
          _sinceMeta, since.isAcceptableValue(d.since.value, _sinceMeta));
    } else if (since.isRequired && isInserting) {
      context.missing(_sinceMeta);
    }
    if (d.gstin.present) {
      context.handle(
          _gstinMeta, gstin.isAcceptableValue(d.gstin.value, _gstinMeta));
    } else if (gstin.isRequired && isInserting) {
      context.missing(_gstinMeta);
    }
    if (d.address1.present) {
      context.handle(_address1Meta,
          address1.isAcceptableValue(d.address1.value, _address1Meta));
    } else if (address1.isRequired && isInserting) {
      context.missing(_address1Meta);
    }
    if (d.address2.present) {
      context.handle(_address2Meta,
          address2.isAcceptableValue(d.address2.value, _address2Meta));
    } else if (address2.isRequired && isInserting) {
      context.missing(_address2Meta);
    }
    if (d.pinCode.present) {
      context.handle(_pinCodeMeta,
          pinCode.isAcceptableValue(d.pinCode.value, _pinCodeMeta));
    } else if (pinCode.isRequired && isInserting) {
      context.missing(_pinCodeMeta);
    }
    if (d.district.present) {
      context.handle(_districtMeta,
          district.isAcceptableValue(d.district.value, _districtMeta));
    } else if (district.isRequired && isInserting) {
      context.missing(_districtMeta);
    }
    if (d.areaId.present) {
      context.handle(
          _areaIdMeta, areaId.isAcceptableValue(d.areaId.value, _areaIdMeta));
    } else if (areaId.isRequired && isInserting) {
      context.missing(_areaIdMeta);
    }
    if (d.cityId.present) {
      context.handle(
          _cityIdMeta, cityId.isAcceptableValue(d.cityId.value, _cityIdMeta));
    } else if (cityId.isRequired && isInserting) {
      context.missing(_cityIdMeta);
    }
    if (d.countryId.present) {
      context.handle(_countryIdMeta,
          countryId.isAcceptableValue(d.countryId.value, _countryIdMeta));
    } else if (countryId.isRequired && isInserting) {
      context.missing(_countryIdMeta);
    }
    if (d.stateId.present) {
      context.handle(_stateIdMeta,
          stateId.isAcceptableValue(d.stateId.value, _stateIdMeta));
    } else if (stateId.isRequired && isInserting) {
      context.missing(_stateIdMeta);
    }
    if (d.cityName.present) {
      context.handle(_cityNameMeta,
          cityName.isAcceptableValue(d.cityName.value, _cityNameMeta));
    } else if (cityName.isRequired && isInserting) {
      context.missing(_cityNameMeta);
    }
    if (d.stateName.present) {
      context.handle(_stateNameMeta,
          stateName.isAcceptableValue(d.stateName.value, _stateNameMeta));
    } else if (stateName.isRequired && isInserting) {
      context.missing(_stateNameMeta);
    }
    if (d.countryName.present) {
      context.handle(_countryNameMeta,
          countryName.isAcceptableValue(d.countryName.value, _countryNameMeta));
    } else if (countryName.isRequired && isInserting) {
      context.missing(_countryNameMeta);
    }
    if (d.products.present) {
      context.handle(_productsMeta,
          products.isAcceptableValue(d.products.value, _productsMeta));
    } else if (products.isRequired && isInserting) {
      context.missing(_productsMeta);
    }
    if (d.localId.present) {
      context.handle(_localIdMeta,
          localId.isAcceptableValue(d.localId.value, _localIdMeta));
    } else if (localId.isRequired && isInserting) {
      context.missing(_localIdMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Distributor map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Distributor.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(DistributorsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.image.present) {
      map['image'] = Variable<String, StringType>(d.image.value);
    }
    if (d.firstName.present) {
      map['first_name'] = Variable<String, StringType>(d.firstName.value);
    }
    if (d.lastName.present) {
      map['last_name'] = Variable<String, StringType>(d.lastName.value);
    }
    if (d.mail.present) {
      map['mail'] = Variable<String, StringType>(d.mail.value);
    }
    if (d.mobile.present) {
      map['mobile'] = Variable<String, StringType>(d.mobile.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.since.present) {
      map['since'] = Variable<String, StringType>(d.since.value);
    }
    if (d.gstin.present) {
      map['gstin'] = Variable<String, StringType>(d.gstin.value);
    }
    if (d.address1.present) {
      map['address1'] = Variable<String, StringType>(d.address1.value);
    }
    if (d.address2.present) {
      map['address2'] = Variable<String, StringType>(d.address2.value);
    }
    if (d.pinCode.present) {
      map['pin_code'] = Variable<String, StringType>(d.pinCode.value);
    }
    if (d.district.present) {
      map['district'] = Variable<String, StringType>(d.district.value);
    }
    if (d.areaId.present) {
      map['area_id'] = Variable<String, StringType>(d.areaId.value);
    }
    if (d.cityId.present) {
      map['city_id'] = Variable<String, StringType>(d.cityId.value);
    }
    if (d.countryId.present) {
      map['country_id'] = Variable<String, StringType>(d.countryId.value);
    }
    if (d.stateId.present) {
      map['state_id'] = Variable<String, StringType>(d.stateId.value);
    }
    if (d.cityName.present) {
      map['city_name'] = Variable<String, StringType>(d.cityName.value);
    }
    if (d.stateName.present) {
      map['state_name'] = Variable<String, StringType>(d.stateName.value);
    }
    if (d.countryName.present) {
      map['country_name'] = Variable<String, StringType>(d.countryName.value);
    }
    if (d.products.present) {
      map['products'] = Variable<String, StringType>(d.products.value);
    }
    if (d.localId.present) {
      map['local_id'] = Variable<String, StringType>(d.localId.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $DistributorsTable createAlias(String alias) {
    return $DistributorsTable(_db, alias);
  }
}

class Manufacturer extends DataClass implements Insertable<Manufacturer> {
  final String id;
  final String name;
  final String mobile;
  final String image;
  final String mail;
  final String merchantId;
  final String gstin;
  final String address1;
  final String address2;
  final String pinCode;
  final String district;
  final String products;
  final String areaId;
  final String cityId;
  final String stateId;
  final String countryId;
  final String cityName;
  final String stateName;
  final String countryName;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  Manufacturer(
      {@required this.id,
      @required this.name,
      this.mobile,
      this.image,
      this.mail,
      @required this.merchantId,
      this.gstin,
      this.address1,
      this.address2,
      this.pinCode,
      this.district,
      this.products,
      this.areaId,
      this.cityId,
      this.stateId,
      this.countryId,
      this.cityName,
      this.stateName,
      this.countryName,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory Manufacturer.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Manufacturer(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      mobile:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}mobile']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      mail: stringType.mapFromDatabaseResponse(data['${effectivePrefix}mail']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      gstin:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}gstin']),
      address1: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address1']),
      address2: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address2']),
      pinCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pin_code']),
      district: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}district']),
      products: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}products']),
      areaId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}area_id']),
      cityId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}city_id']),
      stateId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}state_id']),
      countryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}country_id']),
      cityName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}city_name']),
      stateName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}state_name']),
      countryName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}country_name']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Manufacturer.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Manufacturer(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      mobile: serializer.fromJson<String>(json['mobile']),
      image: serializer.fromJson<String>(json['image']),
      mail: serializer.fromJson<String>(json['mail']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      gstin: serializer.fromJson<String>(json['gstin']),
      address1: serializer.fromJson<String>(json['address1']),
      address2: serializer.fromJson<String>(json['address2']),
      pinCode: serializer.fromJson<String>(json['pinCode']),
      district: serializer.fromJson<String>(json['district']),
      products: serializer.fromJson<String>(json['products']),
      areaId: serializer.fromJson<String>(json['areaId']),
      cityId: serializer.fromJson<String>(json['cityId']),
      stateId: serializer.fromJson<String>(json['stateId']),
      countryId: serializer.fromJson<String>(json['countryId']),
      cityName: serializer.fromJson<String>(json['cityName']),
      stateName: serializer.fromJson<String>(json['stateName']),
      countryName: serializer.fromJson<String>(json['countryName']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'mobile': serializer.toJson<String>(mobile),
      'image': serializer.toJson<String>(image),
      'mail': serializer.toJson<String>(mail),
      'merchantId': serializer.toJson<String>(merchantId),
      'gstin': serializer.toJson<String>(gstin),
      'address1': serializer.toJson<String>(address1),
      'address2': serializer.toJson<String>(address2),
      'pinCode': serializer.toJson<String>(pinCode),
      'district': serializer.toJson<String>(district),
      'products': serializer.toJson<String>(products),
      'areaId': serializer.toJson<String>(areaId),
      'cityId': serializer.toJson<String>(cityId),
      'stateId': serializer.toJson<String>(stateId),
      'countryId': serializer.toJson<String>(countryId),
      'cityName': serializer.toJson<String>(cityName),
      'stateName': serializer.toJson<String>(stateName),
      'countryName': serializer.toJson<String>(countryName),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Manufacturer>>(
      bool nullToAbsent) {
    return ManufacturersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      mobile:
          mobile == null && nullToAbsent ? const Value.absent() : Value(mobile),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      mail: mail == null && nullToAbsent ? const Value.absent() : Value(mail),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      gstin:
          gstin == null && nullToAbsent ? const Value.absent() : Value(gstin),
      address1: address1 == null && nullToAbsent
          ? const Value.absent()
          : Value(address1),
      address2: address2 == null && nullToAbsent
          ? const Value.absent()
          : Value(address2),
      pinCode: pinCode == null && nullToAbsent
          ? const Value.absent()
          : Value(pinCode),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      products: products == null && nullToAbsent
          ? const Value.absent()
          : Value(products),
      areaId:
          areaId == null && nullToAbsent ? const Value.absent() : Value(areaId),
      cityId:
          cityId == null && nullToAbsent ? const Value.absent() : Value(cityId),
      stateId: stateId == null && nullToAbsent
          ? const Value.absent()
          : Value(stateId),
      countryId: countryId == null && nullToAbsent
          ? const Value.absent()
          : Value(countryId),
      cityName: cityName == null && nullToAbsent
          ? const Value.absent()
          : Value(cityName),
      stateName: stateName == null && nullToAbsent
          ? const Value.absent()
          : Value(stateName),
      countryName: countryName == null && nullToAbsent
          ? const Value.absent()
          : Value(countryName),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Manufacturer copyWith(
          {String id,
          String name,
          String mobile,
          String image,
          String mail,
          String merchantId,
          String gstin,
          String address1,
          String address2,
          String pinCode,
          String district,
          String products,
          String areaId,
          String cityId,
          String stateId,
          String countryId,
          String cityName,
          String stateName,
          String countryName,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Manufacturer(
        id: id ?? this.id,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        image: image ?? this.image,
        mail: mail ?? this.mail,
        merchantId: merchantId ?? this.merchantId,
        gstin: gstin ?? this.gstin,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        pinCode: pinCode ?? this.pinCode,
        district: district ?? this.district,
        products: products ?? this.products,
        areaId: areaId ?? this.areaId,
        cityId: cityId ?? this.cityId,
        stateId: stateId ?? this.stateId,
        countryId: countryId ?? this.countryId,
        cityName: cityName ?? this.cityName,
        stateName: stateName ?? this.stateName,
        countryName: countryName ?? this.countryName,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Manufacturer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mobile: $mobile, ')
          ..write('image: $image, ')
          ..write('mail: $mail, ')
          ..write('merchantId: $merchantId, ')
          ..write('gstin: $gstin, ')
          ..write('address1: $address1, ')
          ..write('address2: $address2, ')
          ..write('pinCode: $pinCode, ')
          ..write('district: $district, ')
          ..write('products: $products, ')
          ..write('areaId: $areaId, ')
          ..write('cityId: $cityId, ')
          ..write('stateId: $stateId, ')
          ..write('countryId: $countryId, ')
          ..write('cityName: $cityName, ')
          ..write('stateName: $stateName, ')
          ..write('countryName: $countryName, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              mobile.hashCode,
              $mrjc(
                  image.hashCode,
                  $mrjc(
                      mail.hashCode,
                      $mrjc(
                          merchantId.hashCode,
                          $mrjc(
                              gstin.hashCode,
                              $mrjc(
                                  address1.hashCode,
                                  $mrjc(
                                      address2.hashCode,
                                      $mrjc(
                                          pinCode.hashCode,
                                          $mrjc(
                                              district.hashCode,
                                              $mrjc(
                                                  products.hashCode,
                                                  $mrjc(
                                                      areaId.hashCode,
                                                      $mrjc(
                                                          cityId.hashCode,
                                                          $mrjc(
                                                              stateId.hashCode,
                                                              $mrjc(
                                                                  countryId
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      cityName
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          stateName
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              countryName.hashCode,
                                                                              $mrjc(status.hashCode, $mrjc(createdAt.hashCode, updatedAt.hashCode))))))))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Manufacturer &&
          other.id == id &&
          other.name == name &&
          other.mobile == mobile &&
          other.image == image &&
          other.mail == mail &&
          other.merchantId == merchantId &&
          other.gstin == gstin &&
          other.address1 == address1 &&
          other.address2 == address2 &&
          other.pinCode == pinCode &&
          other.district == district &&
          other.products == products &&
          other.areaId == areaId &&
          other.cityId == cityId &&
          other.stateId == stateId &&
          other.countryId == countryId &&
          other.cityName == cityName &&
          other.stateName == stateName &&
          other.countryName == countryName &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class ManufacturersCompanion extends UpdateCompanion<Manufacturer> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> mobile;
  final Value<String> image;
  final Value<String> mail;
  final Value<String> merchantId;
  final Value<String> gstin;
  final Value<String> address1;
  final Value<String> address2;
  final Value<String> pinCode;
  final Value<String> district;
  final Value<String> products;
  final Value<String> areaId;
  final Value<String> cityId;
  final Value<String> stateId;
  final Value<String> countryId;
  final Value<String> cityName;
  final Value<String> stateName;
  final Value<String> countryName;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ManufacturersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mobile = const Value.absent(),
    this.image = const Value.absent(),
    this.mail = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.gstin = const Value.absent(),
    this.address1 = const Value.absent(),
    this.address2 = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.district = const Value.absent(),
    this.products = const Value.absent(),
    this.areaId = const Value.absent(),
    this.cityId = const Value.absent(),
    this.stateId = const Value.absent(),
    this.countryId = const Value.absent(),
    this.cityName = const Value.absent(),
    this.stateName = const Value.absent(),
    this.countryName = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ManufacturersCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> mobile,
      Value<String> image,
      Value<String> mail,
      Value<String> merchantId,
      Value<String> gstin,
      Value<String> address1,
      Value<String> address2,
      Value<String> pinCode,
      Value<String> district,
      Value<String> products,
      Value<String> areaId,
      Value<String> cityId,
      Value<String> stateId,
      Value<String> countryId,
      Value<String> cityName,
      Value<String> stateName,
      Value<String> countryName,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return ManufacturersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      image: image ?? this.image,
      mail: mail ?? this.mail,
      merchantId: merchantId ?? this.merchantId,
      gstin: gstin ?? this.gstin,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      pinCode: pinCode ?? this.pinCode,
      district: district ?? this.district,
      products: products ?? this.products,
      areaId: areaId ?? this.areaId,
      cityId: cityId ?? this.cityId,
      stateId: stateId ?? this.stateId,
      countryId: countryId ?? this.countryId,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      countryName: countryName ?? this.countryName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $ManufacturersTable extends Manufacturers
    with TableInfo<$ManufacturersTable, Manufacturer> {
  final GeneratedDatabase _db;
  final String _alias;
  $ManufacturersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  GeneratedTextColumn _mobile;
  @override
  GeneratedTextColumn get mobile => _mobile ??= _constructMobile();
  GeneratedTextColumn _constructMobile() {
    return GeneratedTextColumn(
      'mobile',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _mailMeta = const VerificationMeta('mail');
  GeneratedTextColumn _mail;
  @override
  GeneratedTextColumn get mail => _mail ??= _constructMail();
  GeneratedTextColumn _constructMail() {
    return GeneratedTextColumn(
      'mail',
      $tableName,
      true,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _gstinMeta = const VerificationMeta('gstin');
  GeneratedTextColumn _gstin;
  @override
  GeneratedTextColumn get gstin => _gstin ??= _constructGstin();
  GeneratedTextColumn _constructGstin() {
    return GeneratedTextColumn(
      'gstin',
      $tableName,
      true,
    );
  }

  final VerificationMeta _address1Meta = const VerificationMeta('address1');
  GeneratedTextColumn _address1;
  @override
  GeneratedTextColumn get address1 => _address1 ??= _constructAddress1();
  GeneratedTextColumn _constructAddress1() {
    return GeneratedTextColumn(
      'address1',
      $tableName,
      true,
    );
  }

  final VerificationMeta _address2Meta = const VerificationMeta('address2');
  GeneratedTextColumn _address2;
  @override
  GeneratedTextColumn get address2 => _address2 ??= _constructAddress2();
  GeneratedTextColumn _constructAddress2() {
    return GeneratedTextColumn(
      'address2',
      $tableName,
      true,
    );
  }

  final VerificationMeta _pinCodeMeta = const VerificationMeta('pinCode');
  GeneratedTextColumn _pinCode;
  @override
  GeneratedTextColumn get pinCode => _pinCode ??= _constructPinCode();
  GeneratedTextColumn _constructPinCode() {
    return GeneratedTextColumn(
      'pin_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _districtMeta = const VerificationMeta('district');
  GeneratedTextColumn _district;
  @override
  GeneratedTextColumn get district => _district ??= _constructDistrict();
  GeneratedTextColumn _constructDistrict() {
    return GeneratedTextColumn(
      'district',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productsMeta = const VerificationMeta('products');
  GeneratedTextColumn _products;
  @override
  GeneratedTextColumn get products => _products ??= _constructProducts();
  GeneratedTextColumn _constructProducts() {
    return GeneratedTextColumn(
      'products',
      $tableName,
      true,
    );
  }

  final VerificationMeta _areaIdMeta = const VerificationMeta('areaId');
  GeneratedTextColumn _areaId;
  @override
  GeneratedTextColumn get areaId => _areaId ??= _constructAreaId();
  GeneratedTextColumn _constructAreaId() {
    return GeneratedTextColumn(
      'area_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityIdMeta = const VerificationMeta('cityId');
  GeneratedTextColumn _cityId;
  @override
  GeneratedTextColumn get cityId => _cityId ??= _constructCityId();
  GeneratedTextColumn _constructCityId() {
    return GeneratedTextColumn(
      'city_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateIdMeta = const VerificationMeta('stateId');
  GeneratedTextColumn _stateId;
  @override
  GeneratedTextColumn get stateId => _stateId ??= _constructStateId();
  GeneratedTextColumn _constructStateId() {
    return GeneratedTextColumn(
      'state_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _countryIdMeta = const VerificationMeta('countryId');
  GeneratedTextColumn _countryId;
  @override
  GeneratedTextColumn get countryId => _countryId ??= _constructCountryId();
  GeneratedTextColumn _constructCountryId() {
    return GeneratedTextColumn(
      'country_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityNameMeta = const VerificationMeta('cityName');
  GeneratedTextColumn _cityName;
  @override
  GeneratedTextColumn get cityName => _cityName ??= _constructCityName();
  GeneratedTextColumn _constructCityName() {
    return GeneratedTextColumn(
      'city_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateNameMeta = const VerificationMeta('stateName');
  GeneratedTextColumn _stateName;
  @override
  GeneratedTextColumn get stateName => _stateName ??= _constructStateName();
  GeneratedTextColumn _constructStateName() {
    return GeneratedTextColumn(
      'state_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _countryNameMeta =
      const VerificationMeta('countryName');
  GeneratedTextColumn _countryName;
  @override
  GeneratedTextColumn get countryName =>
      _countryName ??= _constructCountryName();
  GeneratedTextColumn _constructCountryName() {
    return GeneratedTextColumn(
      'country_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        mobile,
        image,
        mail,
        merchantId,
        gstin,
        address1,
        address2,
        pinCode,
        district,
        products,
        areaId,
        cityId,
        stateId,
        countryId,
        cityName,
        stateName,
        countryName,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $ManufacturersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'manufacturers';
  @override
  final String actualTableName = 'manufacturers';
  @override
  VerificationContext validateIntegrity(ManufacturersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.mobile.present) {
      context.handle(
          _mobileMeta, mobile.isAcceptableValue(d.mobile.value, _mobileMeta));
    } else if (mobile.isRequired && isInserting) {
      context.missing(_mobileMeta);
    }
    if (d.image.present) {
      context.handle(
          _imageMeta, image.isAcceptableValue(d.image.value, _imageMeta));
    } else if (image.isRequired && isInserting) {
      context.missing(_imageMeta);
    }
    if (d.mail.present) {
      context.handle(
          _mailMeta, mail.isAcceptableValue(d.mail.value, _mailMeta));
    } else if (mail.isRequired && isInserting) {
      context.missing(_mailMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.gstin.present) {
      context.handle(
          _gstinMeta, gstin.isAcceptableValue(d.gstin.value, _gstinMeta));
    } else if (gstin.isRequired && isInserting) {
      context.missing(_gstinMeta);
    }
    if (d.address1.present) {
      context.handle(_address1Meta,
          address1.isAcceptableValue(d.address1.value, _address1Meta));
    } else if (address1.isRequired && isInserting) {
      context.missing(_address1Meta);
    }
    if (d.address2.present) {
      context.handle(_address2Meta,
          address2.isAcceptableValue(d.address2.value, _address2Meta));
    } else if (address2.isRequired && isInserting) {
      context.missing(_address2Meta);
    }
    if (d.pinCode.present) {
      context.handle(_pinCodeMeta,
          pinCode.isAcceptableValue(d.pinCode.value, _pinCodeMeta));
    } else if (pinCode.isRequired && isInserting) {
      context.missing(_pinCodeMeta);
    }
    if (d.district.present) {
      context.handle(_districtMeta,
          district.isAcceptableValue(d.district.value, _districtMeta));
    } else if (district.isRequired && isInserting) {
      context.missing(_districtMeta);
    }
    if (d.products.present) {
      context.handle(_productsMeta,
          products.isAcceptableValue(d.products.value, _productsMeta));
    } else if (products.isRequired && isInserting) {
      context.missing(_productsMeta);
    }
    if (d.areaId.present) {
      context.handle(
          _areaIdMeta, areaId.isAcceptableValue(d.areaId.value, _areaIdMeta));
    } else if (areaId.isRequired && isInserting) {
      context.missing(_areaIdMeta);
    }
    if (d.cityId.present) {
      context.handle(
          _cityIdMeta, cityId.isAcceptableValue(d.cityId.value, _cityIdMeta));
    } else if (cityId.isRequired && isInserting) {
      context.missing(_cityIdMeta);
    }
    if (d.stateId.present) {
      context.handle(_stateIdMeta,
          stateId.isAcceptableValue(d.stateId.value, _stateIdMeta));
    } else if (stateId.isRequired && isInserting) {
      context.missing(_stateIdMeta);
    }
    if (d.countryId.present) {
      context.handle(_countryIdMeta,
          countryId.isAcceptableValue(d.countryId.value, _countryIdMeta));
    } else if (countryId.isRequired && isInserting) {
      context.missing(_countryIdMeta);
    }
    if (d.cityName.present) {
      context.handle(_cityNameMeta,
          cityName.isAcceptableValue(d.cityName.value, _cityNameMeta));
    } else if (cityName.isRequired && isInserting) {
      context.missing(_cityNameMeta);
    }
    if (d.stateName.present) {
      context.handle(_stateNameMeta,
          stateName.isAcceptableValue(d.stateName.value, _stateNameMeta));
    } else if (stateName.isRequired && isInserting) {
      context.missing(_stateNameMeta);
    }
    if (d.countryName.present) {
      context.handle(_countryNameMeta,
          countryName.isAcceptableValue(d.countryName.value, _countryNameMeta));
    } else if (countryName.isRequired && isInserting) {
      context.missing(_countryNameMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Manufacturer map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Manufacturer.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ManufacturersCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.mobile.present) {
      map['mobile'] = Variable<String, StringType>(d.mobile.value);
    }
    if (d.image.present) {
      map['image'] = Variable<String, StringType>(d.image.value);
    }
    if (d.mail.present) {
      map['mail'] = Variable<String, StringType>(d.mail.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.gstin.present) {
      map['gstin'] = Variable<String, StringType>(d.gstin.value);
    }
    if (d.address1.present) {
      map['address1'] = Variable<String, StringType>(d.address1.value);
    }
    if (d.address2.present) {
      map['address2'] = Variable<String, StringType>(d.address2.value);
    }
    if (d.pinCode.present) {
      map['pin_code'] = Variable<String, StringType>(d.pinCode.value);
    }
    if (d.district.present) {
      map['district'] = Variable<String, StringType>(d.district.value);
    }
    if (d.products.present) {
      map['products'] = Variable<String, StringType>(d.products.value);
    }
    if (d.areaId.present) {
      map['area_id'] = Variable<String, StringType>(d.areaId.value);
    }
    if (d.cityId.present) {
      map['city_id'] = Variable<String, StringType>(d.cityId.value);
    }
    if (d.stateId.present) {
      map['state_id'] = Variable<String, StringType>(d.stateId.value);
    }
    if (d.countryId.present) {
      map['country_id'] = Variable<String, StringType>(d.countryId.value);
    }
    if (d.cityName.present) {
      map['city_name'] = Variable<String, StringType>(d.cityName.value);
    }
    if (d.stateName.present) {
      map['state_name'] = Variable<String, StringType>(d.stateName.value);
    }
    if (d.countryName.present) {
      map['country_name'] = Variable<String, StringType>(d.countryName.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $ManufacturersTable createAlias(String alias) {
    return $ManufacturersTable(_db, alias);
  }
}

class Categorie extends DataClass implements Insertable<Categorie> {
  final String id;
  final String name;
  final String merchantId;
  final String storeId;
  final String color;
  final String parent;
  final String children;
  final String products;
  final String images;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  Categorie(
      {@required this.id,
      @required this.name,
      @required this.merchantId,
      @required this.storeId,
      this.color,
      this.parent,
      this.children,
      this.products,
      this.images,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory Categorie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Categorie(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      storeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}store_id']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      parent:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}parent']),
      children: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}children']),
      products: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}products']),
      images:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}images']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Categorie.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Categorie(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      storeId: serializer.fromJson<String>(json['storeId']),
      color: serializer.fromJson<String>(json['color']),
      parent: serializer.fromJson<String>(json['parent']),
      children: serializer.fromJson<String>(json['children']),
      products: serializer.fromJson<String>(json['products']),
      images: serializer.fromJson<String>(json['images']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'merchantId': serializer.toJson<String>(merchantId),
      'storeId': serializer.toJson<String>(storeId),
      'color': serializer.toJson<String>(color),
      'parent': serializer.toJson<String>(parent),
      'children': serializer.toJson<String>(children),
      'products': serializer.toJson<String>(products),
      'images': serializer.toJson<String>(images),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Categorie>>(bool nullToAbsent) {
    return CategoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      parent:
          parent == null && nullToAbsent ? const Value.absent() : Value(parent),
      children: children == null && nullToAbsent
          ? const Value.absent()
          : Value(children),
      products: products == null && nullToAbsent
          ? const Value.absent()
          : Value(products),
      images:
          images == null && nullToAbsent ? const Value.absent() : Value(images),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Categorie copyWith(
          {String id,
          String name,
          String merchantId,
          String storeId,
          String color,
          String parent,
          String children,
          String products,
          String images,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Categorie(
        id: id ?? this.id,
        name: name ?? this.name,
        merchantId: merchantId ?? this.merchantId,
        storeId: storeId ?? this.storeId,
        color: color ?? this.color,
        parent: parent ?? this.parent,
        children: children ?? this.children,
        products: products ?? this.products,
        images: images ?? this.images,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Categorie(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('merchantId: $merchantId, ')
          ..write('storeId: $storeId, ')
          ..write('color: $color, ')
          ..write('parent: $parent, ')
          ..write('children: $children, ')
          ..write('products: $products, ')
          ..write('images: $images, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              merchantId.hashCode,
              $mrjc(
                  storeId.hashCode,
                  $mrjc(
                      color.hashCode,
                      $mrjc(
                          parent.hashCode,
                          $mrjc(
                              children.hashCode,
                              $mrjc(
                                  products.hashCode,
                                  $mrjc(
                                      images.hashCode,
                                      $mrjc(
                                          status.hashCode,
                                          $mrjc(createdAt.hashCode,
                                              updatedAt.hashCode))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Categorie &&
          other.id == id &&
          other.name == name &&
          other.merchantId == merchantId &&
          other.storeId == storeId &&
          other.color == color &&
          other.parent == parent &&
          other.children == children &&
          other.products == products &&
          other.images == images &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<Categorie> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> merchantId;
  final Value<String> storeId;
  final Value<String> color;
  final Value<String> parent;
  final Value<String> children;
  final Value<String> products;
  final Value<String> images;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.storeId = const Value.absent(),
    this.color = const Value.absent(),
    this.parent = const Value.absent(),
    this.children = const Value.absent(),
    this.products = const Value.absent(),
    this.images = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoriesCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> merchantId,
      Value<String> storeId,
      Value<String> color,
      Value<String> parent,
      Value<String> children,
      Value<String> products,
      Value<String> images,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      merchantId: merchantId ?? this.merchantId,
      storeId: storeId ?? this.storeId,
      color: color ?? this.color,
      parent: parent ?? this.parent,
      children: children ?? this.children,
      products: products ?? this.products,
      images: images ?? this.images,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Categorie> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _storeIdMeta = const VerificationMeta('storeId');
  GeneratedTextColumn _storeId;
  @override
  GeneratedTextColumn get storeId => _storeId ??= _constructStoreId();
  GeneratedTextColumn _constructStoreId() {
    return GeneratedTextColumn(
      'store_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn(
      'color',
      $tableName,
      true,
    );
  }

  final VerificationMeta _parentMeta = const VerificationMeta('parent');
  GeneratedTextColumn _parent;
  @override
  GeneratedTextColumn get parent => _parent ??= _constructParent();
  GeneratedTextColumn _constructParent() {
    return GeneratedTextColumn(
      'parent',
      $tableName,
      true,
    );
  }

  final VerificationMeta _childrenMeta = const VerificationMeta('children');
  GeneratedTextColumn _children;
  @override
  GeneratedTextColumn get children => _children ??= _constructChildren();
  GeneratedTextColumn _constructChildren() {
    return GeneratedTextColumn(
      'children',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productsMeta = const VerificationMeta('products');
  GeneratedTextColumn _products;
  @override
  GeneratedTextColumn get products => _products ??= _constructProducts();
  GeneratedTextColumn _constructProducts() {
    return GeneratedTextColumn(
      'products',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imagesMeta = const VerificationMeta('images');
  GeneratedTextColumn _images;
  @override
  GeneratedTextColumn get images => _images ??= _constructImages();
  GeneratedTextColumn _constructImages() {
    return GeneratedTextColumn(
      'images',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        merchantId,
        storeId,
        color,
        parent,
        children,
        products,
        images,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(CategoriesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.storeId.present) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableValue(d.storeId.value, _storeIdMeta));
    } else if (storeId.isRequired && isInserting) {
      context.missing(_storeIdMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (color.isRequired && isInserting) {
      context.missing(_colorMeta);
    }
    if (d.parent.present) {
      context.handle(
          _parentMeta, parent.isAcceptableValue(d.parent.value, _parentMeta));
    } else if (parent.isRequired && isInserting) {
      context.missing(_parentMeta);
    }
    if (d.children.present) {
      context.handle(_childrenMeta,
          children.isAcceptableValue(d.children.value, _childrenMeta));
    } else if (children.isRequired && isInserting) {
      context.missing(_childrenMeta);
    }
    if (d.products.present) {
      context.handle(_productsMeta,
          products.isAcceptableValue(d.products.value, _productsMeta));
    } else if (products.isRequired && isInserting) {
      context.missing(_productsMeta);
    }
    if (d.images.present) {
      context.handle(
          _imagesMeta, images.isAcceptableValue(d.images.value, _imagesMeta));
    } else if (images.isRequired && isInserting) {
      context.missing(_imagesMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categorie map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Categorie.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CategoriesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.storeId.present) {
      map['store_id'] = Variable<String, StringType>(d.storeId.value);
    }
    if (d.color.present) {
      map['color'] = Variable<String, StringType>(d.color.value);
    }
    if (d.parent.present) {
      map['parent'] = Variable<String, StringType>(d.parent.value);
    }
    if (d.children.present) {
      map['children'] = Variable<String, StringType>(d.children.value);
    }
    if (d.products.present) {
      map['products'] = Variable<String, StringType>(d.products.value);
    }
    if (d.images.present) {
      map['images'] = Variable<String, StringType>(d.images.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String name;
  final String description;
  final String unitId;
  final String merchantId;
  final String distributors;
  final String manufacturerId;
  final String variants;
  final String categories;
  final String images;
  final String storeId;
  final String hsn;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  Product(
      {@required this.id,
      @required this.name,
      this.description,
      @required this.unitId,
      @required this.merchantId,
      this.distributors,
      this.manufacturerId,
      this.variants,
      this.categories,
      this.images,
      @required this.storeId,
      this.hsn,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory Product.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Product(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      unitId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}unit_id']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      distributors: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}distributors']),
      manufacturerId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}manufacturer_id']),
      variants: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}variants']),
      categories: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}categories']),
      images:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}images']),
      storeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}store_id']),
      hsn: stringType.mapFromDatabaseResponse(data['${effectivePrefix}hsn']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Product(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      unitId: serializer.fromJson<String>(json['unitId']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      distributors: serializer.fromJson<String>(json['distributors']),
      manufacturerId: serializer.fromJson<String>(json['manufacturerId']),
      variants: serializer.fromJson<String>(json['variants']),
      categories: serializer.fromJson<String>(json['categories']),
      images: serializer.fromJson<String>(json['images']),
      storeId: serializer.fromJson<String>(json['storeId']),
      hsn: serializer.fromJson<String>(json['hsn']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'unitId': serializer.toJson<String>(unitId),
      'merchantId': serializer.toJson<String>(merchantId),
      'distributors': serializer.toJson<String>(distributors),
      'manufacturerId': serializer.toJson<String>(manufacturerId),
      'variants': serializer.toJson<String>(variants),
      'categories': serializer.toJson<String>(categories),
      'images': serializer.toJson<String>(images),
      'storeId': serializer.toJson<String>(storeId),
      'hsn': serializer.toJson<String>(hsn),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Product>>(bool nullToAbsent) {
    return ProductsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      unitId:
          unitId == null && nullToAbsent ? const Value.absent() : Value(unitId),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      distributors: distributors == null && nullToAbsent
          ? const Value.absent()
          : Value(distributors),
      manufacturerId: manufacturerId == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturerId),
      variants: variants == null && nullToAbsent
          ? const Value.absent()
          : Value(variants),
      categories: categories == null && nullToAbsent
          ? const Value.absent()
          : Value(categories),
      images:
          images == null && nullToAbsent ? const Value.absent() : Value(images),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      hsn: hsn == null && nullToAbsent ? const Value.absent() : Value(hsn),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Product copyWith(
          {String id,
          String name,
          String description,
          String unitId,
          String merchantId,
          String distributors,
          String manufacturerId,
          String variants,
          String categories,
          String images,
          String storeId,
          String hsn,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        unitId: unitId ?? this.unitId,
        merchantId: merchantId ?? this.merchantId,
        distributors: distributors ?? this.distributors,
        manufacturerId: manufacturerId ?? this.manufacturerId,
        variants: variants ?? this.variants,
        categories: categories ?? this.categories,
        images: images ?? this.images,
        storeId: storeId ?? this.storeId,
        hsn: hsn ?? this.hsn,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('unitId: $unitId, ')
          ..write('merchantId: $merchantId, ')
          ..write('distributors: $distributors, ')
          ..write('manufacturerId: $manufacturerId, ')
          ..write('variants: $variants, ')
          ..write('categories: $categories, ')
          ..write('images: $images, ')
          ..write('storeId: $storeId, ')
          ..write('hsn: $hsn, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              description.hashCode,
              $mrjc(
                  unitId.hashCode,
                  $mrjc(
                      merchantId.hashCode,
                      $mrjc(
                          distributors.hashCode,
                          $mrjc(
                              manufacturerId.hashCode,
                              $mrjc(
                                  variants.hashCode,
                                  $mrjc(
                                      categories.hashCode,
                                      $mrjc(
                                          images.hashCode,
                                          $mrjc(
                                              storeId.hashCode,
                                              $mrjc(
                                                  hsn.hashCode,
                                                  $mrjc(
                                                      status.hashCode,
                                                      $mrjc(
                                                          createdAt.hashCode,
                                                          updatedAt
                                                              .hashCode)))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == id &&
          other.name == name &&
          other.description == description &&
          other.unitId == unitId &&
          other.merchantId == merchantId &&
          other.distributors == distributors &&
          other.manufacturerId == manufacturerId &&
          other.variants == variants &&
          other.categories == categories &&
          other.images == images &&
          other.storeId == storeId &&
          other.hsn == hsn &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> unitId;
  final Value<String> merchantId;
  final Value<String> distributors;
  final Value<String> manufacturerId;
  final Value<String> variants;
  final Value<String> categories;
  final Value<String> images;
  final Value<String> storeId;
  final Value<String> hsn;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.unitId = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.distributors = const Value.absent(),
    this.manufacturerId = const Value.absent(),
    this.variants = const Value.absent(),
    this.categories = const Value.absent(),
    this.images = const Value.absent(),
    this.storeId = const Value.absent(),
    this.hsn = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductsCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<String> unitId,
      Value<String> merchantId,
      Value<String> distributors,
      Value<String> manufacturerId,
      Value<String> variants,
      Value<String> categories,
      Value<String> images,
      Value<String> storeId,
      Value<String> hsn,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unitId: unitId ?? this.unitId,
      merchantId: merchantId ?? this.merchantId,
      distributors: distributors ?? this.distributors,
      manufacturerId: manufacturerId ?? this.manufacturerId,
      variants: variants ?? this.variants,
      categories: categories ?? this.categories,
      images: images ?? this.images,
      storeId: storeId ?? this.storeId,
      hsn: hsn ?? this.hsn,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  GeneratedTextColumn _unitId;
  @override
  GeneratedTextColumn get unitId => _unitId ??= _constructUnitId();
  GeneratedTextColumn _constructUnitId() {
    return GeneratedTextColumn(
      'unit_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _distributorsMeta =
      const VerificationMeta('distributors');
  GeneratedTextColumn _distributors;
  @override
  GeneratedTextColumn get distributors =>
      _distributors ??= _constructDistributors();
  GeneratedTextColumn _constructDistributors() {
    return GeneratedTextColumn(
      'distributors',
      $tableName,
      true,
    );
  }

  final VerificationMeta _manufacturerIdMeta =
      const VerificationMeta('manufacturerId');
  GeneratedTextColumn _manufacturerId;
  @override
  GeneratedTextColumn get manufacturerId =>
      _manufacturerId ??= _constructManufacturerId();
  GeneratedTextColumn _constructManufacturerId() {
    return GeneratedTextColumn(
      'manufacturer_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _variantsMeta = const VerificationMeta('variants');
  GeneratedTextColumn _variants;
  @override
  GeneratedTextColumn get variants => _variants ??= _constructVariants();
  GeneratedTextColumn _constructVariants() {
    return GeneratedTextColumn(
      'variants',
      $tableName,
      true,
    );
  }

  final VerificationMeta _categoriesMeta = const VerificationMeta('categories');
  GeneratedTextColumn _categories;
  @override
  GeneratedTextColumn get categories => _categories ??= _constructCategories();
  GeneratedTextColumn _constructCategories() {
    return GeneratedTextColumn(
      'categories',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imagesMeta = const VerificationMeta('images');
  GeneratedTextColumn _images;
  @override
  GeneratedTextColumn get images => _images ??= _constructImages();
  GeneratedTextColumn _constructImages() {
    return GeneratedTextColumn(
      'images',
      $tableName,
      true,
    );
  }

  final VerificationMeta _storeIdMeta = const VerificationMeta('storeId');
  GeneratedTextColumn _storeId;
  @override
  GeneratedTextColumn get storeId => _storeId ??= _constructStoreId();
  GeneratedTextColumn _constructStoreId() {
    return GeneratedTextColumn(
      'store_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hsnMeta = const VerificationMeta('hsn');
  GeneratedTextColumn _hsn;
  @override
  GeneratedTextColumn get hsn => _hsn ??= _constructHsn();
  GeneratedTextColumn _constructHsn() {
    return GeneratedTextColumn(
      'hsn',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        unitId,
        merchantId,
        distributors,
        manufacturerId,
        variants,
        categories,
        images,
        storeId,
        hsn,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $ProductsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'products';
  @override
  final String actualTableName = 'products';
  @override
  VerificationContext validateIntegrity(ProductsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.unitId.present) {
      context.handle(
          _unitIdMeta, unitId.isAcceptableValue(d.unitId.value, _unitIdMeta));
    } else if (unitId.isRequired && isInserting) {
      context.missing(_unitIdMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.distributors.present) {
      context.handle(
          _distributorsMeta,
          distributors.isAcceptableValue(
              d.distributors.value, _distributorsMeta));
    } else if (distributors.isRequired && isInserting) {
      context.missing(_distributorsMeta);
    }
    if (d.manufacturerId.present) {
      context.handle(
          _manufacturerIdMeta,
          manufacturerId.isAcceptableValue(
              d.manufacturerId.value, _manufacturerIdMeta));
    } else if (manufacturerId.isRequired && isInserting) {
      context.missing(_manufacturerIdMeta);
    }
    if (d.variants.present) {
      context.handle(_variantsMeta,
          variants.isAcceptableValue(d.variants.value, _variantsMeta));
    } else if (variants.isRequired && isInserting) {
      context.missing(_variantsMeta);
    }
    if (d.categories.present) {
      context.handle(_categoriesMeta,
          categories.isAcceptableValue(d.categories.value, _categoriesMeta));
    } else if (categories.isRequired && isInserting) {
      context.missing(_categoriesMeta);
    }
    if (d.images.present) {
      context.handle(
          _imagesMeta, images.isAcceptableValue(d.images.value, _imagesMeta));
    } else if (images.isRequired && isInserting) {
      context.missing(_imagesMeta);
    }
    if (d.storeId.present) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableValue(d.storeId.value, _storeIdMeta));
    } else if (storeId.isRequired && isInserting) {
      context.missing(_storeIdMeta);
    }
    if (d.hsn.present) {
      context.handle(_hsnMeta, hsn.isAcceptableValue(d.hsn.value, _hsnMeta));
    } else if (hsn.isRequired && isInserting) {
      context.missing(_hsnMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Product.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProductsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.unitId.present) {
      map['unit_id'] = Variable<String, StringType>(d.unitId.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.distributors.present) {
      map['distributors'] = Variable<String, StringType>(d.distributors.value);
    }
    if (d.manufacturerId.present) {
      map['manufacturer_id'] =
          Variable<String, StringType>(d.manufacturerId.value);
    }
    if (d.variants.present) {
      map['variants'] = Variable<String, StringType>(d.variants.value);
    }
    if (d.categories.present) {
      map['categories'] = Variable<String, StringType>(d.categories.value);
    }
    if (d.images.present) {
      map['images'] = Variable<String, StringType>(d.images.value);
    }
    if (d.storeId.present) {
      map['store_id'] = Variable<String, StringType>(d.storeId.value);
    }
    if (d.hsn.present) {
      map['hsn'] = Variable<String, StringType>(d.hsn.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(_db, alias);
  }
}

class FingerprintUserData extends DataClass
    implements Insertable<FingerprintUserData> {
  final String id;
  final String name;
  FingerprintUserData({@required this.id, @required this.name});
  factory FingerprintUserData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return FingerprintUserData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory FingerprintUserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return FingerprintUserData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<FingerprintUserData>>(
      bool nullToAbsent) {
    return FingerprintUserCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    ) as T;
  }

  FingerprintUserData copyWith({String id, String name}) => FingerprintUserData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('FingerprintUserData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is FingerprintUserData && other.id == id && other.name == name);
}

class FingerprintUserCompanion extends UpdateCompanion<FingerprintUserData> {
  final Value<String> id;
  final Value<String> name;
  const FingerprintUserCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  FingerprintUserCompanion copyWith({Value<String> id, Value<String> name}) {
    return FingerprintUserCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $FingerprintUserTable extends FingerprintUser
    with TableInfo<$FingerprintUserTable, FingerprintUserData> {
  final GeneratedDatabase _db;
  final String _alias;
  $FingerprintUserTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $FingerprintUserTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'fingerprint_user';
  @override
  final String actualTableName = 'fingerprint_user';
  @override
  VerificationContext validateIntegrity(FingerprintUserCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FingerprintUserData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FingerprintUserData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FingerprintUserCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $FingerprintUserTable createAlias(String alias) {
    return $FingerprintUserTable(_db, alias);
  }
}

class Package extends DataClass implements Insertable<Package> {
  final String id;
  final String name;
  final String description;
  final String unitId;
  final double price;
  final String sku;
  final String categories;
  final int inventory;
  final int threshold;
  final String image;
  final String list;
  final String barcode;
  final int gst;
  final int vat;
  final int cess;
  final bool isGst;
  final bool isVat;
  final String merchantId;
  final String storeId;
  final String localId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  Package(
      {@required this.id,
      @required this.name,
      this.description,
      this.unitId,
      this.price,
      this.sku,
      this.categories,
      this.inventory,
      this.threshold,
      this.image,
      this.list,
      this.barcode,
      this.gst,
      this.vat,
      this.cess,
      this.isGst,
      this.isVat,
      this.merchantId,
      this.storeId,
      this.localId,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory Package.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Package(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      unitId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}unit_id']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      sku: stringType.mapFromDatabaseResponse(data['${effectivePrefix}sku']),
      categories: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}categories']),
      inventory:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}inventory']),
      threshold:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}threshold']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      list: stringType.mapFromDatabaseResponse(data['${effectivePrefix}list']),
      barcode:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}barcode']),
      gst: intType.mapFromDatabaseResponse(data['${effectivePrefix}gst']),
      vat: intType.mapFromDatabaseResponse(data['${effectivePrefix}vat']),
      cess: intType.mapFromDatabaseResponse(data['${effectivePrefix}cess']),
      isGst: boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_gst']),
      isVat: boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_vat']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      storeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}store_id']),
      localId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}local_id']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Package.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Package(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      unitId: serializer.fromJson<String>(json['unitId']),
      price: serializer.fromJson<double>(json['price']),
      sku: serializer.fromJson<String>(json['sku']),
      categories: serializer.fromJson<String>(json['categories']),
      inventory: serializer.fromJson<int>(json['inventory']),
      threshold: serializer.fromJson<int>(json['threshold']),
      image: serializer.fromJson<String>(json['image']),
      list: serializer.fromJson<String>(json['list']),
      barcode: serializer.fromJson<String>(json['barcode']),
      gst: serializer.fromJson<int>(json['gst']),
      vat: serializer.fromJson<int>(json['vat']),
      cess: serializer.fromJson<int>(json['cess']),
      isGst: serializer.fromJson<bool>(json['isGst']),
      isVat: serializer.fromJson<bool>(json['isVat']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      storeId: serializer.fromJson<String>(json['storeId']),
      localId: serializer.fromJson<String>(json['localId']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'unitId': serializer.toJson<String>(unitId),
      'price': serializer.toJson<double>(price),
      'sku': serializer.toJson<String>(sku),
      'categories': serializer.toJson<String>(categories),
      'inventory': serializer.toJson<int>(inventory),
      'threshold': serializer.toJson<int>(threshold),
      'image': serializer.toJson<String>(image),
      'list': serializer.toJson<String>(list),
      'barcode': serializer.toJson<String>(barcode),
      'gst': serializer.toJson<int>(gst),
      'vat': serializer.toJson<int>(vat),
      'cess': serializer.toJson<int>(cess),
      'isGst': serializer.toJson<bool>(isGst),
      'isVat': serializer.toJson<bool>(isVat),
      'merchantId': serializer.toJson<String>(merchantId),
      'storeId': serializer.toJson<String>(storeId),
      'localId': serializer.toJson<String>(localId),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Package>>(bool nullToAbsent) {
    return PackagesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      unitId:
          unitId == null && nullToAbsent ? const Value.absent() : Value(unitId),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      categories: categories == null && nullToAbsent
          ? const Value.absent()
          : Value(categories),
      inventory: inventory == null && nullToAbsent
          ? const Value.absent()
          : Value(inventory),
      threshold: threshold == null && nullToAbsent
          ? const Value.absent()
          : Value(threshold),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      list: list == null && nullToAbsent ? const Value.absent() : Value(list),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      gst: gst == null && nullToAbsent ? const Value.absent() : Value(gst),
      vat: vat == null && nullToAbsent ? const Value.absent() : Value(vat),
      cess: cess == null && nullToAbsent ? const Value.absent() : Value(cess),
      isGst:
          isGst == null && nullToAbsent ? const Value.absent() : Value(isGst),
      isVat:
          isVat == null && nullToAbsent ? const Value.absent() : Value(isVat),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Package copyWith(
          {String id,
          String name,
          String description,
          String unitId,
          double price,
          String sku,
          String categories,
          int inventory,
          int threshold,
          String image,
          String list,
          String barcode,
          int gst,
          int vat,
          int cess,
          bool isGst,
          bool isVat,
          String merchantId,
          String storeId,
          String localId,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Package(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        unitId: unitId ?? this.unitId,
        price: price ?? this.price,
        sku: sku ?? this.sku,
        categories: categories ?? this.categories,
        inventory: inventory ?? this.inventory,
        threshold: threshold ?? this.threshold,
        image: image ?? this.image,
        list: list ?? this.list,
        barcode: barcode ?? this.barcode,
        gst: gst ?? this.gst,
        vat: vat ?? this.vat,
        cess: cess ?? this.cess,
        isGst: isGst ?? this.isGst,
        isVat: isVat ?? this.isVat,
        merchantId: merchantId ?? this.merchantId,
        storeId: storeId ?? this.storeId,
        localId: localId ?? this.localId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Package(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('unitId: $unitId, ')
          ..write('price: $price, ')
          ..write('sku: $sku, ')
          ..write('categories: $categories, ')
          ..write('inventory: $inventory, ')
          ..write('threshold: $threshold, ')
          ..write('image: $image, ')
          ..write('list: $list, ')
          ..write('barcode: $barcode, ')
          ..write('gst: $gst, ')
          ..write('vat: $vat, ')
          ..write('cess: $cess, ')
          ..write('isGst: $isGst, ')
          ..write('isVat: $isVat, ')
          ..write('merchantId: $merchantId, ')
          ..write('storeId: $storeId, ')
          ..write('localId: $localId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              description.hashCode,
              $mrjc(
                  unitId.hashCode,
                  $mrjc(
                      price.hashCode,
                      $mrjc(
                          sku.hashCode,
                          $mrjc(
                              categories.hashCode,
                              $mrjc(
                                  inventory.hashCode,
                                  $mrjc(
                                      threshold.hashCode,
                                      $mrjc(
                                          image.hashCode,
                                          $mrjc(
                                              list.hashCode,
                                              $mrjc(
                                                  barcode.hashCode,
                                                  $mrjc(
                                                      gst.hashCode,
                                                      $mrjc(
                                                          vat.hashCode,
                                                          $mrjc(
                                                              cess.hashCode,
                                                              $mrjc(
                                                                  isGst
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      isVat
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          merchantId
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              storeId.hashCode,
                                                                              $mrjc(localId.hashCode, $mrjc(status.hashCode, $mrjc(createdAt.hashCode, updatedAt.hashCode)))))))))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Package &&
          other.id == id &&
          other.name == name &&
          other.description == description &&
          other.unitId == unitId &&
          other.price == price &&
          other.sku == sku &&
          other.categories == categories &&
          other.inventory == inventory &&
          other.threshold == threshold &&
          other.image == image &&
          other.list == list &&
          other.barcode == barcode &&
          other.gst == gst &&
          other.vat == vat &&
          other.cess == cess &&
          other.isGst == isGst &&
          other.isVat == isVat &&
          other.merchantId == merchantId &&
          other.storeId == storeId &&
          other.localId == localId &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class PackagesCompanion extends UpdateCompanion<Package> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> unitId;
  final Value<double> price;
  final Value<String> sku;
  final Value<String> categories;
  final Value<int> inventory;
  final Value<int> threshold;
  final Value<String> image;
  final Value<String> list;
  final Value<String> barcode;
  final Value<int> gst;
  final Value<int> vat;
  final Value<int> cess;
  final Value<bool> isGst;
  final Value<bool> isVat;
  final Value<String> merchantId;
  final Value<String> storeId;
  final Value<String> localId;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PackagesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.unitId = const Value.absent(),
    this.price = const Value.absent(),
    this.sku = const Value.absent(),
    this.categories = const Value.absent(),
    this.inventory = const Value.absent(),
    this.threshold = const Value.absent(),
    this.image = const Value.absent(),
    this.list = const Value.absent(),
    this.barcode = const Value.absent(),
    this.gst = const Value.absent(),
    this.vat = const Value.absent(),
    this.cess = const Value.absent(),
    this.isGst = const Value.absent(),
    this.isVat = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.storeId = const Value.absent(),
    this.localId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PackagesCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<String> unitId,
      Value<double> price,
      Value<String> sku,
      Value<String> categories,
      Value<int> inventory,
      Value<int> threshold,
      Value<String> image,
      Value<String> list,
      Value<String> barcode,
      Value<int> gst,
      Value<int> vat,
      Value<int> cess,
      Value<bool> isGst,
      Value<bool> isVat,
      Value<String> merchantId,
      Value<String> storeId,
      Value<String> localId,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return PackagesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unitId: unitId ?? this.unitId,
      price: price ?? this.price,
      sku: sku ?? this.sku,
      categories: categories ?? this.categories,
      inventory: inventory ?? this.inventory,
      threshold: threshold ?? this.threshold,
      image: image ?? this.image,
      list: list ?? this.list,
      barcode: barcode ?? this.barcode,
      gst: gst ?? this.gst,
      vat: vat ?? this.vat,
      cess: cess ?? this.cess,
      isGst: isGst ?? this.isGst,
      isVat: isVat ?? this.isVat,
      merchantId: merchantId ?? this.merchantId,
      storeId: storeId ?? this.storeId,
      localId: localId ?? this.localId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $PackagesTable extends Packages with TableInfo<$PackagesTable, Package> {
  final GeneratedDatabase _db;
  final String _alias;
  $PackagesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  GeneratedTextColumn _unitId;
  @override
  GeneratedTextColumn get unitId => _unitId ??= _constructUnitId();
  GeneratedTextColumn _constructUnitId() {
    return GeneratedTextColumn(
      'unit_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      true,
    );
  }

  final VerificationMeta _skuMeta = const VerificationMeta('sku');
  GeneratedTextColumn _sku;
  @override
  GeneratedTextColumn get sku => _sku ??= _constructSku();
  GeneratedTextColumn _constructSku() {
    return GeneratedTextColumn(
      'sku',
      $tableName,
      true,
    );
  }

  final VerificationMeta _categoriesMeta = const VerificationMeta('categories');
  GeneratedTextColumn _categories;
  @override
  GeneratedTextColumn get categories => _categories ??= _constructCategories();
  GeneratedTextColumn _constructCategories() {
    return GeneratedTextColumn(
      'categories',
      $tableName,
      true,
    );
  }

  final VerificationMeta _inventoryMeta = const VerificationMeta('inventory');
  GeneratedIntColumn _inventory;
  @override
  GeneratedIntColumn get inventory => _inventory ??= _constructInventory();
  GeneratedIntColumn _constructInventory() {
    return GeneratedIntColumn(
      'inventory',
      $tableName,
      true,
    );
  }

  final VerificationMeta _thresholdMeta = const VerificationMeta('threshold');
  GeneratedIntColumn _threshold;
  @override
  GeneratedIntColumn get threshold => _threshold ??= _constructThreshold();
  GeneratedIntColumn _constructThreshold() {
    return GeneratedIntColumn(
      'threshold',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _listMeta = const VerificationMeta('list');
  GeneratedTextColumn _list;
  @override
  GeneratedTextColumn get list => _list ??= _constructList();
  GeneratedTextColumn _constructList() {
    return GeneratedTextColumn(
      'list',
      $tableName,
      true,
    );
  }

  final VerificationMeta _barcodeMeta = const VerificationMeta('barcode');
  GeneratedTextColumn _barcode;
  @override
  GeneratedTextColumn get barcode => _barcode ??= _constructBarcode();
  GeneratedTextColumn _constructBarcode() {
    return GeneratedTextColumn(
      'barcode',
      $tableName,
      true,
    );
  }

  final VerificationMeta _gstMeta = const VerificationMeta('gst');
  GeneratedIntColumn _gst;
  @override
  GeneratedIntColumn get gst => _gst ??= _constructGst();
  GeneratedIntColumn _constructGst() {
    return GeneratedIntColumn(
      'gst',
      $tableName,
      true,
    );
  }

  final VerificationMeta _vatMeta = const VerificationMeta('vat');
  GeneratedIntColumn _vat;
  @override
  GeneratedIntColumn get vat => _vat ??= _constructVat();
  GeneratedIntColumn _constructVat() {
    return GeneratedIntColumn(
      'vat',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cessMeta = const VerificationMeta('cess');
  GeneratedIntColumn _cess;
  @override
  GeneratedIntColumn get cess => _cess ??= _constructCess();
  GeneratedIntColumn _constructCess() {
    return GeneratedIntColumn(
      'cess',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isGstMeta = const VerificationMeta('isGst');
  GeneratedBoolColumn _isGst;
  @override
  GeneratedBoolColumn get isGst => _isGst ??= _constructIsGst();
  GeneratedBoolColumn _constructIsGst() {
    return GeneratedBoolColumn(
      'is_gst',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isVatMeta = const VerificationMeta('isVat');
  GeneratedBoolColumn _isVat;
  @override
  GeneratedBoolColumn get isVat => _isVat ??= _constructIsVat();
  GeneratedBoolColumn _constructIsVat() {
    return GeneratedBoolColumn(
      'is_vat',
      $tableName,
      true,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _storeIdMeta = const VerificationMeta('storeId');
  GeneratedTextColumn _storeId;
  @override
  GeneratedTextColumn get storeId => _storeId ??= _constructStoreId();
  GeneratedTextColumn _constructStoreId() {
    return GeneratedTextColumn(
      'store_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  GeneratedTextColumn _localId;
  @override
  GeneratedTextColumn get localId => _localId ??= _constructLocalId();
  GeneratedTextColumn _constructLocalId() {
    return GeneratedTextColumn(
      'local_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        unitId,
        price,
        sku,
        categories,
        inventory,
        threshold,
        image,
        list,
        barcode,
        gst,
        vat,
        cess,
        isGst,
        isVat,
        merchantId,
        storeId,
        localId,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $PackagesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'packages';
  @override
  final String actualTableName = 'packages';
  @override
  VerificationContext validateIntegrity(PackagesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.unitId.present) {
      context.handle(
          _unitIdMeta, unitId.isAcceptableValue(d.unitId.value, _unitIdMeta));
    } else if (unitId.isRequired && isInserting) {
      context.missing(_unitIdMeta);
    }
    if (d.price.present) {
      context.handle(
          _priceMeta, price.isAcceptableValue(d.price.value, _priceMeta));
    } else if (price.isRequired && isInserting) {
      context.missing(_priceMeta);
    }
    if (d.sku.present) {
      context.handle(_skuMeta, sku.isAcceptableValue(d.sku.value, _skuMeta));
    } else if (sku.isRequired && isInserting) {
      context.missing(_skuMeta);
    }
    if (d.categories.present) {
      context.handle(_categoriesMeta,
          categories.isAcceptableValue(d.categories.value, _categoriesMeta));
    } else if (categories.isRequired && isInserting) {
      context.missing(_categoriesMeta);
    }
    if (d.inventory.present) {
      context.handle(_inventoryMeta,
          inventory.isAcceptableValue(d.inventory.value, _inventoryMeta));
    } else if (inventory.isRequired && isInserting) {
      context.missing(_inventoryMeta);
    }
    if (d.threshold.present) {
      context.handle(_thresholdMeta,
          threshold.isAcceptableValue(d.threshold.value, _thresholdMeta));
    } else if (threshold.isRequired && isInserting) {
      context.missing(_thresholdMeta);
    }
    if (d.image.present) {
      context.handle(
          _imageMeta, image.isAcceptableValue(d.image.value, _imageMeta));
    } else if (image.isRequired && isInserting) {
      context.missing(_imageMeta);
    }
    if (d.list.present) {
      context.handle(
          _listMeta, list.isAcceptableValue(d.list.value, _listMeta));
    } else if (list.isRequired && isInserting) {
      context.missing(_listMeta);
    }
    if (d.barcode.present) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableValue(d.barcode.value, _barcodeMeta));
    } else if (barcode.isRequired && isInserting) {
      context.missing(_barcodeMeta);
    }
    if (d.gst.present) {
      context.handle(_gstMeta, gst.isAcceptableValue(d.gst.value, _gstMeta));
    } else if (gst.isRequired && isInserting) {
      context.missing(_gstMeta);
    }
    if (d.vat.present) {
      context.handle(_vatMeta, vat.isAcceptableValue(d.vat.value, _vatMeta));
    } else if (vat.isRequired && isInserting) {
      context.missing(_vatMeta);
    }
    if (d.cess.present) {
      context.handle(
          _cessMeta, cess.isAcceptableValue(d.cess.value, _cessMeta));
    } else if (cess.isRequired && isInserting) {
      context.missing(_cessMeta);
    }
    if (d.isGst.present) {
      context.handle(
          _isGstMeta, isGst.isAcceptableValue(d.isGst.value, _isGstMeta));
    } else if (isGst.isRequired && isInserting) {
      context.missing(_isGstMeta);
    }
    if (d.isVat.present) {
      context.handle(
          _isVatMeta, isVat.isAcceptableValue(d.isVat.value, _isVatMeta));
    } else if (isVat.isRequired && isInserting) {
      context.missing(_isVatMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.storeId.present) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableValue(d.storeId.value, _storeIdMeta));
    } else if (storeId.isRequired && isInserting) {
      context.missing(_storeIdMeta);
    }
    if (d.localId.present) {
      context.handle(_localIdMeta,
          localId.isAcceptableValue(d.localId.value, _localIdMeta));
    } else if (localId.isRequired && isInserting) {
      context.missing(_localIdMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Package map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Package.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PackagesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.unitId.present) {
      map['unit_id'] = Variable<String, StringType>(d.unitId.value);
    }
    if (d.price.present) {
      map['price'] = Variable<double, RealType>(d.price.value);
    }
    if (d.sku.present) {
      map['sku'] = Variable<String, StringType>(d.sku.value);
    }
    if (d.categories.present) {
      map['categories'] = Variable<String, StringType>(d.categories.value);
    }
    if (d.inventory.present) {
      map['inventory'] = Variable<int, IntType>(d.inventory.value);
    }
    if (d.threshold.present) {
      map['threshold'] = Variable<int, IntType>(d.threshold.value);
    }
    if (d.image.present) {
      map['image'] = Variable<String, StringType>(d.image.value);
    }
    if (d.list.present) {
      map['list'] = Variable<String, StringType>(d.list.value);
    }
    if (d.barcode.present) {
      map['barcode'] = Variable<String, StringType>(d.barcode.value);
    }
    if (d.gst.present) {
      map['gst'] = Variable<int, IntType>(d.gst.value);
    }
    if (d.vat.present) {
      map['vat'] = Variable<int, IntType>(d.vat.value);
    }
    if (d.cess.present) {
      map['cess'] = Variable<int, IntType>(d.cess.value);
    }
    if (d.isGst.present) {
      map['is_gst'] = Variable<bool, BoolType>(d.isGst.value);
    }
    if (d.isVat.present) {
      map['is_vat'] = Variable<bool, BoolType>(d.isVat.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.storeId.present) {
      map['store_id'] = Variable<String, StringType>(d.storeId.value);
    }
    if (d.localId.present) {
      map['local_id'] = Variable<String, StringType>(d.localId.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $PackagesTable createAlias(String alias) {
    return $PackagesTable(_db, alias);
  }
}

class Variant extends DataClass implements Insertable<Variant> {
  final String id;
  final String name;
  final double price;
  final String barcode;
  final String sku;
  final String attributes;
  final int inventory;
  final int mrp;
  final int threshold;
  final int gst;
  final int vat;
  final int cess;
  final String merchantId;
  final String productId;
  final String storeId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  Variant(
      {@required this.id,
      @required this.name,
      this.price,
      this.barcode,
      this.sku,
      this.attributes,
      this.inventory,
      this.mrp,
      this.threshold,
      this.gst,
      this.vat,
      this.cess,
      this.merchantId,
      this.productId,
      this.storeId,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory Variant.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Variant(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      barcode:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}barcode']),
      sku: stringType.mapFromDatabaseResponse(data['${effectivePrefix}sku']),
      attributes: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}attributes']),
      inventory:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}inventory']),
      mrp: intType.mapFromDatabaseResponse(data['${effectivePrefix}mrp']),
      threshold:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}threshold']),
      gst: intType.mapFromDatabaseResponse(data['${effectivePrefix}gst']),
      vat: intType.mapFromDatabaseResponse(data['${effectivePrefix}vat']),
      cess: intType.mapFromDatabaseResponse(data['${effectivePrefix}cess']),
      merchantId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}merchant_id']),
      productId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      storeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}store_id']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Variant.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Variant(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      barcode: serializer.fromJson<String>(json['barcode']),
      sku: serializer.fromJson<String>(json['sku']),
      attributes: serializer.fromJson<String>(json['attributes']),
      inventory: serializer.fromJson<int>(json['inventory']),
      mrp: serializer.fromJson<int>(json['mrp']),
      threshold: serializer.fromJson<int>(json['threshold']),
      gst: serializer.fromJson<int>(json['gst']),
      vat: serializer.fromJson<int>(json['vat']),
      cess: serializer.fromJson<int>(json['cess']),
      merchantId: serializer.fromJson<String>(json['merchantId']),
      productId: serializer.fromJson<String>(json['productId']),
      storeId: serializer.fromJson<String>(json['storeId']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'barcode': serializer.toJson<String>(barcode),
      'sku': serializer.toJson<String>(sku),
      'attributes': serializer.toJson<String>(attributes),
      'inventory': serializer.toJson<int>(inventory),
      'mrp': serializer.toJson<int>(mrp),
      'threshold': serializer.toJson<int>(threshold),
      'gst': serializer.toJson<int>(gst),
      'vat': serializer.toJson<int>(vat),
      'cess': serializer.toJson<int>(cess),
      'merchantId': serializer.toJson<String>(merchantId),
      'productId': serializer.toJson<String>(productId),
      'storeId': serializer.toJson<String>(storeId),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Variant>>(bool nullToAbsent) {
    return VariantsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      attributes: attributes == null && nullToAbsent
          ? const Value.absent()
          : Value(attributes),
      inventory: inventory == null && nullToAbsent
          ? const Value.absent()
          : Value(inventory),
      mrp: mrp == null && nullToAbsent ? const Value.absent() : Value(mrp),
      threshold: threshold == null && nullToAbsent
          ? const Value.absent()
          : Value(threshold),
      gst: gst == null && nullToAbsent ? const Value.absent() : Value(gst),
      vat: vat == null && nullToAbsent ? const Value.absent() : Value(vat),
      cess: cess == null && nullToAbsent ? const Value.absent() : Value(cess),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Variant copyWith(
          {String id,
          String name,
          double price,
          String barcode,
          String sku,
          String attributes,
          int inventory,
          int mrp,
          int threshold,
          int gst,
          int vat,
          int cess,
          String merchantId,
          String productId,
          String storeId,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Variant(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        barcode: barcode ?? this.barcode,
        sku: sku ?? this.sku,
        attributes: attributes ?? this.attributes,
        inventory: inventory ?? this.inventory,
        mrp: mrp ?? this.mrp,
        threshold: threshold ?? this.threshold,
        gst: gst ?? this.gst,
        vat: vat ?? this.vat,
        cess: cess ?? this.cess,
        merchantId: merchantId ?? this.merchantId,
        productId: productId ?? this.productId,
        storeId: storeId ?? this.storeId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Variant(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('barcode: $barcode, ')
          ..write('sku: $sku, ')
          ..write('attributes: $attributes, ')
          ..write('inventory: $inventory, ')
          ..write('mrp: $mrp, ')
          ..write('threshold: $threshold, ')
          ..write('gst: $gst, ')
          ..write('vat: $vat, ')
          ..write('cess: $cess, ')
          ..write('merchantId: $merchantId, ')
          ..write('productId: $productId, ')
          ..write('storeId: $storeId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              price.hashCode,
              $mrjc(
                  barcode.hashCode,
                  $mrjc(
                      sku.hashCode,
                      $mrjc(
                          attributes.hashCode,
                          $mrjc(
                              inventory.hashCode,
                              $mrjc(
                                  mrp.hashCode,
                                  $mrjc(
                                      threshold.hashCode,
                                      $mrjc(
                                          gst.hashCode,
                                          $mrjc(
                                              vat.hashCode,
                                              $mrjc(
                                                  cess.hashCode,
                                                  $mrjc(
                                                      merchantId.hashCode,
                                                      $mrjc(
                                                          productId.hashCode,
                                                          $mrjc(
                                                              storeId.hashCode,
                                                              $mrjc(
                                                                  status
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      createdAt
                                                                          .hashCode,
                                                                      updatedAt
                                                                          .hashCode))))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Variant &&
          other.id == id &&
          other.name == name &&
          other.price == price &&
          other.barcode == barcode &&
          other.sku == sku &&
          other.attributes == attributes &&
          other.inventory == inventory &&
          other.mrp == mrp &&
          other.threshold == threshold &&
          other.gst == gst &&
          other.vat == vat &&
          other.cess == cess &&
          other.merchantId == merchantId &&
          other.productId == productId &&
          other.storeId == storeId &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class VariantsCompanion extends UpdateCompanion<Variant> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> price;
  final Value<String> barcode;
  final Value<String> sku;
  final Value<String> attributes;
  final Value<int> inventory;
  final Value<int> mrp;
  final Value<int> threshold;
  final Value<int> gst;
  final Value<int> vat;
  final Value<int> cess;
  final Value<String> merchantId;
  final Value<String> productId;
  final Value<String> storeId;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const VariantsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.barcode = const Value.absent(),
    this.sku = const Value.absent(),
    this.attributes = const Value.absent(),
    this.inventory = const Value.absent(),
    this.mrp = const Value.absent(),
    this.threshold = const Value.absent(),
    this.gst = const Value.absent(),
    this.vat = const Value.absent(),
    this.cess = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.productId = const Value.absent(),
    this.storeId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VariantsCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<double> price,
      Value<String> barcode,
      Value<String> sku,
      Value<String> attributes,
      Value<int> inventory,
      Value<int> mrp,
      Value<int> threshold,
      Value<int> gst,
      Value<int> vat,
      Value<int> cess,
      Value<String> merchantId,
      Value<String> productId,
      Value<String> storeId,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return VariantsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      barcode: barcode ?? this.barcode,
      sku: sku ?? this.sku,
      attributes: attributes ?? this.attributes,
      inventory: inventory ?? this.inventory,
      mrp: mrp ?? this.mrp,
      threshold: threshold ?? this.threshold,
      gst: gst ?? this.gst,
      vat: vat ?? this.vat,
      cess: cess ?? this.cess,
      merchantId: merchantId ?? this.merchantId,
      productId: productId ?? this.productId,
      storeId: storeId ?? this.storeId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $VariantsTable extends Variants with TableInfo<$VariantsTable, Variant> {
  final GeneratedDatabase _db;
  final String _alias;
  $VariantsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      true,
    );
  }

  final VerificationMeta _barcodeMeta = const VerificationMeta('barcode');
  GeneratedTextColumn _barcode;
  @override
  GeneratedTextColumn get barcode => _barcode ??= _constructBarcode();
  GeneratedTextColumn _constructBarcode() {
    return GeneratedTextColumn(
      'barcode',
      $tableName,
      true,
    );
  }

  final VerificationMeta _skuMeta = const VerificationMeta('sku');
  GeneratedTextColumn _sku;
  @override
  GeneratedTextColumn get sku => _sku ??= _constructSku();
  GeneratedTextColumn _constructSku() {
    return GeneratedTextColumn(
      'sku',
      $tableName,
      true,
    );
  }

  final VerificationMeta _attributesMeta = const VerificationMeta('attributes');
  GeneratedTextColumn _attributes;
  @override
  GeneratedTextColumn get attributes => _attributes ??= _constructAttributes();
  GeneratedTextColumn _constructAttributes() {
    return GeneratedTextColumn(
      'attributes',
      $tableName,
      true,
    );
  }

  final VerificationMeta _inventoryMeta = const VerificationMeta('inventory');
  GeneratedIntColumn _inventory;
  @override
  GeneratedIntColumn get inventory => _inventory ??= _constructInventory();
  GeneratedIntColumn _constructInventory() {
    return GeneratedIntColumn(
      'inventory',
      $tableName,
      true,
    );
  }

  final VerificationMeta _mrpMeta = const VerificationMeta('mrp');
  GeneratedIntColumn _mrp;
  @override
  GeneratedIntColumn get mrp => _mrp ??= _constructMrp();
  GeneratedIntColumn _constructMrp() {
    return GeneratedIntColumn(
      'mrp',
      $tableName,
      true,
    );
  }

  final VerificationMeta _thresholdMeta = const VerificationMeta('threshold');
  GeneratedIntColumn _threshold;
  @override
  GeneratedIntColumn get threshold => _threshold ??= _constructThreshold();
  GeneratedIntColumn _constructThreshold() {
    return GeneratedIntColumn(
      'threshold',
      $tableName,
      true,
    );
  }

  final VerificationMeta _gstMeta = const VerificationMeta('gst');
  GeneratedIntColumn _gst;
  @override
  GeneratedIntColumn get gst => _gst ??= _constructGst();
  GeneratedIntColumn _constructGst() {
    return GeneratedIntColumn(
      'gst',
      $tableName,
      true,
    );
  }

  final VerificationMeta _vatMeta = const VerificationMeta('vat');
  GeneratedIntColumn _vat;
  @override
  GeneratedIntColumn get vat => _vat ??= _constructVat();
  GeneratedIntColumn _constructVat() {
    return GeneratedIntColumn(
      'vat',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cessMeta = const VerificationMeta('cess');
  GeneratedIntColumn _cess;
  @override
  GeneratedIntColumn get cess => _cess ??= _constructCess();
  GeneratedIntColumn _constructCess() {
    return GeneratedIntColumn(
      'cess',
      $tableName,
      true,
    );
  }

  final VerificationMeta _merchantIdMeta = const VerificationMeta('merchantId');
  GeneratedTextColumn _merchantId;
  @override
  GeneratedTextColumn get merchantId => _merchantId ??= _constructMerchantId();
  GeneratedTextColumn _constructMerchantId() {
    return GeneratedTextColumn(
      'merchant_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedTextColumn _productId;
  @override
  GeneratedTextColumn get productId => _productId ??= _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn(
      'product_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _storeIdMeta = const VerificationMeta('storeId');
  GeneratedTextColumn _storeId;
  @override
  GeneratedTextColumn get storeId => _storeId ??= _constructStoreId();
  GeneratedTextColumn _constructStoreId() {
    return GeneratedTextColumn(
      'store_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        price,
        barcode,
        sku,
        attributes,
        inventory,
        mrp,
        threshold,
        gst,
        vat,
        cess,
        merchantId,
        productId,
        storeId,
        status,
        createdAt,
        updatedAt
      ];
  @override
  $VariantsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'variants';
  @override
  final String actualTableName = 'variants';
  @override
  VerificationContext validateIntegrity(VariantsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.price.present) {
      context.handle(
          _priceMeta, price.isAcceptableValue(d.price.value, _priceMeta));
    } else if (price.isRequired && isInserting) {
      context.missing(_priceMeta);
    }
    if (d.barcode.present) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableValue(d.barcode.value, _barcodeMeta));
    } else if (barcode.isRequired && isInserting) {
      context.missing(_barcodeMeta);
    }
    if (d.sku.present) {
      context.handle(_skuMeta, sku.isAcceptableValue(d.sku.value, _skuMeta));
    } else if (sku.isRequired && isInserting) {
      context.missing(_skuMeta);
    }
    if (d.attributes.present) {
      context.handle(_attributesMeta,
          attributes.isAcceptableValue(d.attributes.value, _attributesMeta));
    } else if (attributes.isRequired && isInserting) {
      context.missing(_attributesMeta);
    }
    if (d.inventory.present) {
      context.handle(_inventoryMeta,
          inventory.isAcceptableValue(d.inventory.value, _inventoryMeta));
    } else if (inventory.isRequired && isInserting) {
      context.missing(_inventoryMeta);
    }
    if (d.mrp.present) {
      context.handle(_mrpMeta, mrp.isAcceptableValue(d.mrp.value, _mrpMeta));
    } else if (mrp.isRequired && isInserting) {
      context.missing(_mrpMeta);
    }
    if (d.threshold.present) {
      context.handle(_thresholdMeta,
          threshold.isAcceptableValue(d.threshold.value, _thresholdMeta));
    } else if (threshold.isRequired && isInserting) {
      context.missing(_thresholdMeta);
    }
    if (d.gst.present) {
      context.handle(_gstMeta, gst.isAcceptableValue(d.gst.value, _gstMeta));
    } else if (gst.isRequired && isInserting) {
      context.missing(_gstMeta);
    }
    if (d.vat.present) {
      context.handle(_vatMeta, vat.isAcceptableValue(d.vat.value, _vatMeta));
    } else if (vat.isRequired && isInserting) {
      context.missing(_vatMeta);
    }
    if (d.cess.present) {
      context.handle(
          _cessMeta, cess.isAcceptableValue(d.cess.value, _cessMeta));
    } else if (cess.isRequired && isInserting) {
      context.missing(_cessMeta);
    }
    if (d.merchantId.present) {
      context.handle(_merchantIdMeta,
          merchantId.isAcceptableValue(d.merchantId.value, _merchantIdMeta));
    } else if (merchantId.isRequired && isInserting) {
      context.missing(_merchantIdMeta);
    }
    if (d.productId.present) {
      context.handle(_productIdMeta,
          productId.isAcceptableValue(d.productId.value, _productIdMeta));
    } else if (productId.isRequired && isInserting) {
      context.missing(_productIdMeta);
    }
    if (d.storeId.present) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableValue(d.storeId.value, _storeIdMeta));
    } else if (storeId.isRequired && isInserting) {
      context.missing(_storeIdMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Variant map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Variant.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(VariantsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.price.present) {
      map['price'] = Variable<double, RealType>(d.price.value);
    }
    if (d.barcode.present) {
      map['barcode'] = Variable<String, StringType>(d.barcode.value);
    }
    if (d.sku.present) {
      map['sku'] = Variable<String, StringType>(d.sku.value);
    }
    if (d.attributes.present) {
      map['attributes'] = Variable<String, StringType>(d.attributes.value);
    }
    if (d.inventory.present) {
      map['inventory'] = Variable<int, IntType>(d.inventory.value);
    }
    if (d.mrp.present) {
      map['mrp'] = Variable<int, IntType>(d.mrp.value);
    }
    if (d.threshold.present) {
      map['threshold'] = Variable<int, IntType>(d.threshold.value);
    }
    if (d.gst.present) {
      map['gst'] = Variable<int, IntType>(d.gst.value);
    }
    if (d.vat.present) {
      map['vat'] = Variable<int, IntType>(d.vat.value);
    }
    if (d.cess.present) {
      map['cess'] = Variable<int, IntType>(d.cess.value);
    }
    if (d.merchantId.present) {
      map['merchant_id'] = Variable<String, StringType>(d.merchantId.value);
    }
    if (d.productId.present) {
      map['product_id'] = Variable<String, StringType>(d.productId.value);
    }
    if (d.storeId.present) {
      map['store_id'] = Variable<String, StringType>(d.storeId.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $VariantsTable createAlias(String alias) {
    return $VariantsTable(_db, alias);
  }
}

class Currency extends DataClass implements Insertable<Currency> {
  final String id;
  final String name;
  final String code;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  Currency(
      {@required this.id,
      @required this.name,
      @required this.code,
      @required this.status,
      this.createdAt,
      this.updatedAt});
  factory Currency.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Currency(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      code: stringType.mapFromDatabaseResponse(data['${effectivePrefix}code']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory Currency.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Currency(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Currency>>(bool nullToAbsent) {
    return CurrencysCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  Currency copyWith(
          {String id,
          String name,
          String code,
          int status,
          DateTime createdAt,
          DateTime updatedAt}) =>
      Currency(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Currency(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              code.hashCode,
              $mrjc(status.hashCode,
                  $mrjc(createdAt.hashCode, updatedAt.hashCode))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Currency &&
          other.id == id &&
          other.name == name &&
          other.code == code &&
          other.status == status &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class CurrencysCompanion extends UpdateCompanion<Currency> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> code;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CurrencysCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CurrencysCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> code,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return CurrencysCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $CurrencysTable extends Currencys
    with TableInfo<$CurrencysTable, Currency> {
  final GeneratedDatabase _db;
  final String _alias;
  $CurrencysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _codeMeta = const VerificationMeta('code');
  GeneratedTextColumn _code;
  @override
  GeneratedTextColumn get code => _code ??= _constructCode();
  GeneratedTextColumn _constructCode() {
    return GeneratedTextColumn(
      'code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, code, status, createdAt, updatedAt];
  @override
  $CurrencysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'currencys';
  @override
  final String actualTableName = 'currencys';
  @override
  VerificationContext validateIntegrity(CurrencysCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.code.present) {
      context.handle(
          _codeMeta, code.isAcceptableValue(d.code.value, _codeMeta));
    } else if (code.isRequired && isInserting) {
      context.missing(_codeMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Currency map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Currency.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CurrencysCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.code.present) {
      map['code'] = Variable<String, StringType>(d.code.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $CurrencysTable createAlias(String alias) {
    return $CurrencysTable(_db, alias);
  }
}

class TransactionType extends DataClass implements Insertable<TransactionType> {
  final String id;
  final String name;
  final String parentId;
  final String displayName;
  final double providerCommision;
  final double epaisaCommision;
  final double serviceTax;
  final double mdr;
  final String credentials;
  final String extraFields;
  final DateTime createdAt;
  final DateTime updatedAt;
  TransactionType(
      {@required this.id,
      @required this.name,
      this.parentId,
      @required this.displayName,
      this.providerCommision,
      this.epaisaCommision,
      this.serviceTax,
      this.mdr,
      this.credentials,
      this.extraFields,
      this.createdAt,
      this.updatedAt});
  factory TransactionType.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TransactionType(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      parentId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_id']),
      displayName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name']),
      providerCommision: doubleType.mapFromDatabaseResponse(
          data['${effectivePrefix}provider_commision']),
      epaisaCommision: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}epaisa_commision']),
      serviceTax: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}service_tax']),
      mdr: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}mdr']),
      credentials: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}credentials']),
      extraFields: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}extra_fields']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  factory TransactionType.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TransactionType(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentId: serializer.fromJson<String>(json['parentId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      providerCommision: serializer.fromJson<double>(json['providerCommision']),
      epaisaCommision: serializer.fromJson<double>(json['epaisaCommision']),
      serviceTax: serializer.fromJson<double>(json['serviceTax']),
      mdr: serializer.fromJson<double>(json['mdr']),
      credentials: serializer.fromJson<String>(json['credentials']),
      extraFields: serializer.fromJson<String>(json['extraFields']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'parentId': serializer.toJson<String>(parentId),
      'displayName': serializer.toJson<String>(displayName),
      'providerCommision': serializer.toJson<double>(providerCommision),
      'epaisaCommision': serializer.toJson<double>(epaisaCommision),
      'serviceTax': serializer.toJson<double>(serviceTax),
      'mdr': serializer.toJson<double>(mdr),
      'credentials': serializer.toJson<String>(credentials),
      'extraFields': serializer.toJson<String>(extraFields),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<TransactionType>>(
      bool nullToAbsent) {
    return TransactionTypesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      providerCommision: providerCommision == null && nullToAbsent
          ? const Value.absent()
          : Value(providerCommision),
      epaisaCommision: epaisaCommision == null && nullToAbsent
          ? const Value.absent()
          : Value(epaisaCommision),
      serviceTax: serviceTax == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceTax),
      mdr: mdr == null && nullToAbsent ? const Value.absent() : Value(mdr),
      credentials: credentials == null && nullToAbsent
          ? const Value.absent()
          : Value(credentials),
      extraFields: extraFields == null && nullToAbsent
          ? const Value.absent()
          : Value(extraFields),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    ) as T;
  }

  TransactionType copyWith(
          {String id,
          String name,
          String parentId,
          String displayName,
          double providerCommision,
          double epaisaCommision,
          double serviceTax,
          double mdr,
          String credentials,
          String extraFields,
          DateTime createdAt,
          DateTime updatedAt}) =>
      TransactionType(
        id: id ?? this.id,
        name: name ?? this.name,
        parentId: parentId ?? this.parentId,
        displayName: displayName ?? this.displayName,
        providerCommision: providerCommision ?? this.providerCommision,
        epaisaCommision: epaisaCommision ?? this.epaisaCommision,
        serviceTax: serviceTax ?? this.serviceTax,
        mdr: mdr ?? this.mdr,
        credentials: credentials ?? this.credentials,
        extraFields: extraFields ?? this.extraFields,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId, ')
          ..write('displayName: $displayName, ')
          ..write('providerCommision: $providerCommision, ')
          ..write('epaisaCommision: $epaisaCommision, ')
          ..write('serviceTax: $serviceTax, ')
          ..write('mdr: $mdr, ')
          ..write('credentials: $credentials, ')
          ..write('extraFields: $extraFields, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              parentId.hashCode,
              $mrjc(
                  displayName.hashCode,
                  $mrjc(
                      providerCommision.hashCode,
                      $mrjc(
                          epaisaCommision.hashCode,
                          $mrjc(
                              serviceTax.hashCode,
                              $mrjc(
                                  mdr.hashCode,
                                  $mrjc(
                                      credentials.hashCode,
                                      $mrjc(
                                          extraFields.hashCode,
                                          $mrjc(createdAt.hashCode,
                                              updatedAt.hashCode))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is TransactionType &&
          other.id == id &&
          other.name == name &&
          other.parentId == parentId &&
          other.displayName == displayName &&
          other.providerCommision == providerCommision &&
          other.epaisaCommision == epaisaCommision &&
          other.serviceTax == serviceTax &&
          other.mdr == mdr &&
          other.credentials == credentials &&
          other.extraFields == extraFields &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt);
}

class TransactionTypesCompanion extends UpdateCompanion<TransactionType> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> parentId;
  final Value<String> displayName;
  final Value<double> providerCommision;
  final Value<double> epaisaCommision;
  final Value<double> serviceTax;
  final Value<double> mdr;
  final Value<String> credentials;
  final Value<String> extraFields;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TransactionTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.providerCommision = const Value.absent(),
    this.epaisaCommision = const Value.absent(),
    this.serviceTax = const Value.absent(),
    this.mdr = const Value.absent(),
    this.credentials = const Value.absent(),
    this.extraFields = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TransactionTypesCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> parentId,
      Value<String> displayName,
      Value<double> providerCommision,
      Value<double> epaisaCommision,
      Value<double> serviceTax,
      Value<double> mdr,
      Value<String> credentials,
      Value<String> extraFields,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return TransactionTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      displayName: displayName ?? this.displayName,
      providerCommision: providerCommision ?? this.providerCommision,
      epaisaCommision: epaisaCommision ?? this.epaisaCommision,
      serviceTax: serviceTax ?? this.serviceTax,
      mdr: mdr ?? this.mdr,
      credentials: credentials ?? this.credentials,
      extraFields: extraFields ?? this.extraFields,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class $TransactionTypesTable extends TransactionTypes
    with TableInfo<$TransactionTypesTable, TransactionType> {
  final GeneratedDatabase _db;
  final String _alias;
  $TransactionTypesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  GeneratedTextColumn _parentId;
  @override
  GeneratedTextColumn get parentId => _parentId ??= _constructParentId();
  GeneratedTextColumn _constructParentId() {
    return GeneratedTextColumn(
      'parent_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  GeneratedTextColumn _displayName;
  @override
  GeneratedTextColumn get displayName =>
      _displayName ??= _constructDisplayName();
  GeneratedTextColumn _constructDisplayName() {
    return GeneratedTextColumn(
      'display_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _providerCommisionMeta =
      const VerificationMeta('providerCommision');
  GeneratedRealColumn _providerCommision;
  @override
  GeneratedRealColumn get providerCommision =>
      _providerCommision ??= _constructProviderCommision();
  GeneratedRealColumn _constructProviderCommision() {
    return GeneratedRealColumn(
      'provider_commision',
      $tableName,
      true,
    );
  }

  final VerificationMeta _epaisaCommisionMeta =
      const VerificationMeta('epaisaCommision');
  GeneratedRealColumn _epaisaCommision;
  @override
  GeneratedRealColumn get epaisaCommision =>
      _epaisaCommision ??= _constructEpaisaCommision();
  GeneratedRealColumn _constructEpaisaCommision() {
    return GeneratedRealColumn(
      'epaisa_commision',
      $tableName,
      true,
    );
  }

  final VerificationMeta _serviceTaxMeta = const VerificationMeta('serviceTax');
  GeneratedRealColumn _serviceTax;
  @override
  GeneratedRealColumn get serviceTax => _serviceTax ??= _constructServiceTax();
  GeneratedRealColumn _constructServiceTax() {
    return GeneratedRealColumn(
      'service_tax',
      $tableName,
      true,
    );
  }

  final VerificationMeta _mdrMeta = const VerificationMeta('mdr');
  GeneratedRealColumn _mdr;
  @override
  GeneratedRealColumn get mdr => _mdr ??= _constructMdr();
  GeneratedRealColumn _constructMdr() {
    return GeneratedRealColumn(
      'mdr',
      $tableName,
      true,
    );
  }

  final VerificationMeta _credentialsMeta =
      const VerificationMeta('credentials');
  GeneratedTextColumn _credentials;
  @override
  GeneratedTextColumn get credentials =>
      _credentials ??= _constructCredentials();
  GeneratedTextColumn _constructCredentials() {
    return GeneratedTextColumn(
      'credentials',
      $tableName,
      true,
    );
  }

  final VerificationMeta _extraFieldsMeta =
      const VerificationMeta('extraFields');
  GeneratedTextColumn _extraFields;
  @override
  GeneratedTextColumn get extraFields =>
      _extraFields ??= _constructExtraFields();
  GeneratedTextColumn _constructExtraFields() {
    return GeneratedTextColumn(
      'extra_fields',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        parentId,
        displayName,
        providerCommision,
        epaisaCommision,
        serviceTax,
        mdr,
        credentials,
        extraFields,
        createdAt,
        updatedAt
      ];
  @override
  $TransactionTypesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'transaction_types';
  @override
  final String actualTableName = 'transaction_types';
  @override
  VerificationContext validateIntegrity(TransactionTypesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.parentId.present) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableValue(d.parentId.value, _parentIdMeta));
    } else if (parentId.isRequired && isInserting) {
      context.missing(_parentIdMeta);
    }
    if (d.displayName.present) {
      context.handle(_displayNameMeta,
          displayName.isAcceptableValue(d.displayName.value, _displayNameMeta));
    } else if (displayName.isRequired && isInserting) {
      context.missing(_displayNameMeta);
    }
    if (d.providerCommision.present) {
      context.handle(
          _providerCommisionMeta,
          providerCommision.isAcceptableValue(
              d.providerCommision.value, _providerCommisionMeta));
    } else if (providerCommision.isRequired && isInserting) {
      context.missing(_providerCommisionMeta);
    }
    if (d.epaisaCommision.present) {
      context.handle(
          _epaisaCommisionMeta,
          epaisaCommision.isAcceptableValue(
              d.epaisaCommision.value, _epaisaCommisionMeta));
    } else if (epaisaCommision.isRequired && isInserting) {
      context.missing(_epaisaCommisionMeta);
    }
    if (d.serviceTax.present) {
      context.handle(_serviceTaxMeta,
          serviceTax.isAcceptableValue(d.serviceTax.value, _serviceTaxMeta));
    } else if (serviceTax.isRequired && isInserting) {
      context.missing(_serviceTaxMeta);
    }
    if (d.mdr.present) {
      context.handle(_mdrMeta, mdr.isAcceptableValue(d.mdr.value, _mdrMeta));
    } else if (mdr.isRequired && isInserting) {
      context.missing(_mdrMeta);
    }
    if (d.credentials.present) {
      context.handle(_credentialsMeta,
          credentials.isAcceptableValue(d.credentials.value, _credentialsMeta));
    } else if (credentials.isRequired && isInserting) {
      context.missing(_credentialsMeta);
    }
    if (d.extraFields.present) {
      context.handle(_extraFieldsMeta,
          extraFields.isAcceptableValue(d.extraFields.value, _extraFieldsMeta));
    } else if (extraFields.isRequired && isInserting) {
      context.missing(_extraFieldsMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updatedAt.present) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableValue(d.updatedAt.value, _updatedAtMeta));
    } else if (updatedAt.isRequired && isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionType map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TransactionType.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TransactionTypesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.parentId.present) {
      map['parent_id'] = Variable<String, StringType>(d.parentId.value);
    }
    if (d.displayName.present) {
      map['display_name'] = Variable<String, StringType>(d.displayName.value);
    }
    if (d.providerCommision.present) {
      map['provider_commision'] =
          Variable<double, RealType>(d.providerCommision.value);
    }
    if (d.epaisaCommision.present) {
      map['epaisa_commision'] =
          Variable<double, RealType>(d.epaisaCommision.value);
    }
    if (d.serviceTax.present) {
      map['service_tax'] = Variable<double, RealType>(d.serviceTax.value);
    }
    if (d.mdr.present) {
      map['mdr'] = Variable<double, RealType>(d.mdr.value);
    }
    if (d.credentials.present) {
      map['credentials'] = Variable<String, StringType>(d.credentials.value);
    }
    if (d.extraFields.present) {
      map['extra_fields'] = Variable<String, StringType>(d.extraFields.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updatedAt.present) {
      map['updated_at'] = Variable<DateTime, DateTimeType>(d.updatedAt.value);
    }
    return map;
  }

  @override
  $TransactionTypesTable createAlias(String alias) {
    return $TransactionTypesTable(_db, alias);
  }
}

class ProductAttribute extends DataClass
    implements Insertable<ProductAttribute> {
  final String id;
  final String name;
  final bool isRequired;
  final bool isVariant;
  final int position;
  final String type;
  final String industryId;
  final int status;
  ProductAttribute(
      {@required this.id,
      @required this.name,
      this.isRequired,
      this.isVariant,
      this.position,
      this.type,
      this.industryId,
      this.status});
  factory ProductAttribute.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final intType = db.typeSystem.forDartType<int>();
    return ProductAttribute(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      isRequired: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_required']),
      isVariant: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_variant']),
      position:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}position']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      industryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}industry_id']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
    );
  }
  factory ProductAttribute.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return ProductAttribute(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
      isVariant: serializer.fromJson<bool>(json['isVariant']),
      position: serializer.fromJson<int>(json['position']),
      type: serializer.fromJson<String>(json['type']),
      industryId: serializer.fromJson<String>(json['industryId']),
      status: serializer.fromJson<int>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'isRequired': serializer.toJson<bool>(isRequired),
      'isVariant': serializer.toJson<bool>(isVariant),
      'position': serializer.toJson<int>(position),
      'type': serializer.toJson<String>(type),
      'industryId': serializer.toJson<String>(industryId),
      'status': serializer.toJson<int>(status),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<ProductAttribute>>(
      bool nullToAbsent) {
    return ProductAttributesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      isRequired: isRequired == null && nullToAbsent
          ? const Value.absent()
          : Value(isRequired),
      isVariant: isVariant == null && nullToAbsent
          ? const Value.absent()
          : Value(isVariant),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      industryId: industryId == null && nullToAbsent
          ? const Value.absent()
          : Value(industryId),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    ) as T;
  }

  ProductAttribute copyWith(
          {String id,
          String name,
          bool isRequired,
          bool isVariant,
          int position,
          String type,
          String industryId,
          int status}) =>
      ProductAttribute(
        id: id ?? this.id,
        name: name ?? this.name,
        isRequired: isRequired ?? this.isRequired,
        isVariant: isVariant ?? this.isVariant,
        position: position ?? this.position,
        type: type ?? this.type,
        industryId: industryId ?? this.industryId,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('ProductAttribute(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isRequired: $isRequired, ')
          ..write('isVariant: $isVariant, ')
          ..write('position: $position, ')
          ..write('type: $type, ')
          ..write('industryId: $industryId, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              isRequired.hashCode,
              $mrjc(
                  isVariant.hashCode,
                  $mrjc(
                      position.hashCode,
                      $mrjc(type.hashCode,
                          $mrjc(industryId.hashCode, status.hashCode))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is ProductAttribute &&
          other.id == id &&
          other.name == name &&
          other.isRequired == isRequired &&
          other.isVariant == isVariant &&
          other.position == position &&
          other.type == type &&
          other.industryId == industryId &&
          other.status == status);
}

class ProductAttributesCompanion extends UpdateCompanion<ProductAttribute> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> isRequired;
  final Value<bool> isVariant;
  final Value<int> position;
  final Value<String> type;
  final Value<String> industryId;
  final Value<int> status;
  const ProductAttributesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.isVariant = const Value.absent(),
    this.position = const Value.absent(),
    this.type = const Value.absent(),
    this.industryId = const Value.absent(),
    this.status = const Value.absent(),
  });
  ProductAttributesCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<bool> isRequired,
      Value<bool> isVariant,
      Value<int> position,
      Value<String> type,
      Value<String> industryId,
      Value<int> status}) {
    return ProductAttributesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isRequired: isRequired ?? this.isRequired,
      isVariant: isVariant ?? this.isVariant,
      position: position ?? this.position,
      type: type ?? this.type,
      industryId: industryId ?? this.industryId,
      status: status ?? this.status,
    );
  }
}

class $ProductAttributesTable extends ProductAttributes
    with TableInfo<$ProductAttributesTable, ProductAttribute> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductAttributesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isRequiredMeta = const VerificationMeta('isRequired');
  GeneratedBoolColumn _isRequired;
  @override
  GeneratedBoolColumn get isRequired => _isRequired ??= _constructIsRequired();
  GeneratedBoolColumn _constructIsRequired() {
    return GeneratedBoolColumn(
      'is_required',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isVariantMeta = const VerificationMeta('isVariant');
  GeneratedBoolColumn _isVariant;
  @override
  GeneratedBoolColumn get isVariant => _isVariant ??= _constructIsVariant();
  GeneratedBoolColumn _constructIsVariant() {
    return GeneratedBoolColumn(
      'is_variant',
      $tableName,
      true,
    );
  }

  final VerificationMeta _positionMeta = const VerificationMeta('position');
  GeneratedIntColumn _position;
  @override
  GeneratedIntColumn get position => _position ??= _constructPosition();
  GeneratedIntColumn _constructPosition() {
    return GeneratedIntColumn(
      'position',
      $tableName,
      true,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _industryIdMeta = const VerificationMeta('industryId');
  GeneratedTextColumn _industryId;
  @override
  GeneratedTextColumn get industryId => _industryId ??= _constructIndustryId();
  GeneratedTextColumn _constructIndustryId() {
    return GeneratedTextColumn(
      'industry_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, isRequired, isVariant, position, type, industryId, status];
  @override
  $ProductAttributesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_attributes';
  @override
  final String actualTableName = 'product_attributes';
  @override
  VerificationContext validateIntegrity(ProductAttributesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.isRequired.present) {
      context.handle(_isRequiredMeta,
          isRequired.isAcceptableValue(d.isRequired.value, _isRequiredMeta));
    } else if (isRequired.isRequired && isInserting) {
      context.missing(_isRequiredMeta);
    }
    if (d.isVariant.present) {
      context.handle(_isVariantMeta,
          isVariant.isAcceptableValue(d.isVariant.value, _isVariantMeta));
    } else if (isVariant.isRequired && isInserting) {
      context.missing(_isVariantMeta);
    }
    if (d.position.present) {
      context.handle(_positionMeta,
          position.isAcceptableValue(d.position.value, _positionMeta));
    } else if (position.isRequired && isInserting) {
      context.missing(_positionMeta);
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    } else if (type.isRequired && isInserting) {
      context.missing(_typeMeta);
    }
    if (d.industryId.present) {
      context.handle(_industryIdMeta,
          industryId.isAcceptableValue(d.industryId.value, _industryIdMeta));
    } else if (industryId.isRequired && isInserting) {
      context.missing(_industryIdMeta);
    }
    if (d.status.present) {
      context.handle(
          _statusMeta, status.isAcceptableValue(d.status.value, _statusMeta));
    } else if (status.isRequired && isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductAttribute map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductAttribute.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProductAttributesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.isRequired.present) {
      map['is_required'] = Variable<bool, BoolType>(d.isRequired.value);
    }
    if (d.isVariant.present) {
      map['is_variant'] = Variable<bool, BoolType>(d.isVariant.value);
    }
    if (d.position.present) {
      map['position'] = Variable<int, IntType>(d.position.value);
    }
    if (d.type.present) {
      map['type'] = Variable<String, StringType>(d.type.value);
    }
    if (d.industryId.present) {
      map['industry_id'] = Variable<String, StringType>(d.industryId.value);
    }
    if (d.status.present) {
      map['status'] = Variable<int, IntType>(d.status.value);
    }
    return map;
  }

  @override
  $ProductAttributesTable createAlias(String alias) {
    return $ProductAttributesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $CountryTable _country;
  $CountryTable get country => _country ??= $CountryTable(this);
  $UnitsTable _units;
  $UnitsTable get units => _units ??= $UnitsTable(this);
  $AreasTable _areas;
  $AreasTable get areas => _areas ??= $AreasTable(this);
  $CityTable _city;
  $CityTable get city => _city ??= $CityTable(this);
  $CountryStatesTable _countryStates;
  $CountryStatesTable get countryStates =>
      _countryStates ??= $CountryStatesTable(this);
  $IndustryTable _industry;
  $IndustryTable get industry => _industry ??= $IndustryTable(this);
  $BusinessTypeTable _businessType;
  $BusinessTypeTable get businessType =>
      _businessType ??= $BusinessTypeTable(this);
  $TaxsTable _taxs;
  $TaxsTable get taxs => _taxs ??= $TaxsTable(this);
  $StoresTable _stores;
  $StoresTable get stores => _stores ??= $StoresTable(this);
  $CompanyTable _company;
  $CompanyTable get company => _company ??= $CompanyTable(this);
  $MerchantsTable _merchants;
  $MerchantsTable get merchants => _merchants ??= $MerchantsTable(this);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $AuthenticatedUsersTable _authenticatedUsers;
  $AuthenticatedUsersTable get authenticatedUsers =>
      _authenticatedUsers ??= $AuthenticatedUsersTable(this);
  $CurrentMerchantsTable _currentMerchants;
  $CurrentMerchantsTable get currentMerchants =>
      _currentMerchants ??= $CurrentMerchantsTable(this);
  $CurrentCompanysTable _currentCompanys;
  $CurrentCompanysTable get currentCompanys =>
      _currentCompanys ??= $CurrentCompanysTable(this);
  $CurrentStoresTable _currentStores;
  $CurrentStoresTable get currentStores =>
      _currentStores ??= $CurrentStoresTable(this);
  $CurrentUsersTable _currentUsers;
  $CurrentUsersTable get currentUsers =>
      _currentUsers ??= $CurrentUsersTable(this);
  $DistributorsTable _distributors;
  $DistributorsTable get distributors =>
      _distributors ??= $DistributorsTable(this);
  $ManufacturersTable _manufacturers;
  $ManufacturersTable get manufacturers =>
      _manufacturers ??= $ManufacturersTable(this);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  $ProductsTable _products;
  $ProductsTable get products => _products ??= $ProductsTable(this);
  $FingerprintUserTable _fingerprintUser;
  $FingerprintUserTable get fingerprintUser =>
      _fingerprintUser ??= $FingerprintUserTable(this);
  $PackagesTable _packages;
  $PackagesTable get packages => _packages ??= $PackagesTable(this);
  $VariantsTable _variants;
  $VariantsTable get variants => _variants ??= $VariantsTable(this);
  $CurrencysTable _currencys;
  $CurrencysTable get currencys => _currencys ??= $CurrencysTable(this);
  $TransactionTypesTable _transactionTypes;
  $TransactionTypesTable get transactionTypes =>
      _transactionTypes ??= $TransactionTypesTable(this);
  $ProductAttributesTable _productAttributes;
  $ProductAttributesTable get productAttributes =>
      _productAttributes ??= $ProductAttributesTable(this);
  @override
  List<TableInfo> get allTables => [
        country,
        units,
        areas,
        city,
        countryStates,
        industry,
        businessType,
        taxs,
        stores,
        company,
        merchants,
        users,
        authenticatedUsers,
        currentMerchants,
        currentCompanys,
        currentStores,
        currentUsers,
        distributors,
        manufacturers,
        categories,
        products,
        fingerprintUser,
        packages,
        variants,
        currencys,
        transactionTypes,
        productAttributes
      ];
}

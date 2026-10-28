// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LoopsTable extends Loops with TableInfo<$LoopsTable, Loop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _behaviorMeta = const VerificationMeta(
    'behavior',
  );
  @override
  late final GeneratedColumn<String> behavior = GeneratedColumn<String>(
    'behavior',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggerMeta = const VerificationMeta(
    'trigger',
  );
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
    'trigger',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _rewardGuessMeta = const VerificationMeta(
    'rewardGuess',
  );
  @override
  late final GeneratedColumn<String> rewardGuess = GeneratedColumn<String>(
    'reward_guess',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isFocusMeta = const VerificationMeta(
    'isFocus',
  );
  @override
  late final GeneratedColumn<bool> isFocus = GeneratedColumn<bool>(
    'is_focus',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_focus" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorKeyMeta = const VerificationMeta(
    'colorKey',
  );
  @override
  late final GeneratedColumn<String> colorKey = GeneratedColumn<String>(
    'color_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('warm'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    behavior,
    trigger,
    rewardGuess,
    isFocus,
    createdAt,
    archivedAt,
    colorKey,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loops';
  @override
  VerificationContext validateIntegrity(
    Insertable<Loop> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('behavior')) {
      context.handle(
        _behaviorMeta,
        behavior.isAcceptableOrUnknown(data['behavior']!, _behaviorMeta),
      );
    } else if (isInserting) {
      context.missing(_behaviorMeta);
    }
    if (data.containsKey('trigger')) {
      context.handle(
        _triggerMeta,
        trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta),
      );
    }
    if (data.containsKey('reward_guess')) {
      context.handle(
        _rewardGuessMeta,
        rewardGuess.isAcceptableOrUnknown(
          data['reward_guess']!,
          _rewardGuessMeta,
        ),
      );
    }
    if (data.containsKey('is_focus')) {
      context.handle(
        _isFocusMeta,
        isFocus.isAcceptableOrUnknown(data['is_focus']!, _isFocusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('color_key')) {
      context.handle(
        _colorKeyMeta,
        colorKey.isAcceptableOrUnknown(data['color_key']!, _colorKeyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Loop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Loop(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      behavior: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}behavior'],
      )!,
      trigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger'],
      )!,
      rewardGuess: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reward_guess'],
      )!,
      isFocus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_focus'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      colorKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_key'],
      )!,
    );
  }

  @override
  $LoopsTable createAlias(String alias) {
    return $LoopsTable(attachedDatabase, alias);
  }
}

class Loop extends DataClass implements Insertable<Loop> {
  final String id;
  final String behavior;
  final String trigger;
  final String rewardGuess;
  final bool isFocus;
  final DateTime createdAt;
  final DateTime? archivedAt;
  final String colorKey;
  const Loop({
    required this.id,
    required this.behavior,
    required this.trigger,
    required this.rewardGuess,
    required this.isFocus,
    required this.createdAt,
    this.archivedAt,
    required this.colorKey,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['behavior'] = Variable<String>(behavior);
    map['trigger'] = Variable<String>(trigger);
    map['reward_guess'] = Variable<String>(rewardGuess);
    map['is_focus'] = Variable<bool>(isFocus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['color_key'] = Variable<String>(colorKey);
    return map;
  }

  LoopsCompanion toCompanion(bool nullToAbsent) {
    return LoopsCompanion(
      id: Value(id),
      behavior: Value(behavior),
      trigger: Value(trigger),
      rewardGuess: Value(rewardGuess),
      isFocus: Value(isFocus),
      createdAt: Value(createdAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      colorKey: Value(colorKey),
    );
  }

  factory Loop.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Loop(
      id: serializer.fromJson<String>(json['id']),
      behavior: serializer.fromJson<String>(json['behavior']),
      trigger: serializer.fromJson<String>(json['trigger']),
      rewardGuess: serializer.fromJson<String>(json['rewardGuess']),
      isFocus: serializer.fromJson<bool>(json['isFocus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      colorKey: serializer.fromJson<String>(json['colorKey']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'behavior': serializer.toJson<String>(behavior),
      'trigger': serializer.toJson<String>(trigger),
      'rewardGuess': serializer.toJson<String>(rewardGuess),
      'isFocus': serializer.toJson<bool>(isFocus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'colorKey': serializer.toJson<String>(colorKey),
    };
  }

  Loop copyWith({
    String? id,
    String? behavior,
    String? trigger,
    String? rewardGuess,
    bool? isFocus,
    DateTime? createdAt,
    Value<DateTime?> archivedAt = const Value.absent(),
    String? colorKey,
  }) => Loop(
    id: id ?? this.id,
    behavior: behavior ?? this.behavior,
    trigger: trigger ?? this.trigger,
    rewardGuess: rewardGuess ?? this.rewardGuess,
    isFocus: isFocus ?? this.isFocus,
    createdAt: createdAt ?? this.createdAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    colorKey: colorKey ?? this.colorKey,
  );
  Loop copyWithCompanion(LoopsCompanion data) {
    return Loop(
      id: data.id.present ? data.id.value : this.id,
      behavior: data.behavior.present ? data.behavior.value : this.behavior,
      trigger: data.trigger.present ? data.trigger.value : this.trigger,
      rewardGuess: data.rewardGuess.present
          ? data.rewardGuess.value
          : this.rewardGuess,
      isFocus: data.isFocus.present ? data.isFocus.value : this.isFocus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      colorKey: data.colorKey.present ? data.colorKey.value : this.colorKey,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Loop(')
          ..write('id: $id, ')
          ..write('behavior: $behavior, ')
          ..write('trigger: $trigger, ')
          ..write('rewardGuess: $rewardGuess, ')
          ..write('isFocus: $isFocus, ')
          ..write('createdAt: $createdAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('colorKey: $colorKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    behavior,
    trigger,
    rewardGuess,
    isFocus,
    createdAt,
    archivedAt,
    colorKey,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Loop &&
          other.id == this.id &&
          other.behavior == this.behavior &&
          other.trigger == this.trigger &&
          other.rewardGuess == this.rewardGuess &&
          other.isFocus == this.isFocus &&
          other.createdAt == this.createdAt &&
          other.archivedAt == this.archivedAt &&
          other.colorKey == this.colorKey);
}

class LoopsCompanion extends UpdateCompanion<Loop> {
  final Value<String> id;
  final Value<String> behavior;
  final Value<String> trigger;
  final Value<String> rewardGuess;
  final Value<bool> isFocus;
  final Value<DateTime> createdAt;
  final Value<DateTime?> archivedAt;
  final Value<String> colorKey;
  final Value<int> rowid;
  const LoopsCompanion({
    this.id = const Value.absent(),
    this.behavior = const Value.absent(),
    this.trigger = const Value.absent(),
    this.rewardGuess = const Value.absent(),
    this.isFocus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.colorKey = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LoopsCompanion.insert({
    required String id,
    required String behavior,
    this.trigger = const Value.absent(),
    this.rewardGuess = const Value.absent(),
    this.isFocus = const Value.absent(),
    required DateTime createdAt,
    this.archivedAt = const Value.absent(),
    this.colorKey = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       behavior = Value(behavior),
       createdAt = Value(createdAt);
  static Insertable<Loop> custom({
    Expression<String>? id,
    Expression<String>? behavior,
    Expression<String>? trigger,
    Expression<String>? rewardGuess,
    Expression<bool>? isFocus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? archivedAt,
    Expression<String>? colorKey,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (behavior != null) 'behavior': behavior,
      if (trigger != null) 'trigger': trigger,
      if (rewardGuess != null) 'reward_guess': rewardGuess,
      if (isFocus != null) 'is_focus': isFocus,
      if (createdAt != null) 'created_at': createdAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (colorKey != null) 'color_key': colorKey,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LoopsCompanion copyWith({
    Value<String>? id,
    Value<String>? behavior,
    Value<String>? trigger,
    Value<String>? rewardGuess,
    Value<bool>? isFocus,
    Value<DateTime>? createdAt,
    Value<DateTime?>? archivedAt,
    Value<String>? colorKey,
    Value<int>? rowid,
  }) {
    return LoopsCompanion(
      id: id ?? this.id,
      behavior: behavior ?? this.behavior,
      trigger: trigger ?? this.trigger,
      rewardGuess: rewardGuess ?? this.rewardGuess,
      isFocus: isFocus ?? this.isFocus,
      createdAt: createdAt ?? this.createdAt,
      archivedAt: archivedAt ?? this.archivedAt,
      colorKey: colorKey ?? this.colorKey,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (behavior.present) {
      map['behavior'] = Variable<String>(behavior.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (rewardGuess.present) {
      map['reward_guess'] = Variable<String>(rewardGuess.value);
    }
    if (isFocus.present) {
      map['is_focus'] = Variable<bool>(isFocus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (colorKey.present) {
      map['color_key'] = Variable<String>(colorKey.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoopsCompanion(')
          ..write('id: $id, ')
          ..write('behavior: $behavior, ')
          ..write('trigger: $trigger, ')
          ..write('rewardGuess: $rewardGuess, ')
          ..write('isFocus: $isFocus, ')
          ..write('createdAt: $createdAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('colorKey: $colorKey, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MomentsTable extends Moments with TableInfo<$MomentsTable, Moment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MomentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loopIdMeta = const VerificationMeta('loopId');
  @override
  late final GeneratedColumn<String> loopId = GeneratedColumn<String>(
    'loop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urgeStrengthMeta = const VerificationMeta(
    'urgeStrength',
  );
  @override
  late final GeneratedColumn<int> urgeStrength = GeneratedColumn<int>(
    'urge_strength',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urgeAfterMeta = const VerificationMeta(
    'urgeAfter',
  );
  @override
  late final GeneratedColumn<int> urgeAfter = GeneratedColumn<int>(
    'urge_after',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rewardCategoryMeta = const VerificationMeta(
    'rewardCategory',
  );
  @override
  late final GeneratedColumn<String> rewardCategory = GeneratedColumn<String>(
    'reward_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _followupAnswerIndexMeta =
      const VerificationMeta('followupAnswerIndex');
  @override
  late final GeneratedColumn<int> followupAnswerIndex = GeneratedColumn<int>(
    'followup_answer_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rewardValueMeta = const VerificationMeta(
    'rewardValue',
  );
  @override
  late final GeneratedColumn<int> rewardValue = GeneratedColumn<int>(
    'reward_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    loopId,
    type,
    urgeStrength,
    urgeAfter,
    rewardCategory,
    followupAnswerIndex,
    rewardValue,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Moment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('loop_id')) {
      context.handle(
        _loopIdMeta,
        loopId.isAcceptableOrUnknown(data['loop_id']!, _loopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_loopIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('urge_strength')) {
      context.handle(
        _urgeStrengthMeta,
        urgeStrength.isAcceptableOrUnknown(
          data['urge_strength']!,
          _urgeStrengthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_urgeStrengthMeta);
    }
    if (data.containsKey('urge_after')) {
      context.handle(
        _urgeAfterMeta,
        urgeAfter.isAcceptableOrUnknown(data['urge_after']!, _urgeAfterMeta),
      );
    }
    if (data.containsKey('reward_category')) {
      context.handle(
        _rewardCategoryMeta,
        rewardCategory.isAcceptableOrUnknown(
          data['reward_category']!,
          _rewardCategoryMeta,
        ),
      );
    }
    if (data.containsKey('followup_answer_index')) {
      context.handle(
        _followupAnswerIndexMeta,
        followupAnswerIndex.isAcceptableOrUnknown(
          data['followup_answer_index']!,
          _followupAnswerIndexMeta,
        ),
      );
    }
    if (data.containsKey('reward_value')) {
      context.handle(
        _rewardValueMeta,
        rewardValue.isAcceptableOrUnknown(
          data['reward_value']!,
          _rewardValueMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Moment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Moment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      loopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}loop_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      urgeStrength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}urge_strength'],
      )!,
      urgeAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}urge_after'],
      ),
      rewardCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reward_category'],
      ),
      followupAnswerIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}followup_answer_index'],
      ),
      rewardValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_value'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MomentsTable createAlias(String alias) {
    return $MomentsTable(attachedDatabase, alias);
  }
}

class Moment extends DataClass implements Insertable<Moment> {
  final String id;
  final String loopId;
  final String type;
  final int urgeStrength;
  final int? urgeAfter;
  final String? rewardCategory;
  final int? followupAnswerIndex;
  final int? rewardValue;
  final String? note;
  final DateTime createdAt;
  const Moment({
    required this.id,
    required this.loopId,
    required this.type,
    required this.urgeStrength,
    this.urgeAfter,
    this.rewardCategory,
    this.followupAnswerIndex,
    this.rewardValue,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['loop_id'] = Variable<String>(loopId);
    map['type'] = Variable<String>(type);
    map['urge_strength'] = Variable<int>(urgeStrength);
    if (!nullToAbsent || urgeAfter != null) {
      map['urge_after'] = Variable<int>(urgeAfter);
    }
    if (!nullToAbsent || rewardCategory != null) {
      map['reward_category'] = Variable<String>(rewardCategory);
    }
    if (!nullToAbsent || followupAnswerIndex != null) {
      map['followup_answer_index'] = Variable<int>(followupAnswerIndex);
    }
    if (!nullToAbsent || rewardValue != null) {
      map['reward_value'] = Variable<int>(rewardValue);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MomentsCompanion toCompanion(bool nullToAbsent) {
    return MomentsCompanion(
      id: Value(id),
      loopId: Value(loopId),
      type: Value(type),
      urgeStrength: Value(urgeStrength),
      urgeAfter: urgeAfter == null && nullToAbsent
          ? const Value.absent()
          : Value(urgeAfter),
      rewardCategory: rewardCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(rewardCategory),
      followupAnswerIndex: followupAnswerIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(followupAnswerIndex),
      rewardValue: rewardValue == null && nullToAbsent
          ? const Value.absent()
          : Value(rewardValue),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory Moment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Moment(
      id: serializer.fromJson<String>(json['id']),
      loopId: serializer.fromJson<String>(json['loopId']),
      type: serializer.fromJson<String>(json['type']),
      urgeStrength: serializer.fromJson<int>(json['urgeStrength']),
      urgeAfter: serializer.fromJson<int?>(json['urgeAfter']),
      rewardCategory: serializer.fromJson<String?>(json['rewardCategory']),
      followupAnswerIndex: serializer.fromJson<int?>(
        json['followupAnswerIndex'],
      ),
      rewardValue: serializer.fromJson<int?>(json['rewardValue']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'loopId': serializer.toJson<String>(loopId),
      'type': serializer.toJson<String>(type),
      'urgeStrength': serializer.toJson<int>(urgeStrength),
      'urgeAfter': serializer.toJson<int?>(urgeAfter),
      'rewardCategory': serializer.toJson<String?>(rewardCategory),
      'followupAnswerIndex': serializer.toJson<int?>(followupAnswerIndex),
      'rewardValue': serializer.toJson<int?>(rewardValue),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Moment copyWith({
    String? id,
    String? loopId,
    String? type,
    int? urgeStrength,
    Value<int?> urgeAfter = const Value.absent(),
    Value<String?> rewardCategory = const Value.absent(),
    Value<int?> followupAnswerIndex = const Value.absent(),
    Value<int?> rewardValue = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => Moment(
    id: id ?? this.id,
    loopId: loopId ?? this.loopId,
    type: type ?? this.type,
    urgeStrength: urgeStrength ?? this.urgeStrength,
    urgeAfter: urgeAfter.present ? urgeAfter.value : this.urgeAfter,
    rewardCategory: rewardCategory.present
        ? rewardCategory.value
        : this.rewardCategory,
    followupAnswerIndex: followupAnswerIndex.present
        ? followupAnswerIndex.value
        : this.followupAnswerIndex,
    rewardValue: rewardValue.present ? rewardValue.value : this.rewardValue,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  Moment copyWithCompanion(MomentsCompanion data) {
    return Moment(
      id: data.id.present ? data.id.value : this.id,
      loopId: data.loopId.present ? data.loopId.value : this.loopId,
      type: data.type.present ? data.type.value : this.type,
      urgeStrength: data.urgeStrength.present
          ? data.urgeStrength.value
          : this.urgeStrength,
      urgeAfter: data.urgeAfter.present ? data.urgeAfter.value : this.urgeAfter,
      rewardCategory: data.rewardCategory.present
          ? data.rewardCategory.value
          : this.rewardCategory,
      followupAnswerIndex: data.followupAnswerIndex.present
          ? data.followupAnswerIndex.value
          : this.followupAnswerIndex,
      rewardValue: data.rewardValue.present
          ? data.rewardValue.value
          : this.rewardValue,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Moment(')
          ..write('id: $id, ')
          ..write('loopId: $loopId, ')
          ..write('type: $type, ')
          ..write('urgeStrength: $urgeStrength, ')
          ..write('urgeAfter: $urgeAfter, ')
          ..write('rewardCategory: $rewardCategory, ')
          ..write('followupAnswerIndex: $followupAnswerIndex, ')
          ..write('rewardValue: $rewardValue, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    loopId,
    type,
    urgeStrength,
    urgeAfter,
    rewardCategory,
    followupAnswerIndex,
    rewardValue,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Moment &&
          other.id == this.id &&
          other.loopId == this.loopId &&
          other.type == this.type &&
          other.urgeStrength == this.urgeStrength &&
          other.urgeAfter == this.urgeAfter &&
          other.rewardCategory == this.rewardCategory &&
          other.followupAnswerIndex == this.followupAnswerIndex &&
          other.rewardValue == this.rewardValue &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class MomentsCompanion extends UpdateCompanion<Moment> {
  final Value<String> id;
  final Value<String> loopId;
  final Value<String> type;
  final Value<int> urgeStrength;
  final Value<int?> urgeAfter;
  final Value<String?> rewardCategory;
  final Value<int?> followupAnswerIndex;
  final Value<int?> rewardValue;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MomentsCompanion({
    this.id = const Value.absent(),
    this.loopId = const Value.absent(),
    this.type = const Value.absent(),
    this.urgeStrength = const Value.absent(),
    this.urgeAfter = const Value.absent(),
    this.rewardCategory = const Value.absent(),
    this.followupAnswerIndex = const Value.absent(),
    this.rewardValue = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MomentsCompanion.insert({
    required String id,
    required String loopId,
    required String type,
    required int urgeStrength,
    this.urgeAfter = const Value.absent(),
    this.rewardCategory = const Value.absent(),
    this.followupAnswerIndex = const Value.absent(),
    this.rewardValue = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       loopId = Value(loopId),
       type = Value(type),
       urgeStrength = Value(urgeStrength),
       createdAt = Value(createdAt);
  static Insertable<Moment> custom({
    Expression<String>? id,
    Expression<String>? loopId,
    Expression<String>? type,
    Expression<int>? urgeStrength,
    Expression<int>? urgeAfter,
    Expression<String>? rewardCategory,
    Expression<int>? followupAnswerIndex,
    Expression<int>? rewardValue,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (loopId != null) 'loop_id': loopId,
      if (type != null) 'type': type,
      if (urgeStrength != null) 'urge_strength': urgeStrength,
      if (urgeAfter != null) 'urge_after': urgeAfter,
      if (rewardCategory != null) 'reward_category': rewardCategory,
      if (followupAnswerIndex != null)
        'followup_answer_index': followupAnswerIndex,
      if (rewardValue != null) 'reward_value': rewardValue,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MomentsCompanion copyWith({
    Value<String>? id,
    Value<String>? loopId,
    Value<String>? type,
    Value<int>? urgeStrength,
    Value<int?>? urgeAfter,
    Value<String?>? rewardCategory,
    Value<int?>? followupAnswerIndex,
    Value<int?>? rewardValue,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MomentsCompanion(
      id: id ?? this.id,
      loopId: loopId ?? this.loopId,
      type: type ?? this.type,
      urgeStrength: urgeStrength ?? this.urgeStrength,
      urgeAfter: urgeAfter ?? this.urgeAfter,
      rewardCategory: rewardCategory ?? this.rewardCategory,
      followupAnswerIndex: followupAnswerIndex ?? this.followupAnswerIndex,
      rewardValue: rewardValue ?? this.rewardValue,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (loopId.present) {
      map['loop_id'] = Variable<String>(loopId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (urgeStrength.present) {
      map['urge_strength'] = Variable<int>(urgeStrength.value);
    }
    if (urgeAfter.present) {
      map['urge_after'] = Variable<int>(urgeAfter.value);
    }
    if (rewardCategory.present) {
      map['reward_category'] = Variable<String>(rewardCategory.value);
    }
    if (followupAnswerIndex.present) {
      map['followup_answer_index'] = Variable<int>(followupAnswerIndex.value);
    }
    if (rewardValue.present) {
      map['reward_value'] = Variable<int>(rewardValue.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MomentsCompanion(')
          ..write('id: $id, ')
          ..write('loopId: $loopId, ')
          ..write('type: $type, ')
          ..write('urgeStrength: $urgeStrength, ')
          ..write('urgeAfter: $urgeAfter, ')
          ..write('rewardCategory: $rewardCategory, ')
          ..write('followupAnswerIndex: $followupAnswerIndex, ')
          ..write('rewardValue: $rewardValue, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LoopsTable loops = $LoopsTable(this);
  late final $MomentsTable moments = $MomentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [loops, moments];
}

typedef $$LoopsTableCreateCompanionBuilder =
    LoopsCompanion Function({
      required String id,
      required String behavior,
      Value<String> trigger,
      Value<String> rewardGuess,
      Value<bool> isFocus,
      required DateTime createdAt,
      Value<DateTime?> archivedAt,
      Value<String> colorKey,
      Value<int> rowid,
    });
typedef $$LoopsTableUpdateCompanionBuilder =
    LoopsCompanion Function({
      Value<String> id,
      Value<String> behavior,
      Value<String> trigger,
      Value<String> rewardGuess,
      Value<bool> isFocus,
      Value<DateTime> createdAt,
      Value<DateTime?> archivedAt,
      Value<String> colorKey,
      Value<int> rowid,
    });

class $$LoopsTableFilterComposer extends Composer<_$AppDatabase, $LoopsTable> {
  $$LoopsTableFilterComposer({
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

  ColumnFilters<String> get behavior => $composableBuilder(
    column: $table.behavior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rewardGuess => $composableBuilder(
    column: $table.rewardGuess,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFocus => $composableBuilder(
    column: $table.isFocus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorKey => $composableBuilder(
    column: $table.colorKey,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LoopsTableOrderingComposer
    extends Composer<_$AppDatabase, $LoopsTable> {
  $$LoopsTableOrderingComposer({
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

  ColumnOrderings<String> get behavior => $composableBuilder(
    column: $table.behavior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rewardGuess => $composableBuilder(
    column: $table.rewardGuess,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFocus => $composableBuilder(
    column: $table.isFocus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorKey => $composableBuilder(
    column: $table.colorKey,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LoopsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoopsTable> {
  $$LoopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get behavior =>
      $composableBuilder(column: $table.behavior, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<String> get rewardGuess => $composableBuilder(
    column: $table.rewardGuess,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFocus =>
      $composableBuilder(column: $table.isFocus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colorKey =>
      $composableBuilder(column: $table.colorKey, builder: (column) => column);
}

class $$LoopsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoopsTable,
          Loop,
          $$LoopsTableFilterComposer,
          $$LoopsTableOrderingComposer,
          $$LoopsTableAnnotationComposer,
          $$LoopsTableCreateCompanionBuilder,
          $$LoopsTableUpdateCompanionBuilder,
          (Loop, BaseReferences<_$AppDatabase, $LoopsTable, Loop>),
          Loop,
          PrefetchHooks Function()
        > {
  $$LoopsTableTableManager(_$AppDatabase db, $LoopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> behavior = const Value.absent(),
                Value<String> trigger = const Value.absent(),
                Value<String> rewardGuess = const Value.absent(),
                Value<bool> isFocus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<String> colorKey = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LoopsCompanion(
                id: id,
                behavior: behavior,
                trigger: trigger,
                rewardGuess: rewardGuess,
                isFocus: isFocus,
                createdAt: createdAt,
                archivedAt: archivedAt,
                colorKey: colorKey,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String behavior,
                Value<String> trigger = const Value.absent(),
                Value<String> rewardGuess = const Value.absent(),
                Value<bool> isFocus = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<String> colorKey = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LoopsCompanion.insert(
                id: id,
                behavior: behavior,
                trigger: trigger,
                rewardGuess: rewardGuess,
                isFocus: isFocus,
                createdAt: createdAt,
                archivedAt: archivedAt,
                colorKey: colorKey,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LoopsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoopsTable,
      Loop,
      $$LoopsTableFilterComposer,
      $$LoopsTableOrderingComposer,
      $$LoopsTableAnnotationComposer,
      $$LoopsTableCreateCompanionBuilder,
      $$LoopsTableUpdateCompanionBuilder,
      (Loop, BaseReferences<_$AppDatabase, $LoopsTable, Loop>),
      Loop,
      PrefetchHooks Function()
    >;
typedef $$MomentsTableCreateCompanionBuilder =
    MomentsCompanion Function({
      required String id,
      required String loopId,
      required String type,
      required int urgeStrength,
      Value<int?> urgeAfter,
      Value<String?> rewardCategory,
      Value<int?> followupAnswerIndex,
      Value<int?> rewardValue,
      Value<String?> note,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$MomentsTableUpdateCompanionBuilder =
    MomentsCompanion Function({
      Value<String> id,
      Value<String> loopId,
      Value<String> type,
      Value<int> urgeStrength,
      Value<int?> urgeAfter,
      Value<String?> rewardCategory,
      Value<int?> followupAnswerIndex,
      Value<int?> rewardValue,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$MomentsTableFilterComposer
    extends Composer<_$AppDatabase, $MomentsTable> {
  $$MomentsTableFilterComposer({
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

  ColumnFilters<String> get loopId => $composableBuilder(
    column: $table.loopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get urgeStrength => $composableBuilder(
    column: $table.urgeStrength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get urgeAfter => $composableBuilder(
    column: $table.urgeAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rewardCategory => $composableBuilder(
    column: $table.rewardCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get followupAnswerIndex => $composableBuilder(
    column: $table.followupAnswerIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardValue => $composableBuilder(
    column: $table.rewardValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MomentsTableOrderingComposer
    extends Composer<_$AppDatabase, $MomentsTable> {
  $$MomentsTableOrderingComposer({
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

  ColumnOrderings<String> get loopId => $composableBuilder(
    column: $table.loopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get urgeStrength => $composableBuilder(
    column: $table.urgeStrength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get urgeAfter => $composableBuilder(
    column: $table.urgeAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rewardCategory => $composableBuilder(
    column: $table.rewardCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get followupAnswerIndex => $composableBuilder(
    column: $table.followupAnswerIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardValue => $composableBuilder(
    column: $table.rewardValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MomentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MomentsTable> {
  $$MomentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get loopId =>
      $composableBuilder(column: $table.loopId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get urgeStrength => $composableBuilder(
    column: $table.urgeStrength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get urgeAfter =>
      $composableBuilder(column: $table.urgeAfter, builder: (column) => column);

  GeneratedColumn<String> get rewardCategory => $composableBuilder(
    column: $table.rewardCategory,
    builder: (column) => column,
  );

  GeneratedColumn<int> get followupAnswerIndex => $composableBuilder(
    column: $table.followupAnswerIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rewardValue => $composableBuilder(
    column: $table.rewardValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MomentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MomentsTable,
          Moment,
          $$MomentsTableFilterComposer,
          $$MomentsTableOrderingComposer,
          $$MomentsTableAnnotationComposer,
          $$MomentsTableCreateCompanionBuilder,
          $$MomentsTableUpdateCompanionBuilder,
          (Moment, BaseReferences<_$AppDatabase, $MomentsTable, Moment>),
          Moment,
          PrefetchHooks Function()
        > {
  $$MomentsTableTableManager(_$AppDatabase db, $MomentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MomentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MomentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MomentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> loopId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> urgeStrength = const Value.absent(),
                Value<int?> urgeAfter = const Value.absent(),
                Value<String?> rewardCategory = const Value.absent(),
                Value<int?> followupAnswerIndex = const Value.absent(),
                Value<int?> rewardValue = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MomentsCompanion(
                id: id,
                loopId: loopId,
                type: type,
                urgeStrength: urgeStrength,
                urgeAfter: urgeAfter,
                rewardCategory: rewardCategory,
                followupAnswerIndex: followupAnswerIndex,
                rewardValue: rewardValue,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String loopId,
                required String type,
                required int urgeStrength,
                Value<int?> urgeAfter = const Value.absent(),
                Value<String?> rewardCategory = const Value.absent(),
                Value<int?> followupAnswerIndex = const Value.absent(),
                Value<int?> rewardValue = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MomentsCompanion.insert(
                id: id,
                loopId: loopId,
                type: type,
                urgeStrength: urgeStrength,
                urgeAfter: urgeAfter,
                rewardCategory: rewardCategory,
                followupAnswerIndex: followupAnswerIndex,
                rewardValue: rewardValue,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MomentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MomentsTable,
      Moment,
      $$MomentsTableFilterComposer,
      $$MomentsTableOrderingComposer,
      $$MomentsTableAnnotationComposer,
      $$MomentsTableCreateCompanionBuilder,
      $$MomentsTableUpdateCompanionBuilder,
      (Moment, BaseReferences<_$AppDatabase, $MomentsTable, Moment>),
      Moment,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LoopsTableTableManager get loops =>
      $$LoopsTableTableManager(_db, _db.loops);
  $$MomentsTableTableManager get moments =>
      $$MomentsTableTableManager(_db, _db.moments);
}

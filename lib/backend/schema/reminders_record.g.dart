// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RemindersRecord> _$remindersRecordSerializer =
    new _$RemindersRecordSerializer();

class _$RemindersRecordSerializer
    implements StructuredSerializer<RemindersRecord> {
  @override
  final Iterable<Type> types = const [RemindersRecord, _$RemindersRecord];
  @override
  final String wireName = 'RemindersRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, RemindersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.userAssociation;
    if (value != null) {
      result
        ..add('userAssociation')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.reminderTitle;
    if (value != null) {
      result
        ..add('reminderTitle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reminderDescription;
    if (value != null) {
      result
        ..add('reminderDescription')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  RemindersRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RemindersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'userAssociation':
          result.userAssociation = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'reminderTitle':
          result.reminderTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reminderDescription':
          result.reminderDescription = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$RemindersRecord extends RemindersRecord {
  @override
  final DocumentReference<Object> userAssociation;
  @override
  final String reminderTitle;
  @override
  final String reminderDescription;
  @override
  final DocumentReference<Object> reference;

  factory _$RemindersRecord([void Function(RemindersRecordBuilder) updates]) =>
      (new RemindersRecordBuilder()..update(updates)).build();

  _$RemindersRecord._(
      {this.userAssociation,
      this.reminderTitle,
      this.reminderDescription,
      this.reference})
      : super._();

  @override
  RemindersRecord rebuild(void Function(RemindersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RemindersRecordBuilder toBuilder() =>
      new RemindersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RemindersRecord &&
        userAssociation == other.userAssociation &&
        reminderTitle == other.reminderTitle &&
        reminderDescription == other.reminderDescription &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, userAssociation.hashCode), reminderTitle.hashCode),
            reminderDescription.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RemindersRecord')
          ..add('userAssociation', userAssociation)
          ..add('reminderTitle', reminderTitle)
          ..add('reminderDescription', reminderDescription)
          ..add('reference', reference))
        .toString();
  }
}

class RemindersRecordBuilder
    implements Builder<RemindersRecord, RemindersRecordBuilder> {
  _$RemindersRecord _$v;

  DocumentReference<Object> _userAssociation;
  DocumentReference<Object> get userAssociation => _$this._userAssociation;
  set userAssociation(DocumentReference<Object> userAssociation) =>
      _$this._userAssociation = userAssociation;

  String _reminderTitle;
  String get reminderTitle => _$this._reminderTitle;
  set reminderTitle(String reminderTitle) =>
      _$this._reminderTitle = reminderTitle;

  String _reminderDescription;
  String get reminderDescription => _$this._reminderDescription;
  set reminderDescription(String reminderDescription) =>
      _$this._reminderDescription = reminderDescription;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  RemindersRecordBuilder() {
    RemindersRecord._initializeBuilder(this);
  }

  RemindersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userAssociation = $v.userAssociation;
      _reminderTitle = $v.reminderTitle;
      _reminderDescription = $v.reminderDescription;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RemindersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RemindersRecord;
  }

  @override
  void update(void Function(RemindersRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RemindersRecord build() {
    final _$result = _$v ??
        new _$RemindersRecord._(
            userAssociation: userAssociation,
            reminderTitle: reminderTitle,
            reminderDescription: reminderDescription,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

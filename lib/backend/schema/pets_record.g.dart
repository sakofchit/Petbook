// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pets_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PetsRecord> _$petsRecordSerializer = new _$PetsRecordSerializer();

class _$PetsRecordSerializer implements StructuredSerializer<PetsRecord> {
  @override
  final Iterable<Type> types = const [PetsRecord, _$PetsRecord];
  @override
  final String wireName = 'PetsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, PetsRecord object,
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
    value = object.petPhoto;
    if (value != null) {
      result
        ..add('petPhoto')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.petName;
    if (value != null) {
      result
        ..add('petName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.petType;
    if (value != null) {
      result
        ..add('petType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.petAge;
    if (value != null) {
      result
        ..add('petAge')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.petBio;
    if (value != null) {
      result
        ..add('petBio')
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
  PetsRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PetsRecordBuilder();

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
        case 'petPhoto':
          result.petPhoto = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'petName':
          result.petName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'petType':
          result.petType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'petAge':
          result.petAge = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'petBio':
          result.petBio = serializers.deserialize(value,
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

class _$PetsRecord extends PetsRecord {
  @override
  final DocumentReference<Object> userAssociation;
  @override
  final String petPhoto;
  @override
  final String petName;
  @override
  final String petType;
  @override
  final String petAge;
  @override
  final String petBio;
  @override
  final DocumentReference<Object> reference;

  factory _$PetsRecord([void Function(PetsRecordBuilder) updates]) =>
      (new PetsRecordBuilder()..update(updates)).build();

  _$PetsRecord._(
      {this.userAssociation,
      this.petPhoto,
      this.petName,
      this.petType,
      this.petAge,
      this.petBio,
      this.reference})
      : super._();

  @override
  PetsRecord rebuild(void Function(PetsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PetsRecordBuilder toBuilder() => new PetsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PetsRecord &&
        userAssociation == other.userAssociation &&
        petPhoto == other.petPhoto &&
        petName == other.petName &&
        petType == other.petType &&
        petAge == other.petAge &&
        petBio == other.petBio &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc(0, userAssociation.hashCode),
                            petPhoto.hashCode),
                        petName.hashCode),
                    petType.hashCode),
                petAge.hashCode),
            petBio.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PetsRecord')
          ..add('userAssociation', userAssociation)
          ..add('petPhoto', petPhoto)
          ..add('petName', petName)
          ..add('petType', petType)
          ..add('petAge', petAge)
          ..add('petBio', petBio)
          ..add('reference', reference))
        .toString();
  }
}

class PetsRecordBuilder implements Builder<PetsRecord, PetsRecordBuilder> {
  _$PetsRecord _$v;

  DocumentReference<Object> _userAssociation;
  DocumentReference<Object> get userAssociation => _$this._userAssociation;
  set userAssociation(DocumentReference<Object> userAssociation) =>
      _$this._userAssociation = userAssociation;

  String _petPhoto;
  String get petPhoto => _$this._petPhoto;
  set petPhoto(String petPhoto) => _$this._petPhoto = petPhoto;

  String _petName;
  String get petName => _$this._petName;
  set petName(String petName) => _$this._petName = petName;

  String _petType;
  String get petType => _$this._petType;
  set petType(String petType) => _$this._petType = petType;

  String _petAge;
  String get petAge => _$this._petAge;
  set petAge(String petAge) => _$this._petAge = petAge;

  String _petBio;
  String get petBio => _$this._petBio;
  set petBio(String petBio) => _$this._petBio = petBio;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  PetsRecordBuilder() {
    PetsRecord._initializeBuilder(this);
  }

  PetsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userAssociation = $v.userAssociation;
      _petPhoto = $v.petPhoto;
      _petName = $v.petName;
      _petType = $v.petType;
      _petAge = $v.petAge;
      _petBio = $v.petBio;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PetsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PetsRecord;
  }

  @override
  void update(void Function(PetsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PetsRecord build() {
    final _$result = _$v ??
        new _$PetsRecord._(
            userAssociation: userAssociation,
            petPhoto: petPhoto,
            petName: petName,
            petType: petType,
            petAge: petAge,
            petBio: petBio,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

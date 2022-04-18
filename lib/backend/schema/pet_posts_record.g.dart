// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_posts_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PetPostsRecord> _$petPostsRecordSerializer =
    new _$PetPostsRecordSerializer();

class _$PetPostsRecordSerializer
    implements StructuredSerializer<PetPostsRecord> {
  @override
  final Iterable<Type> types = const [PetPostsRecord, _$PetPostsRecord];
  @override
  final String wireName = 'PetPostsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, PetPostsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.postPhoto;
    if (value != null) {
      result
        ..add('postPhoto')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postTitle;
    if (value != null) {
      result
        ..add('postTitle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postDescription;
    if (value != null) {
      result
        ..add('postDescription')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postUser;
    if (value != null) {
      result
        ..add('postUser')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.timePosted;
    if (value != null) {
      result
        ..add('timePosted')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.petProfile;
    if (value != null) {
      result
        ..add('petProfile')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.postOwner;
    if (value != null) {
      result
        ..add('postOwner')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
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
  PetPostsRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PetPostsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'postPhoto':
          result.postPhoto = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'postTitle':
          result.postTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'postDescription':
          result.postDescription = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'postUser':
          result.postUser = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'timePosted':
          result.timePosted = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'petProfile':
          result.petProfile = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'postOwner':
          result.postOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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

class _$PetPostsRecord extends PetPostsRecord {
  @override
  final String postPhoto;
  @override
  final String postTitle;
  @override
  final String postDescription;
  @override
  final DocumentReference<Object> postUser;
  @override
  final DateTime timePosted;
  @override
  final DocumentReference<Object> petProfile;
  @override
  final bool postOwner;
  @override
  final DocumentReference<Object> reference;

  factory _$PetPostsRecord([void Function(PetPostsRecordBuilder) updates]) =>
      (new PetPostsRecordBuilder()..update(updates)).build();

  _$PetPostsRecord._(
      {this.postPhoto,
      this.postTitle,
      this.postDescription,
      this.postUser,
      this.timePosted,
      this.petProfile,
      this.postOwner,
      this.reference})
      : super._();

  @override
  PetPostsRecord rebuild(void Function(PetPostsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PetPostsRecordBuilder toBuilder() =>
      new PetPostsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PetPostsRecord &&
        postPhoto == other.postPhoto &&
        postTitle == other.postTitle &&
        postDescription == other.postDescription &&
        postUser == other.postUser &&
        timePosted == other.timePosted &&
        petProfile == other.petProfile &&
        postOwner == other.postOwner &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, postPhoto.hashCode), postTitle.hashCode),
                            postDescription.hashCode),
                        postUser.hashCode),
                    timePosted.hashCode),
                petProfile.hashCode),
            postOwner.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PetPostsRecord')
          ..add('postPhoto', postPhoto)
          ..add('postTitle', postTitle)
          ..add('postDescription', postDescription)
          ..add('postUser', postUser)
          ..add('timePosted', timePosted)
          ..add('petProfile', petProfile)
          ..add('postOwner', postOwner)
          ..add('reference', reference))
        .toString();
  }
}

class PetPostsRecordBuilder
    implements Builder<PetPostsRecord, PetPostsRecordBuilder> {
  _$PetPostsRecord _$v;

  String _postPhoto;
  String get postPhoto => _$this._postPhoto;
  set postPhoto(String postPhoto) => _$this._postPhoto = postPhoto;

  String _postTitle;
  String get postTitle => _$this._postTitle;
  set postTitle(String postTitle) => _$this._postTitle = postTitle;

  String _postDescription;
  String get postDescription => _$this._postDescription;
  set postDescription(String postDescription) =>
      _$this._postDescription = postDescription;

  DocumentReference<Object> _postUser;
  DocumentReference<Object> get postUser => _$this._postUser;
  set postUser(DocumentReference<Object> postUser) =>
      _$this._postUser = postUser;

  DateTime _timePosted;
  DateTime get timePosted => _$this._timePosted;
  set timePosted(DateTime timePosted) => _$this._timePosted = timePosted;

  DocumentReference<Object> _petProfile;
  DocumentReference<Object> get petProfile => _$this._petProfile;
  set petProfile(DocumentReference<Object> petProfile) =>
      _$this._petProfile = petProfile;

  bool _postOwner;
  bool get postOwner => _$this._postOwner;
  set postOwner(bool postOwner) => _$this._postOwner = postOwner;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  PetPostsRecordBuilder() {
    PetPostsRecord._initializeBuilder(this);
  }

  PetPostsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postPhoto = $v.postPhoto;
      _postTitle = $v.postTitle;
      _postDescription = $v.postDescription;
      _postUser = $v.postUser;
      _timePosted = $v.timePosted;
      _petProfile = $v.petProfile;
      _postOwner = $v.postOwner;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PetPostsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PetPostsRecord;
  }

  @override
  void update(void Function(PetPostsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PetPostsRecord build() {
    final _$result = _$v ??
        new _$PetPostsRecord._(
            postPhoto: postPhoto,
            postTitle: postTitle,
            postDescription: postDescription,
            postUser: postUser,
            timePosted: timePosted,
            petProfile: petProfile,
            postOwner: postOwner,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

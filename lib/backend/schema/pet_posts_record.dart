import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'pet_posts_record.g.dart';

abstract class PetPostsRecord
    implements Built<PetPostsRecord, PetPostsRecordBuilder> {
  static Serializer<PetPostsRecord> get serializer =>
      _$petPostsRecordSerializer;

  @nullable
  String get postPhoto;

  @nullable
  String get postTitle;

  @nullable
  String get postDescription;

  @nullable
  DocumentReference get postUser;

  @nullable
  DateTime get timePosted;


  @nullable
  DocumentReference get petProfile;

  @nullable
  bool get postOwner;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PetPostsRecordBuilder builder) => builder
    ..postPhoto = ''
    ..postTitle = ''
    ..postDescription = ''
    ..postOwner = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('petPosts');

  static Stream<PetPostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<PetPostsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PetPostsRecord._();
  factory PetPostsRecord([void Function(PetPostsRecordBuilder) updates]) =
      _$PetPostsRecord;

  static PetPostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPetPostsRecordData({
  String postPhoto,
  String postTitle,
  String postDescription,
  DocumentReference postUser,
  DateTime timePosted,
  DocumentReference petProfile,
  bool postOwner,
}) =>
    serializers.toFirestore(
        PetPostsRecord.serializer,
        PetPostsRecord((u) => u
          ..postPhoto = postPhoto
          ..postTitle = postTitle
          ..postDescription = postDescription
          ..postUser = postUser
          ..timePosted = timePosted
          ..petProfile = petProfile
          ..postOwner = postOwner));

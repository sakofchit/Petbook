import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'pets_record.g.dart';

abstract class PetsRecord implements Built<PetsRecord, PetsRecordBuilder> {
  static Serializer<PetsRecord> get serializer => _$petsRecordSerializer;

  @nullable
  DocumentReference get userAssociation;

  @nullable
  String get petPhoto;

  @nullable
  String get petName;

  @nullable
  String get petType;

  @nullable
  String get petAge;

  @nullable
  String get petBio;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PetsRecordBuilder builder) => builder
    ..petPhoto = ''
    ..petName = ''
    ..petType = ''
    ..petAge = ''
    ..petBio = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('pets');

  static Stream<PetsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<PetsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PetsRecord._();
  factory PetsRecord([void Function(PetsRecordBuilder) updates]) = _$PetsRecord;

  static PetsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPetsRecordData({
  DocumentReference userAssociation,
  String petPhoto,
  String petName,
  String petType,
  String petAge,
  String petBio,
}) =>
    serializers.toFirestore(
        PetsRecord.serializer,
        PetsRecord((d) => d
          ..userAssociation = userAssociation
          ..petPhoto = petPhoto
          ..petName = petName
          ..petType = petType
          ..petAge = petAge
          ..petBio = petBio));

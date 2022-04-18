import 'dart:async';
import 'dart:io';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:http/http.dart' as http;

part 'reminders_record.g.dart';

abstract class RemindersRecord implements Built<RemindersRecord, RemindersRecordBuilder> {
  static Serializer<RemindersRecord> get serializer => _$remindersRecordSerializer;

  @nullable
  DocumentReference get userAssociation;

  @nullable
  String get reminderTitle;

  @nullable
  String get reminderDescription;


  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(RemindersRecordBuilder builder) => builder
    ..reminderTitle = ''
    ..reminderDescription = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('pets');

  static Stream<RemindersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<RemindersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  RemindersRecord._();
  factory RemindersRecord([void Function(RemindersRecordBuilder) updates]) = _$RemindersRecord;

  static RemindersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

var docId = FirebaseFirestore.instance.collection('pets').doc(); 

Map<String, dynamic> createRemindersRecordData({
  DocumentReference userAssociation,
  String reminderTitle,
  String reminderDescription,
}) =>
    serializers.toFirestore(
        RemindersRecord.serializer,
        RemindersRecord((d) => d
          ..userAssociation = userAssociation
          ..reminderTitle = reminderTitle
          ..reminderDescription = reminderDescription));

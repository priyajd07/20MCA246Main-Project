import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'remitter_record.g.dart';

abstract class RemitterRecord
    implements Built<RemitterRecord, RemitterRecordBuilder> {
  static Serializer<RemitterRecord> get serializer =>
      _$remitterRecordSerializer;

  @nullable
  String get name;

  @nullable
  String get idNo;

  @nullable
  String get mobileNo;

  @nullable
  String get nationality;

  @nullable
  String get address;

  @nullable
  String get repCode;

  @nullable
  String get imageUrl;

  @nullable
  String get id;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(RemitterRecordBuilder builder) => builder
    ..name = ''
    ..idNo = ''
    ..mobileNo = ''
    ..nationality = ''
    ..address = ''
    ..repCode = ''
    ..imageUrl = ''
    ..id = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('remitter');

  static Stream<RemitterRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<RemitterRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  RemitterRecord._();
  factory RemitterRecord([void Function(RemitterRecordBuilder) updates]) =
      _$RemitterRecord;

  static RemitterRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createRemitterRecordData({
  String name,
  String idNo,
  String mobileNo,
  String nationality,
  String address,
  String repCode,
  String imageUrl,
  String id,
}) =>
    serializers.toFirestore(
        RemitterRecord.serializer,
        RemitterRecord((r) => r
          ..name = name
          ..idNo = idNo
          ..mobileNo = mobileNo
          ..nationality = nationality
          ..address = address
          ..repCode = repCode
          ..imageUrl = imageUrl
          ..id = id));

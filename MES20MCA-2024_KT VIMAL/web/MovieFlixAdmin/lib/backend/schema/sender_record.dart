import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'sender_record.g.dart';

abstract class SenderRecord
    implements Built<SenderRecord, SenderRecordBuilder> {
  static Serializer<SenderRecord> get serializer => _$senderRecordSerializer;

  @nullable
  String get name;

  @nullable
  String get accNo;

  @nullable
  String get bank;

  @nullable
  String get remitter;

  @nullable
  String get ifsc;

  @nullable
  String get branch;

  @nullable
  String get country;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SenderRecordBuilder builder) => builder
    ..name = ''
    ..accNo = ''
    ..bank = ''
    ..ifsc = ''
    ..branch = ''
    ..remitter = ''
    ..country = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('sender');

  static Stream<SenderRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<SenderRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SenderRecord._();
  factory SenderRecord([void Function(SenderRecordBuilder) updates]) =
      _$SenderRecord;

  static SenderRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createSenderRecordData({
  String name,
  String accNo,
  String bank,
  String ifsc,
  String branch,
  String remitter,
  String country,
}) =>
    serializers.toFirestore(
        SenderRecord.serializer,
        SenderRecord((s) => s
          ..name = name
          ..accNo = accNo
          ..bank = bank
          ..ifsc = ifsc
          ..branch = branch
          ..remitter = remitter
          ..country = country));

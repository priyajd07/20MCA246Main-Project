// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remitter_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RemitterRecord> _$remitterRecordSerializer =
    new _$RemitterRecordSerializer();

class _$RemitterRecordSerializer
    implements StructuredSerializer<RemitterRecord> {
  @override
  final Iterable<Type> types = const [RemitterRecord, _$RemitterRecord];
  @override
  final String wireName = 'RemitterRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, RemitterRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.idNo;
    if (value != null) {
      result
        ..add('idNo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mobileNo;
    if (value != null) {
      result
        ..add('mobileNo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.nationality;
    if (value != null) {
      result
        ..add('nationality')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.repCode;
    if (value != null) {
      result
        ..add('repCode')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
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
  RemitterRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RemitterRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'idNo':
          result.idNo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mobileNo':
          result.mobileNo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nationality':
          result.nationality = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'repCode':
          result.repCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
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

class _$RemitterRecord extends RemitterRecord {
  @override
  final String name;
  @override
  final String idNo;
  @override
  final String mobileNo;
  @override
  final String nationality;
  @override
  final String address;
  @override
  final String repCode;
  @override
  final String imageUrl;
  @override
  final String id;
  @override
  final DocumentReference<Object> reference;

  factory _$RemitterRecord([void Function(RemitterRecordBuilder) updates]) =>
      (new RemitterRecordBuilder()..update(updates)).build();

  _$RemitterRecord._(
      {this.name,
      this.idNo,
      this.mobileNo,
      this.nationality,
      this.address,
      this.repCode,
      this.imageUrl,
      this.id,
      this.reference})
      : super._();

  @override
  RemitterRecord rebuild(void Function(RemitterRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RemitterRecordBuilder toBuilder() =>
      new RemitterRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RemitterRecord &&
        name == other.name &&
        idNo == other.idNo &&
        mobileNo == other.mobileNo &&
        nationality == other.nationality &&
        address == other.address &&
        repCode == other.repCode &&
        imageUrl == other.imageUrl &&
        id == other.id &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, name.hashCode), idNo.hashCode),
                                mobileNo.hashCode),
                            nationality.hashCode),
                        address.hashCode),
                    repCode.hashCode),
                imageUrl.hashCode),
            id.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RemitterRecord')
          ..add('name', name)
          ..add('idNo', idNo)
          ..add('mobileNo', mobileNo)
          ..add('nationality', nationality)
          ..add('address', address)
          ..add('repCode', repCode)
          ..add('imageUrl', imageUrl)
          ..add('id', id)
          ..add('reference', reference))
        .toString();
  }
}

class RemitterRecordBuilder
    implements Builder<RemitterRecord, RemitterRecordBuilder> {
  _$RemitterRecord _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _idNo;
  String get idNo => _$this._idNo;
  set idNo(String idNo) => _$this._idNo = idNo;

  String _mobileNo;
  String get mobileNo => _$this._mobileNo;
  set mobileNo(String mobileNo) => _$this._mobileNo = mobileNo;

  String _nationality;
  String get nationality => _$this._nationality;
  set nationality(String nationality) => _$this._nationality = nationality;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _repCode;
  String get repCode => _$this._repCode;
  set repCode(String repCode) => _$this._repCode = repCode;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  RemitterRecordBuilder() {
    RemitterRecord._initializeBuilder(this);
  }

  RemitterRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _idNo = $v.idNo;
      _mobileNo = $v.mobileNo;
      _nationality = $v.nationality;
      _address = $v.address;
      _repCode = $v.repCode;
      _imageUrl = $v.imageUrl;
      _id = $v.id;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RemitterRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RemitterRecord;
  }

  @override
  void update(void Function(RemitterRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RemitterRecord build() {
    final _$result = _$v ??
        new _$RemitterRecord._(
            name: name,
            idNo: idNo,
            mobileNo: mobileNo,
            nationality: nationality,
            address: address,
            repCode: repCode,
            imageUrl: imageUrl,
            id: id,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

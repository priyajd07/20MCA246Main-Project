// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SenderRecord> _$senderRecordSerializer =
    new _$SenderRecordSerializer();

class _$SenderRecordSerializer implements StructuredSerializer<SenderRecord> {
  @override
  final Iterable<Type> types = const [SenderRecord, _$SenderRecord];
  @override
  final String wireName = 'SenderRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, SenderRecord object,
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
    value = object.accNo;
    if (value != null) {
      result
        ..add('accNo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.bank;
    if (value != null) {
      result
        ..add('bank')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.remitter;
    if (value != null) {
      result
        ..add('remitter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ifsc;
    if (value != null) {
      result
        ..add('ifsc')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.branch;
    if (value != null) {
      result
        ..add('branch')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.country;
    if (value != null) {
      result
        ..add('country')
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
  SenderRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SenderRecordBuilder();

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
        case 'accNo':
          result.accNo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bank':
          result.bank = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'remitter':
          result.remitter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ifsc':
          result.ifsc = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'branch':
          result.branch = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country':
          result.country = serializers.deserialize(value,
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

class _$SenderRecord extends SenderRecord {
  @override
  final String name;
  @override
  final String accNo;
  @override
  final String bank;
  @override
  final String remitter;
  @override
  final String ifsc;
  @override
  final String branch;
  @override
  final String country;
  @override
  final DocumentReference<Object> reference;

  factory _$SenderRecord([void Function(SenderRecordBuilder) updates]) =>
      (new SenderRecordBuilder()..update(updates)).build();

  _$SenderRecord._(
      {this.name,
      this.accNo,
      this.bank,
      this.remitter,
      this.ifsc,
      this.branch,
      this.country,
      this.reference})
      : super._();

  @override
  SenderRecord rebuild(void Function(SenderRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SenderRecordBuilder toBuilder() => new SenderRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SenderRecord &&
        name == other.name &&
        accNo == other.accNo &&
        bank == other.bank &&
        remitter == other.remitter &&
        ifsc == other.ifsc &&
        branch == other.branch &&
        country == other.country &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, name.hashCode), accNo.hashCode),
                            bank.hashCode),
                        remitter.hashCode),
                    ifsc.hashCode),
                branch.hashCode),
            country.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SenderRecord')
          ..add('name', name)
          ..add('accNo', accNo)
          ..add('bank', bank)
          ..add('remitter', remitter)
          ..add('ifsc', ifsc)
          ..add('branch', branch)
          ..add('country', country)
          ..add('reference', reference))
        .toString();
  }
}

class SenderRecordBuilder
    implements Builder<SenderRecord, SenderRecordBuilder> {
  _$SenderRecord _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _accNo;
  String get accNo => _$this._accNo;
  set accNo(String accNo) => _$this._accNo = accNo;

  String _bank;
  String get bank => _$this._bank;
  set bank(String bank) => _$this._bank = bank;

  String _remitter;
  String get remitter => _$this._remitter;
  set remitter(String remitter) => _$this._remitter = remitter;

  String _ifsc;
  String get ifsc => _$this._ifsc;
  set ifsc(String ifsc) => _$this._ifsc = ifsc;

  String _branch;
  String get branch => _$this._branch;
  set branch(String branch) => _$this._branch = branch;

  String _country;
  String get country => _$this._country;
  set country(String country) => _$this._country = country;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  SenderRecordBuilder() {
    SenderRecord._initializeBuilder(this);
  }

  SenderRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _accNo = $v.accNo;
      _bank = $v.bank;
      _remitter = $v.remitter;
      _ifsc = $v.ifsc;
      _branch = $v.branch;
      _country = $v.country;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SenderRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SenderRecord;
  }

  @override
  void update(void Function(SenderRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SenderRecord build() {
    final _$result = _$v ??
        new _$SenderRecord._(
            name: name,
            accNo: accNo,
            bank: bank,
            remitter: remitter,
            ifsc: ifsc,
            branch: branch,
            country: country,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// To parse this JSON data, do
//
//     final productList = productListFromJson(jsonString);

import 'dart:convert';

ProductList productListFromJson(String str) => ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  ProductList({
    this.pdtId,
    this.pdtName,
    this.pdtCode,
    this.groupid,
    this.brandid,
    this.unitid,
    this.tax,
    this.purchaserate,
    this.mrp,
    this.discountprice,
    this.minimumstock,
    this.openingstock,
    this.narration,
    this.currentstock,
    this.batchid,
    this.hsncode,
    this.imagpath,
    this.forpos,
    this.forecommerce,
    this.forreseller,
    this.searchcode,
    this.aed,
    this.usd,
  });

  int pdtId;
  String pdtName;
  String pdtCode;
  int groupid;
  int brandid;
  String unitid;
  int tax;
  double purchaserate;
  double mrp;
  double discountprice;
  int minimumstock;
  int openingstock;
  String narration;
  String currentstock;
  int batchid;
  String hsncode;
  String imagpath;
  String forpos;
  String forecommerce;
  String forreseller;
  String searchcode;
  int aed;
  int usd;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    pdtId: json["pdt_id"],
    pdtName: json["pdt_name"],
    pdtCode: json["pdt_code"],
    groupid: json["groupid"],
    brandid: json["brandid"],
    unitid: json["unitid"].toString(),
    tax: json["tax"],
    purchaserate: json["purchaserate"].toDouble(),
    mrp: json["mrp"].toDouble(),
    discountprice: json["discountprice"].toDouble(),
    minimumstock: json["minimumstock"],
    openingstock: json["openingstock"],
    narration: json["narration"].toString(),
    currentstock: json["currentstock"].toString(),
    batchid: json["batchid"],
    hsncode: json["hsncode"].toString(),
    imagpath: json["imagpath"],
    forpos: json["forpos"],
    forecommerce: json["forecommerce"],
    forreseller: json["forreseller"],
    searchcode: json["searchcode"],
    aed: json["aed"],
    usd: json["usd"],
  );

  Map<String, dynamic> toJson() => {
    "pdt_id": pdtId,
    "pdt_name": pdtName,
    "pdt_code": pdtCode,
    "groupid": groupid,
    "brandid": brandid,
    "unitid": unitid,
    "tax": tax,
    "purchaserate": purchaserate,
    "mrp": mrp,
    "discountprice": discountprice,
    "minimumstock": minimumstock,
    "openingstock": openingstock,
    "narration": narration,
    "currentstock": currentstock,
    "batchid": batchid,
    "hsncode": hsncode,
    "imagpath": imagpath,
    "forpos": forpos,
    "forecommerce": forecommerce,
    "forreseller": forreseller,
    "searchcode": searchcode,
    "aed": aed,
    "usd": usd,
  };
}

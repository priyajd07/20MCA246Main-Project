// To parse this JSON data, do
//
//     final customerList = customerListFromJson(jsonString);

import 'dart:convert';

CustomerList customerListFromJson(String str) => CustomerList.fromJson(json.decode(str));

String customerListToJson(CustomerList data) => json.encode(data.toJson());

class CustomerList {
  CustomerList({
    this.customerid,
    this.customername,
    this.customercode,
    this.address,
    this.email,
    this.phonenumber,
    this.username,
    this.pass,
    this.website,
    this.state,
    this.country,
    this.vatno,
    this.openingbalance,
    this.customerbalance,
    this.customeraccount,
    this.branchid,
    this.crlimit,
    this.points,
    this.ledgerid,
    this.ledgername,
    this.accountgroup,
    this.rootid,
    this.interestcalculation,
    this.creditordebit,
    this.narration,
    this.currentbalance,
  });

  int customerid;
  String customername;
  String customercode;
  String address;
  String email;
  String phonenumber;
  String username;
  String pass;
  String website;
  String state;
  String country;
  String vatno;
  int openingbalance;
  int customerbalance;
  int customeraccount;
  int branchid;
  int crlimit;
  double points;
  int ledgerid;
  String ledgername;
  int accountgroup;
  int rootid;
  int interestcalculation;
  String creditordebit;
  String narration;
  double currentbalance;

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
    customerid: json["customerid"],
    customername: json["customername"].toString(),
    customercode: json["customercode"].toString(),
    address: json["address"].toString(),
    email: json["email"],
    phonenumber: json["phonenumber"].toString(),
    username: json["username"],
    pass: json["pass"].toString(),
    website: json["website"],
    state: json["state"],
    country: json["country"].toString(),
    vatno: json["vatno"].toString(),
    openingbalance: json["openingbalance"],
    customerbalance: json["customerbalance"],
    customeraccount: json["customeraccount"],
    branchid: json["branchid"],
    crlimit: json["crlimit"],
    points: json["points"].toDouble(),
    ledgerid: json["ledgerid"],
    ledgername: json["ledgername"].toString(),
    accountgroup: json["accountgroup"],
    rootid: json["rootid"],
    interestcalculation: json["interestcalculation"],
    creditordebit: json["creditordebit"],
    narration: json["narration"],
    currentbalance: json["currentbalance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "customerid": customerid,
    "customername": customername,
    "customercode": customercode,
    "address": address,
    "email": email,
    "phonenumber": phonenumber,
    "username": username,
    "pass": pass,
    "website": website,
    "state": state,
    "country": country,
    "vatno": vatno,
    "openingbalance": openingbalance,
    "customerbalance": customerbalance,
    "customeraccount": customeraccount,
    "branchid": branchid,
    "crlimit": crlimit,
    "points": points,
    "ledgerid": ledgerid,
    "ledgername": ledgername,
    "accountgroup": accountgroup,
    "rootid": rootid,
    "interestcalculation": interestcalculation,
    "creditordebit": creditordebit,
    "narration": narration,
    "currentbalance": currentbalance,
  };
}

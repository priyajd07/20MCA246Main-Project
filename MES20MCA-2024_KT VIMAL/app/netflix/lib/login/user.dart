// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String id;
   String photoUrl;
   String phoneNo;
   String displayName;
   List wishlist;
  List bag;
  List b2cBag;
  String branchId;
  String zone;
  bool b2b;
  bool mcc;
  bool ext;
  String ebZone;
  bool ebMcc;
  bool ebExt;
  String referralCode;
  double referralCommission;
  String state;
  double wallet;
  String group;
  String gst;
  String pinCode;



   User(
      {this.phoneNo,
      this.id,
      this.photoUrl,
      this.email,
      this.displayName,
        this.wishlist,
        this.bag,
        this.b2cBag,
        this.branchId,
        this.b2b,
        this.zone,
        this.mcc,
        this.ext,
        this.referralCode,
        this.referralCommission,
        this.state,
        this.wallet,
        this.group,
        this.gst,
        this.ebExt,
        this.ebMcc,
        this.ebZone,
        this.pinCode,


     });

  factory User.fromDocument(DocumentSnapshot document) {
   bool b2bUser=false;
   String ebZone='';
   bool ebMcc=false;
   bool ebExt=false;
   bool mcc=false;
   bool ext=false;
   String referralCode="";
   String state="";
   String group="";
   String gst="";
   String pinCode="";
   try{
     group=document['group'];
   }
   catch(err){
     print(err.toString());
   }
   try{
     pinCode=document['pinCode'];
   }
   catch(err){
     print(err.toString());
   }
   try{
     gst=document['gst'];
   }
   catch(err){
     print(err.toString());
   }
   List b2cBag=[];
   double wallet=0;

   try{
     b2bUser=document['b2b'];
     mcc=document['mcc'];
     ext=document['ext'];
   }
   catch(err){
     print(err.toString());
   }
   String zone='';
   try{
     zone=document['zone'];
   }
   catch(err){
     print(err.toString());
   }
   try{
     ebZone=document['ebZone'];
     ebMcc=document['ebMcc'];
     ebExt=document['ebExtension'];
   }
   catch(err){
     print(err.toString());
   }


   try{
     state=document['state'];
     b2cBag=document['b2cBag'];
   }
   catch(err){
     print(err.toString());
   }
try{
  referralCode=document['referralCode'];
}
catch(err){
  print(err.toString());
}
try{
     wallet=double.tryParse(document['wallet'].toString())??0;
}
catch(err){
  print(err.toString());
}
   double referralCommission=0;
   try{
     referralCommission=document['referralCommission'];
   }
   catch(err){
     print(err.toString());
   }
    return User(
      email: document['email'],
      phoneNo: document['mobileNumber']!='0'?document['mobileNumber']:'Add Phone',
      photoUrl: document['photoUrl'],
      id: document['userId'],
      displayName: document['fullName'],
      wishlist: document['wishlist'],
      bag: document['bag'],
      b2cBag: b2cBag,
      branchId:"XaGJz72DaZdJ4S9g7PkO",
      b2b: b2bUser,
      zone: zone,
      mcc: mcc,
        ext:ext,
        referralCode:referralCode,
        state:state,
      wallet: wallet,
      referralCommission: referralCommission,
      group: group,
      gst: gst,
      ebExt: ebExt,
      ebMcc: ebMcc,
      ebZone: ebZone,
      pinCode: pinCode,

    );
  }
}

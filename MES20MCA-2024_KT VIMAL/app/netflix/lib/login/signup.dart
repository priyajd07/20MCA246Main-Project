//@dart=2.9
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:netflix/login/userService.dart';
import '../main.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailTextController;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController passwordTextController;
  bool passwordVisibility1;
  TextEditingController textController3;
  bool passwordVisibility2;
  bool checkboxListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String,String> userValues =  Map<String, String>();
  UserService _userService = new UserService();
  final auth =FirebaseAuth.instance;
  String otp="";
  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordTextController = TextEditingController();
    passwordVisibility1 = false;
    textController3 = TextEditingController();
    passwordVisibility2 = false;
    checkboxListTileValue=true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Text('Sign Up',style: GoogleFonts.nunito(
                  fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white
              ),),
              SizedBox(height: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.075,bottom: 5),
                    child: Text('Name',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w600,color: Colors.white
                    ),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.red,
                          )
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: textController1,
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.normal,
                                color: Colors.black
                            )
                        ),
                        decoration:
                        InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          fillColor:Color(0xffF1E5FF),
                          hintText: 'Enter your name',
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.normal,
                                  color: Colors.black
                                      .withOpacity(
                                      0.250))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          filled: true,
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //     borderSide: BorderSide(color: Colors.yellow)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.075,bottom: 5),
                    child: Text('Email',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w600,color: Colors.white
                    ),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.red,
                          )
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: emailTextController,
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.normal,
                                color: Colors.black
                            )
                        ),
                        decoration:
                        InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          fillColor:Color(0xffF1E5FF),
                          hintText: 'Enter Email',
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.normal,
                                  color: Colors.black
                                      .withOpacity(
                                      0.250))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          filled: true,
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //     borderSide: BorderSide(color: Colors.yellow)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.075,bottom: 5),
                    child: Text('Phone No',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w600,color: Colors.white
                    ),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.red,
                          )
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: textController2,

                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight.normal,
                                      color: Colors.black
                                  )
                              ),

                              decoration:
                              InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                fillColor:Color(0xffF1E5FF),
                                hintText: 'Enter phone number',
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.normal,
                                        color: Colors.black
                                            .withOpacity(
                                            0.250))
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(9),
                                    borderSide: BorderSide(
                                        color: Color
                                            .fromRGBO(
                                            42,
                                            172,
                                            146,
                                            0.0))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(9),
                                    borderSide: BorderSide(
                                        color: Color
                                            .fromRGBO(
                                            42,
                                            172,
                                            146,
                                            0.0))),
                                filled: true,
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(20),
                                //     borderSide: BorderSide(color: Colors.yellow)),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.075,bottom: 5),
                    child: Text('Password',style:TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w600,color: Colors.white
                    ),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.red,
                          )
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: passwordTextController,
                        obscureText: !passwordVisibility1,
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.normal,
                                color: Colors.black
                            )
                        ),

                        decoration:
                        InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          fillColor:Color(0xffF1E5FF),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                                  () => passwordVisibility1 =
                              !passwordVisibility1,
                            ),
                            child: Icon(
                              passwordVisibility1
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.black,
                              size: 22,
                            ),
                          ),
                          hintText: 'Enter Password',
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.normal,
                                  color: Colors.black
                                      .withOpacity(
                                      0.250))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          filled: true,
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //     borderSide: BorderSide(color: Colors.yellow)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.075,bottom: 5),
                    child: Text('Confirm Password',style:TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w600,color: Colors.white
                    ),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.red,
                          )
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: textController3,
                        obscureText: !passwordVisibility2,
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.normal,
                                color: Colors.black
                            )
                        ),

                        decoration:
                        InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          fillColor:Color(0xffF1E5FF),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                                  () => passwordVisibility2 =
                              !passwordVisibility2,
                            ),
                            child: Icon(
                              passwordVisibility2
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.black,
                              size: 22,
                            ),
                          ),
                          hintText: 'Enter Password',
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.normal,
                                  color: Colors.black
                                      .withOpacity(
                                      0.250))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          filled: true,
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //     borderSide: BorderSide(color: Colors.yellow)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('By clicking Sign Up You agree to share your information. Also agree with our terms and conditions',style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600,color: Colors.white
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: () async {

                  if(textController1.text!=''&&emailTextController.text!=''&&textController2.text!=''&&textController2.text.length>9&&textController3.text!=''&&passwordTextController.text!=''){
                    try {
                      UserCredential newUser =  await auth.createUserWithEmailAndPassword(
                          email: emailTextController.text, password: passwordTextController.text);
                      if (newUser != null) {
                        FirebaseFirestore.instance.collection('users').doc(newUser.user.uid).set({
                          'email': emailTextController.text,
                          'display_name':textController1.text,
                          'phone_number':textController2.text,
                          'photo_url':'',
                          'uid':newUser.user.uid,
                          'playList':[],
                          // 'cmfPassword': .text,
                          // 'password': password.text,
                        });
                        showUploadMessage(context, 'User Registered Successfully');

                        Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => Login()),
                        );

                      }
                    }
                    catch (e)
                    {
                      print(e);
                    }
                  }else if(textController1.text==''||emailTextController.text==''||textController2.text==''||textController3.text==''||passwordTextController.text==''){
                    showInSnackBar('All fields are required', primaryColor);
                  }else if(textController2.text.length<10){
                    showInSnackBar('Badly formatted mobile number', primaryColor);
                  }

                },
                child: Container(
                  height: 35,width: 100,
                  decoration: BoxDecoration(
                  color: Colors.red,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Sign Up',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,
                      ),),
                      Icon(Icons.arrow_forward,color: Colors.white,size: 16,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  signUpUser() async {
    print(emailTextController.text);
    if (checkboxListTileValue) {
      if (passwordTextController.text == textController3.text) {
        userValues['fullName'] = textController1.text;
        userValues['email'] = emailTextController.text;
        userValues['mobileNumber'] = textController2.text;
        userValues['password'] = passwordTextController.text;
        bool connectionStatus = true;
        if (connectionStatus) {
          // bool result=await showDialog(
          //     context: context,
          //     builder: (context) {
          //       reqOtp();
          //
          //       return AlertDialog(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(
          //                 24.0)
          //         ),
          //         title: Text('Verify Your Number'),
          //         content: Text(
          //             'please enter the otp and submit to signup'),
          //         actions: <Widget>[
          //           TextFormField(
          //             controller: otp,
          //             decoration: const InputDecoration(labelText: "Verification code"),
          //           ),
          //
          //           FlatButton(
          //             onPressed: () async {
          //               bool verify=await verifyOtp();
          //               Navigator.of(context, rootNavigator: true).pop(verify);
          //             },
          //             child: Text(
          //                 'Submit',
          //                 style: TextStyle(
          //                     fontSize: 18.0,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.red
          //                 )
          //             ),
          //           )
          //         ],
          //       );
          //     }
          // );
          if (true) {
            await _userService.signup(userValues, context);

            int statusCode = _userService.statusCode;
            if (statusCode == 200) {
              showInSnackBar('Sign Up Successful', Colors.black);
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Login()
                ),

              );
            } else {
              Navigator.pop(context);
            }
          }
        }
        else {

        }
      }
      else{
        showInSnackBar('Password & Confirm Password does not match', Colors.black);
      }

    }
    else{
      showInSnackBar('please read and agree terms & conditions', Colors.black);
    }
  }
  void showInSnackBar(String msg, Color color) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: new Text(msg),
        action: SnackBarAction(
          label:'Close',
          textColor: Colors.white,
          onPressed: (){
            if(mounted) {
              ScaffoldMessenger.of(context).clearSnackBars();
            }
          },
        ),
      ),
    );
  }
}

//@dart=2.9


import 'package:cloud_firestore/cloud_firestore.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth/auth_util.dart';
import 'main.dart';

class EditWidget extends StatefulWidget {
  const EditWidget({Key key}) : super(key: key);

  @override
  _EditWidgetState createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  TextEditingController name;
  TextEditingController phone1;
  TextEditingController phone2;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: currentUserDisplayName);
    phone1 = TextEditingController(text: currentPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('Edit Profile',style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,fontSize: 18
          ),),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: name,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF57636C),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                hintText: 'Name',
                hintStyle: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF57636C),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFDBE2E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFDBE2E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
              ),
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF1D2429),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: phone1,
              keyboardType: TextInputType.phone,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Phone No',
                labelStyle: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF57636C),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                hintText: 'Enter your Phone No...',
                hintStyle: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF57636C),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFDBE2E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFDBE2E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
              ),
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF1D2429),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: InkWell(
              onTap: () {


               if(name.text!=''){
                 FirebaseFirestore.instance.collection('users')
                     .doc(currentUserUid)
                     .update({
                   'display_name':name.text,
                   'phone_number':phone1.text
                 });
                 Navigator.pop(context);
                 showUploadMessage(context, 'Profile Updated...');
               }else{
                 name.text==''?
                 showUploadMessage(context, 'Please Enter Name'):
                 showUploadMessage(context, 'Please Enter Phone Number');
               }

              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
                ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25,10,25,10),
                    child: Text('Update',style: TextStyle(
                      fontWeight: FontWeight.bold,color: Colors.white
                    ),),
                  )),

            ),
          ),
        ],
      ),
    );
  }
}

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:MovieFlix_admin/flutter_flow/upload_media.dart';

import '../auth/email_auth.dart';
import '../auth/google_auth.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../home/Home.dart';



class SigninWidget extends StatefulWidget {
  const SigninWidget({Key key}) : super(key: key);

  @override
  _SigninWidgetState createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  TextEditingController userName;
  TextEditingController password;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    password = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(

          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 420,
                      height: 450,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 140,
                                    height: 50,
                                    decoration: BoxDecoration(),
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Text(
                                      'Login',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                              child: TextFormField(
                                controller: userName,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: 'Please Enter Email',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
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
                                  contentPadding:
                                  EdgeInsetsDirectional.fromSTEB(
                                      24, 24, 20, 24),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF1D2429),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                              child: TextFormField(
                                controller: password,
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: 'Please Enter Password',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
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
                                  contentPadding:
                                  EdgeInsetsDirectional.fromSTEB(
                                      24, 24, 20, 24),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                          () => passwordVisibility =
                                      !passwordVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF757575),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF1D2429),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                // ogPass=password.text;
                                // ogUser=userName.text;
                                final user = await signInWithEmail(
                                  context,
                                  userName.text,
                                  password.text,
                                );
                                if (user == null) {
                                  return;
                                }

                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                      (r) => false,
                                );                              },
                              text: 'Login',
                              options: FFButtonOptions(
                                width: 150,
                                height: 50,
                                color: Color(0xFF2CA899),
                                // color: Color(0xFF2CA899),
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                elevation: 2,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 15, 0, 20),
                              child: Text(
                                'Forgot Password',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 12
                                ),
                              ),
                            ),
                            // Generated code for this Row Widget...
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 50,
                                  fillColor: Color(0xFFDBE2E7),
                                  icon: FaIcon(
                                    FontAwesomeIcons.google,
                                    color: Color(0xFF57636C),
                                    size: 20,
                                  ),
                                  onPressed: () async {
                                    final user = await signInWithGoogle(context);
                                    if (user == null) {
                                      return;
                                    }

                                    await Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(),
                                      ),
                                          (r) => false,
                                    );
                                  },
                                ),
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 50,
                                  fillColor: Color(0xFFDBE2E7),
                                  icon: FaIcon(
                                    FontAwesomeIcons.apple,
                                    color: Color(0xFF57636C),
                                    size: 20,
                                  ),
                                  onPressed: ()  {

                                    showUploadMessage(context, 'Apple Login Not Available at this moment...');

                                  }

                                ),
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 50,
                                  fillColor: Color(0xFFDBE2E7),
                                  icon: FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    color: Color(0xFF57636C),
                                    size: 20,
                                  ),
                                  onPressed: ()  {
                                    showUploadMessage(context, 'Facebook Login Not Available at this moment...');

                                  },
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/log.gif',

                      fit: BoxFit.cover,


                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

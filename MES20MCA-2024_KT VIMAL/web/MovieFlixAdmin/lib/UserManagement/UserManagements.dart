import 'package:MovieFlix_admin/backend/backend.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_widgets.dart';

class UsersViewWidget extends StatefulWidget {
  const UsersViewWidget({Key key}) : super(key: key);

  @override
  _UsersViewWidgetState createState() => _UsersViewWidgetState();
}

class _UsersViewWidgetState extends State<UsersViewWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users')
      .orderBy('created_time',descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        var data=snapshot.data.docs;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xFFF1F4F8),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 54,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF57636C),
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Members List',
              style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Poppins',
                color: Color(0xFF1D2429),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: Color(0xFFF1F4F8),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: 700,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4, 0, 4, 0),
                                child: TextFormField(
                                  controller: textController,
                                  obscureText: false,
                                  onChanged: (text){


                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Search',
                                    labelStyle:
                                    FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF57636C),
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight.normal,
                                    ),
                                    hintText: 'Please Enter Name',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF262D34),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 8, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  textController.clear();


                                  setState(() {

                                  });

                                },
                                text: 'Clear',
                                options: FFButtonOptions(
                                  width: 100,
                                  height: 40,
                                  color: Color(0xFF4B39EF),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                    child: Text(
                      'Available Members ( ${data.length.toString()} )',
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 5,
                    runSpacing: 0,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: List.generate(data.length, (index) {
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 12, 10, 12),
                        child: Container(
                          width: 250,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x34090F13),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    imageUrl:data[index]['photo_url'],

                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,

                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Text(
                                    data[index]['display_name'],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF1D2429),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                  child: Text(
                                    data[index]['email'],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF57636C),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

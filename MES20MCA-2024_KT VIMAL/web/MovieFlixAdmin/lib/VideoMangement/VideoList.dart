import 'package:MovieFlix_admin/backend/backend.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'VideoPlayer.dart';
import 'ViewPage.dart';

class VideoManagmentWidget extends StatefulWidget {
  const VideoManagmentWidget({Key key}) : super(key: key);

  @override
  _VideoManagmentWidgetState createState() => _VideoManagmentWidgetState();
}

class _VideoManagmentWidgetState extends State<VideoManagmentWidget> {
  TextEditingController searchFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    searchFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Videos',
          style: FlutterFlowTheme.of(context).title1.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF090F13),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: Column(
        mainAxisSize: MainAxisSize.max,
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
                          controller: searchFieldController,
                          obscureText: false,
                          onChanged: (text){

                            setState((){

                            });


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
                            hintText: 'Please Enter Movie Name',
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
                          searchFieldController.clear();


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
          searchFieldController.text==''?
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('movie').orderBy('date',descending: true).snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);

              }
              var data=snapshot.data.docs;
              return Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 0,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: List.generate(data.length, (index) {
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                              id: data[index].id,
                              url: data[index]['video'],
                            )));
                          },
                          child: Container(
                            width: 400,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  data[index]['thumbnail'],
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0x65090F13),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              data[index]['title'],
                                              style: FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          data[index]['prime']==true?
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 15,
                                            borderWidth: 1,
                                            buttonSize: 45,
                                            fillColor: Colors.white,
                                            icon: FaIcon(
                                              FontAwesomeIcons.crown,
                                              color: Color(0xFFD2BC16),
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ):Container()

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              'Type : '+data[index]['type'],
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    data[index]['description'].toString().length<40?
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              data[index]['description'],
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ):
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              data[index]['description'].toString().substring(0,40)+'...',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              'Genres : '+data[index]['generes'].toString().substring(1,data[index]['generes'].toString().length-1),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              'Language : '+data[index]['language'].toString(),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.star_rounded,
                                                  color: Color(0xFFFFA130),
                                                  size: 24,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                                  child: Text(
                                                    '4.5',
                                                    style: FlutterFlowTheme.of(context).subtitle1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(16, 4, 16, 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer(
                                                  url: data[index]['video'],
                                                )));

                                              },
                                              text: 'Play',
                                              icon: Icon(
                                                Icons.play_arrow,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              options: FFButtonOptions(
                                                width: 120,
                                                height: 50,
                                                color: Colors.white,
                                                textStyle: GoogleFonts.getFont(
                                                  'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold
                                                ),
                                                elevation: 3,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 8,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                        0, 0, 0, 4),
                                                    child: Text(
                                                      data[index]['duration'],
                                                      style: FlutterFlowTheme.of(context)
                                                          .title3
                                                          .override(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    dateTimeFormat('MMM-d-y', data[index]['date'].toDate()),
                                                    textAlign: TextAlign.end,
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                  ),
                ),
              );
            }
          ):
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('movie')
            .where('search',arrayContains: searchFieldController.text.toUpperCase())
                .orderBy('date',descending: true).snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);

              }
              var data=snapshot.data.docs;
              return data.length==0?Center(child: Image.asset('assets/images/noMovie.gif',height: 350,)): Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 0,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: List.generate(data.length, (index) {
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                              id: data[index].id,
                              url: data[index]['video'],
                            )));
                          },
                          child: Container(
                            width: 400,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  data[index]['thumbnail'],
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0x65090F13),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              data[index]['title'],
                                              style: FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          data[index]['prime']==true?
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 15,
                                            borderWidth: 1,
                                            buttonSize: 45,
                                            fillColor: Colors.white,
                                            icon: FaIcon(
                                              FontAwesomeIcons.crown,
                                              color: Color(0xFFD2BC16),
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ):Container()

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              'Type : '+data[index]['type'],
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    data[index]['description'].toString().length<40?
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              data[index]['description'],
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ):
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              data[index]['description'].toString().substring(0,40)+'...',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              'Genres : '+data[index]['generes'].toString().substring(1,data[index]['generes'].toString().length-1),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(

                                              'Language : '+data[index]['language'].toString(),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.star_rounded,
                                                  color: Color(0xFFFFA130),
                                                  size: 24,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                                  child: Text(
                                                    '4.5',
                                                    style: FlutterFlowTheme.of(context).subtitle1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(16, 4, 16, 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer(
                                                  url: data[index]['video'],
                                                )));

                                              },
                                              text: 'Play',
                                              icon: Icon(
                                                Icons.play_arrow,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              options: FFButtonOptions(
                                                width: 120,
                                                height: 50,
                                                color: Colors.white,
                                                textStyle: GoogleFonts.getFont(
                                                  'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold
                                                ),
                                                elevation: 3,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 8,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                        0, 0, 0, 4),
                                                    child: Text(
                                                      data[index]['duration'],
                                                      style: FlutterFlowTheme.of(context)
                                                          .title3
                                                          .override(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    dateTimeFormat('MMM-d-y', data[index]['date'].toDate()),
                                                    textAlign: TextAlign.end,
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}

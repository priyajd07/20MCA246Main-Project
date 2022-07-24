import 'package:MovieFlix_admin/backend/backend.dart';
import 'package:MovieFlix_admin/flutter_flow/upload_media.dart';
import 'package:MovieFlix_admin/home/Home.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'EditVideo.dart';

class MovieViewWidget extends StatefulWidget {
  final String id;
  final String url;
  const MovieViewWidget({Key key, this.id, this.url}) : super(key: key);

  @override
  _MovieViewWidgetState createState() => _MovieViewWidgetState();
}

class _MovieViewWidgetState extends State<MovieViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DocumentSnapshot data;

  deleteVideo() async {
    QuerySnapshot snap=await FirebaseFirestore.instance.collection('users').where('playList',arrayContains: widget.id).get();

    for(DocumentSnapshot doc in snap.docs){
      doc.reference.update({
        'playList':FieldValue.arrayRemove([widget.id]),
      });
    }

    data.reference.delete();

    showUploadMessage(context, 'Deleted Successfully....');

    Navigator.pop(context);
    Navigator.pop(context);

    if(mounted){
      setState((){

      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').doc(widget.id).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        data=snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            automaticallyImplyLeading: true,
            title: Text(
              'Details',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton( icon: Icon(Icons.delete,color: Colors.red,),
              onPressed:(){

                showDialog(context: context, builder: (buildContex){
                  return  AlertDialog(
                    title: Text('Delete Video'),
                    content: Text('Do you want to Delete'),
                    actions: [
                      TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
                      TextButton(onPressed: ()=>deleteVideo(), child: Text('Delete')),
                    ],
                  );

                });
                
              }),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditMoviesWidget(
                      id: data.id,
                    )));
                  },
                    child: Icon(Icons.edit)),
              ),
            ],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowVideoPlayer(
                  path:
                  widget.url  ,
                  videoType: VideoType.network,
                  height: 400,
                  width: 1000,
                  autoPlay: false,
                  looping: false,
                  showControls: true,
                  allowFullScreen: true,
                  allowPlaybackSpeedMenu: false,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        data['title'],
                        style: FlutterFlowTheme.of(context).title2.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 50,),
                      data['prime']==true?
                      FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Premium',
                        icon: FaIcon(
                          FontAwesomeIcons.crown,
                          size: 20,
                        ),
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: Color(0xFFD2BC16),
                          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ):Container(),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          data['description'],
                          style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           'Date : '+ dateTimeFormat('MMM-d-y', data['date'].toDate()),
                            textAlign: TextAlign.end,
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xFFF1F4F8),
                          elevation: 2,
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(6, 2, 6, 2),
                            child: Text(
                              'Duration : '+data['duration'],
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF090F13),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Text('Genres : ',style: FlutterFlowTheme.of(context)
                        .bodyText1
                        .override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),),
                    Row(children: List.generate(data['generes'].length, (index) {
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF1F4F8),
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(6, 2, 6, 2),
                          child: Text(
                            data['generes'][index],
                            style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF090F13),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      );

                    }),),

                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Text('Category : ',style: FlutterFlowTheme.of(context)
                        .bodyText1
                        .override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),),
                    Row(children: List.generate(1, (index) {
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF1F4F8),
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(6, 2, 6, 2),
                          child: Text(
                            categoryName[data['category']],
                            style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF090F13),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      );

                    }),),

                  ],),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

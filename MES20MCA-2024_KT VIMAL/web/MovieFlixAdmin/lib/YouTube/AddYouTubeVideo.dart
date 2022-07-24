import 'package:MovieFlix_admin/backend/backend.dart';
import 'package:MovieFlix_admin/flutter_flow/upload_media.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_drop_down_template.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'EditYouTubeVideo.dart';

class AddYouTubeVideo extends StatefulWidget {
  const AddYouTubeVideo({Key key}) : super(key: key);

  @override
  _AddYouTubeVideoState createState() => _AddYouTubeVideoState();
}

class _AddYouTubeVideoState extends State<AddYouTubeVideo> {

  TextEditingController link;
  TextEditingController title;
  String thumbnail='';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List<String>();
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }

  @override
  void initState() {
    super.initState();
    link = TextEditingController();
    title = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F4F8),
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'YouTube',
          style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                labelColor: FlutterFlowTheme.of(context).primaryColor,
                labelStyle: FlutterFlowTheme.of(context).bodyText1,
                indicatorColor: FlutterFlowTheme.of(context).secondaryColor,
                tabs: [
                  Tab(
                    text: 'Add',
                  ),
                  Tab(
                    text: 'Edit',
                  ),

                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 330,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16, 0, 0, 0),
                                    child: TextFormField(
                                      controller: title,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Title',
                                        labelStyle: FlutterFlowTheme
                                            .of(context).bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'Please Enter Title',
                                        hintStyle: FlutterFlowTheme
                                            .of(context).bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                          const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(4.0),
                                            topRight:
                                            Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                          const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(4.0),
                                            topRight:
                                            Radius.circular(4.0),
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyText2
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 330,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16, 0, 0, 0),
                                    child: TextFormField(
                                      controller: link,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Link',
                                        labelStyle: FlutterFlowTheme
                                            .of(context).bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                          hintText: 'Please Paste Video Link',
                                        hintStyle: FlutterFlowTheme
                                            .of(context).bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                          const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(4.0),
                                            topRight:
                                            Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                          const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(4.0),
                                            topRight:
                                            Radius.circular(4.0),
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyText2
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                          thumbnail==''?
                          Container():
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [

                                CachedNetworkImage(
                                  imageUrl:thumbnail,
                                  width: 200,
                                  height: 110,
                                  color: Colors.black,
                                  colorBlendMode: BlendMode.saturation,
                                  fit: BoxFit.cover,
                                ),


                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {

                                final selectedMedia = await selectMedia(
                                  maxWidth: 1080.00,
                                  maxHeight: 1320.00,
                                );
                                if (selectedMedia != null &&
                                    validateFileFormat(
                                        selectedMedia.storagePath, context)) {
                                  showUploadMessage(context, 'Uploading file...',
                                      showLoading: true);
                                  final downloadUrl = await uploadData(
                                      selectedMedia.storagePath,
                                      selectedMedia.bytes);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  if (downloadUrl != null) {

                                    setState(
                                            () {

                                          thumbnail = downloadUrl;
                                        } );
                                    showUploadMessage(context, 'Thumbnail Uploaded...');
                                  } else {
                                    showUploadMessage(
                                        context, 'Failed to upload media');
                                  }
                                }

                              },
                              text: thumbnail==''?'Choose Thumbnail':'Change Thumbnail',
                              options: FFButtonOptions(
                                width: 270,
                                height: 50,
                                color: thumbnail!=''?Colors.teal: Color(0xFF0F1113),
                                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 8,
                              ),
                            ),
                          ),


                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () {

                                if(title.text!=''&&link.text!=''&&thumbnail!=''){
                                  showDialog(context: context, builder: (buildContext){
                                    return AlertDialog(
                                      title: Text('Add Video'),
                                      content: Text('Do you want to Continue ?'),
                                      actions: [
                                        TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
                                        TextButton(onPressed: (){

                                          FirebaseFirestore.instance.collection('youtube').add({
                                            'title':title.text,
                                            'link':link.text,
                                            'thumbnail':thumbnail,
                                            'date':DateTime.now(),
                                            'search':setSearchParam(title.text),
                                          });
                                          Navigator.pop(context);
                                          // Navigator.pop(context);


                                          showUploadMessage(context, 'New Video Added....');

                                          setState(() {
                                            title.clear();
                                            link.clear();
                                            thumbnail='';
                                          });

                                        }, child: Text('Ok')),
                                      ],
                                    );
                                  });

                                }else{
                                  title.text==''?showUploadMessage(context, 'Please Enter Title'):
                                  link.text==''?showUploadMessage(context, 'Please Paste Video Url'):
                                      showUploadMessage(context, 'Please Choose Thumbnail');
                                }



                              },
                              text: 'Upload Video',
                              options: FFButtonOptions(
                                width: 270,
                                height: 50,
                                color: Color(0xFF0F1113),
                                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('youtube')
                        .orderBy('date',descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          var data=snapshot.data.docs;
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (buildContex,int index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditYouTubeVideo(id: data[index].id,)));
                                        },
                                        onLongPress: (){
                                          showDialog(context: context, builder: (buildContext){
                                            return AlertDialog(
                                              title: Text('Delete Video'),
                                              content: Text('Do you want to Continue ?'),
                                              actions: [
                                                TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
                                                TextButton(onPressed: (){

                                                  data[index].reference.delete();
                                                  Navigator.pop(context);
                                                  showUploadMessage(context, 'Video Deleted...');

                                                }, child: Text('Delete')),
                                              ],
                                            );
                                          });
                                        },
                                        child: Container(
                                            height: 80,
                                            child: Center(child: Text(data[index]['title'],style: TextStyle(fontWeight: FontWeight.bold),))),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
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

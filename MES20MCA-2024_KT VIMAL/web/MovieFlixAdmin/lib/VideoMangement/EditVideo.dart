import 'package:MovieFlix_admin/backend/backend.dart';
import 'package:MovieFlix_admin/backend/firebase_storage/storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:multiselect_dropdown/multiple_dropdown.dart';
import 'package:multiselect_dropdown/multiple_select.dart';

import '../flutter_flow/flutter_flow_drop_down_template.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/upload_media.dart';
import '../home/Home.dart';

class EditMoviesWidget extends StatefulWidget {
  final String id;
  const EditMoviesWidget({Key key, this.id}) : super(key: key);

  @override
  _EditMoviesWidgetState createState() => _EditMoviesWidgetState();
}

class _EditMoviesWidgetState extends State<EditMoviesWidget> {
  String seletedLanguage;
  String seletedType;
  String seletedCategory;
  String uploadedFileUrl1='';
  String thumbnail='';
  bool prime=false;
  TextEditingController title;
  TextEditingController description;
  TextEditingController duration;
  TextEditingController emailAddressController3;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<MultipleSelectItem> generes = [];
  List<MultipleSelectItem> related = [];
  List _selectedGeneres = [];
  List _selectedRelatedVideos = [];


  @override
  void initState() {
    super.initState();
    getRelated();
    getLanguages();
    getGeneres();
    title = TextEditingController();
    description = TextEditingController();
    emailAddressController3 = TextEditingController();
    duration = TextEditingController();
  }

  List<String> languages=[];

  Map<String,dynamic> videosName={};

  getLanguages()async{
    QuerySnapshot snap =await FirebaseFirestore.instance.collection('languages').get();
    languages=[];
    for(DocumentSnapshot doc in snap.docs){
      languages.add(doc['name']);
    }

    if(mounted){
      setState(() {

      });
    }
  }

  Future getGeneres() async {
    QuerySnapshot data1 = await FirebaseFirestore.instance
        .collection('generes')
        .get();
    for (DocumentSnapshot week in data1.docs) {
      generes.add(MultipleSelectItem.build(
        value: week['name'],
        display: week['name'].toString(),
        content: week['name'],
      ));
    }
  }

  Future getRelated() async {
    QuerySnapshot data1 = await FirebaseFirestore.instance
        .collection('movie')
        .get();
    for (DocumentSnapshot doc in data1.docs) {

      related.add(MultipleSelectItem.build(
        value: doc.id,
        display: doc['title'].toString(),
        content: doc['title'],
      ));
    }
  }

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

  DocumentSnapshot data;

  bool loaded=false;

  @override
  Widget build(BuildContext context) {

    print(seletedType);

    return languages.length==0?Center(child: CircularProgressIndicator(),):  StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').doc(widget.id).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        data=snapshot.data;
        if(loaded==false){
          loaded=true;
          prime=data['prime'];
          title.text=data['title'];
          duration.text=data['duration'];
          description.text=data['description'];
          seletedCategory=categoryName[data['category']];
          seletedLanguage=data['language'];
          seletedType=data['type'];
          _selectedGeneres=data['generes'];
          _selectedRelatedVideos=data['related'];
          thumbnail=data['thumbnail'];
          uploadedFileUrl1=data['video'];


        }

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xFFF1F4F8),
            iconTheme: IconThemeData(color: Colors.black),
            automaticallyImplyLeading: true,
            title: Text(
              'Edit Videos',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: Color(0xFFF1F4F8),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Generated code for this SwitchListTile Widget...
                  SwitchListTile(
                    value: prime ??= true,
                    onChanged: (newValue) => setState(() => prime = newValue),
                    title: Text(
                      'Prime',
                      style: FlutterFlowTheme.of(context).title3,
                    ),
                    tileColor: Color(0xFFF5F5F5),
                    activeColor: Color(0xFF50D9C3),
                    dense: false,

                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
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
                        SizedBox(width: 20,),


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
                                controller: duration,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Duration',
                                  labelStyle: FlutterFlowTheme
                                      .of(context).bodyText2
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'Please Enter Duration',
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Expanded(
                          child: Container(
                            width: 330,
                            height: 110,
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
                                controller: description,
                                maxLines: 3,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  labelStyle: FlutterFlowTheme
                                      .of(context).bodyText2
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'Please Enter Description',
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

                        Column(
                          children: [
                            Text('Select Category',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                              child: Container(
                                width: 330,
                                height: 60,

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x4D101213),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                  child: FlutterFlowDropDown(
                                    initialOption: seletedCategory ??categories.first,
                                    options: categories,
                                    onChanged: (val) => setState(() {
                                      seletedCategory = val;

                                    }
                                    ),
                                    width: 180,
                                    height: 50,
                                    textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please select...',
                                    fillColor: Colors.white,
                                    elevation: 2,
                                    borderColor: Colors.transparent,
                                    borderWidth: 0,
                                    borderRadius: 8,
                                    margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                    hidesUnderline: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),




                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [

                        Column(
                          children: [
                            Text('Select Language',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                              child: Container(
                                width: 330,
                                height: 60,

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x4D101213),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                  child: FlutterFlowDropDown(
                                    initialOption: seletedLanguage ??languages.first,
                                    options: languages,
                                    onChanged: (val) => setState(() => seletedLanguage = val),
                                    width: 180,
                                    height: 50,
                                    textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please select...',
                                    fillColor: Colors.white,
                                    elevation: 2,
                                    borderColor: Colors.transparent,
                                    borderWidth: 0,
                                    borderRadius: 8,
                                    margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                    hidesUnderline: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children: [
                            Text('Select Type',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                              child: Container(
                                width: 330,
                                height: 60,

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x4D101213),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                  child: FlutterFlowDropDown(
                                    initialOption: seletedType ??'Movie',
                                    options: [
                                      'Movie',
                                      'TV Shows',
                                      'Series',
                                      'Study Materials',
                                    ],
                                    onChanged: (val) => setState(() {
                                      seletedType = val;

                                    }
                                    ),
                                    width: 180,
                                    height: 50,
                                    textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please select...',
                                    fillColor: Colors.white,
                                    elevation: 2,
                                    borderColor: Colors.transparent,
                                    borderWidth: 0,
                                    borderRadius: 8,
                                    margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                    hidesUnderline: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 400,
                          // height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE6E6E6),
                            ),
                          ),
                          child: MultipleDropDown(
                            placeholder: 'Select Generes',
                            disabled: false,
                            values: _selectedGeneres,
                            elements: generes,
                          ),
                        ),


                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [


                        Container(
                          width: 1100,
                          // height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE6E6E6),
                            ),
                          ),
                          child: MultipleDropDown(
                            placeholder: 'Select Related Videos',
                            disabled: false,
                            values: _selectedRelatedVideos,
                            elements: related,
                          ),
                        ),


                      ],
                    ),
                  ),

                  thumbnail==''&&uploadedFileUrl1==''?
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
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
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
                        SizedBox(width: 20,),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {

                              final selectedMedia = await selectMedia(
                                  maxWidth: 1080.00,
                                  maxHeight: 1320.00,
                                  isVideo: true,
                                  mediaSource: MediaSource.videoGallery
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

                                        uploadedFileUrl1 = downloadUrl;
                                      } );
                                  showUploadMessage(context, 'Video Uploaded...');
                                } else {
                                  showUploadMessage(
                                      context, 'Failed to upload media');
                                }
                              }

                            },
                            text: uploadedFileUrl1==''?'Choose Video':'Change Video',
                            options: FFButtonOptions(
                              width: 270,
                              height: 50,
                              color: uploadedFileUrl1!=''?Colors.teal: Color(0xFF0F1113),
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                    child: FFButtonWidget(
                      onPressed: ()  {

                        if(title.text!=''&&description.text!=''&&duration.text!=''&&thumbnail!=''&&uploadedFileUrl1!=''){
                          showDialog(context: context, builder: (buildContext){
                            return AlertDialog(
                              title: Text('Update Video'),
                              content: Text('Do you want to Continue ?'),
                              actions: [
                                TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
                                TextButton(onPressed: (){
                                  data.reference.update({
                                    'title':title.text,
                                    'description':description.text,
                                    'duration':duration.text,
                                    'type':seletedType,
                                    'generes':_selectedGeneres,
                                    'language':seletedLanguage,
                                    'thumbnail':thumbnail,
                                    'video':uploadedFileUrl1,
                                    'prime':prime,
                                    'category':categoryId[seletedCategory],
                                    'related':_selectedRelatedVideos,
                                    'search':setSearchParam(title.text),
                                  });

                                  showUploadMessage(context, 'Video Updated...');
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, child: Text('Ok')),
                              ],
                            );
                          });

                        }else{
                          title.text==''?showUploadMessage(context, 'Please Enter Title'):
                          description.text==''?showUploadMessage(context, 'Please Enter Description'):
                          duration.text==''?showUploadMessage(context, 'Please Enter Duration'):
                          thumbnail==''?showUploadMessage(context, 'Please Upload Thumbnail'):
                          showUploadMessage(context, 'Please Upload Video');
                        }


                      },
                      text: 'Update Video',
                      options: FFButtonOptions(
                        width: 270,
                        height: 50,
                        color: Colors.teal,
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
          ),
        );
      }
    );
  }
}

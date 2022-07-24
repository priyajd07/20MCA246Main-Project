import 'package:MovieFlix_admin/backend/backend.dart';
import 'package:MovieFlix_admin/flutter_flow/upload_media.dart';

import '../flutter_flow/flutter_flow_drop_down_template.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class CreateLanguages extends StatefulWidget {
  const CreateLanguages({Key key}) : super(key: key);

  @override
  _CreateLanguagesState createState() => _CreateLanguagesState();
}

class _CreateLanguagesState extends State<CreateLanguages> {

  TextEditingController languages;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    languages = TextEditingController();

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
          'Languages',
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
                                      controller: languages,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Language',
                                        labelStyle: FlutterFlowTheme
                                            .of(context).bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'Please Enter Language Name',
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () {

                                showDialog(context: context, builder: (buildContext){
                                  return AlertDialog(
                                    title: Text('Add Language'),
                                    content: Text('Do you want to Continue ?'),
                                    actions: [
                                      TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
                                      TextButton(onPressed: (){

                                        FirebaseFirestore.instance.collection('languages').add({
                                          'name':languages.text,
                                        }).then((value) {
                                          value.update({
                                            'id':value.id,
                                          });
                                        });
                                        Navigator.pop(context);


                                        showUploadMessage(context, 'New Language Added....');

                                        setState(() {
                                          languages.clear();
                                        });

                                      }, child: Text('Ok')),
                                    ],
                                  );
                                });


                              },
                              text: 'Upload Langauge',
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
                      stream: FirebaseFirestore.instance.collection('languages').snapshots(),
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
                                  onLongPress: (){
                                    showDialog(context: context, builder: (buildContext){
                                      return AlertDialog(
                                        title: Text('Delete Language'),
                                        content: Text('Do you want to Continue ?'),
                                        actions: [
                                          TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
                                          TextButton(onPressed: (){

                                            data[index].reference.delete();
                                            Navigator.pop(context);
                                            showUploadMessage(context, 'Languages Deleted...');

                                          }, child: Text('Delete')),
                                        ],
                                      );
                                    });
                                  },
                                  child: Container(
                                    height: 80,
                                      child: Center(child: Text(data[index]['name'],style: TextStyle(fontWeight: FontWeight.bold),))),
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

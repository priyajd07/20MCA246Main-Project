import 'package:MovieFlix_admin/auth/auth_util.dart';
import 'package:MovieFlix_admin/backend/backend.dart';
import '../Category/CreateCategory.dart';
import '../Generes/AddGeneres.dart';
import '../Languages/CreateLanguages.dart';
import '../Movies/UploadMovies.dart';
import '../UserManagement/UserManagements.dart';
import '../VideoMangement/VideoList.dart';
import '../YouTube/AddYouTubeVideo.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../login/Signin.dart';

var primaryColor=  Color(0xFF4B39EF);

List<String> categories=[];
Map<String,dynamic> categoryId={};
Map<String,dynamic> categoryName={};

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timestamp datePicked1;
  Timestamp datePicked2;
  int users=0;
  int movie=0;
  List jash=[];
  List uLike=[];
  List raha=[];
  List common=[];
  getMovie()async{
    FirebaseFirestore.instance.collection('movie')
      .snapshots().listen((event) {


      movie=event.docs.length;




          if(mounted){
            setState(() {

            });
          }
    });
  }
  getUsers()async{
    FirebaseFirestore.instance.collection('users')
        .snapshots().listen((event) {


      users=event.docs.length;

          if(mounted){
            setState(() {

            });
          }
    });
  }
  getCategory(){
    FirebaseFirestore.instance.collection('categories').snapshots().listen((event) {
      categories=[];
      for(DocumentSnapshot doc in event.docs){
        categories.add(doc['name']);
        categoryId[doc['name']]=doc.id;
        categoryName[doc.id]=doc['name'];
      }

      if(mounted){
        setState(() {

        });
      }
    });

  }

  updateProduct(){
    FirebaseFirestore.instance.collection('movie')
        .get().then((value) {
      for(DocumentSnapshot snap in value.docs){
        // FirebaseFirestore.instance.collection('testProduct').add(snap.data());
        FirebaseFirestore.instance.collection('movie').doc(snap.id).update({
          'likeCount':0,

        });
      }
      print('done');
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // updateProduct();
    getCategory();
    DateTime today=DateTime.now();
    datePicked1 =Timestamp.fromDate(DateTime(today.year,today.month,today.day,0,0,0));
    datePicked2 =Timestamp.fromDate(DateTime(today.year,today.month,today.day,23,59,59));
    getMovie();
    getUsers();

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
          'Hi, $currentUserDisplayName',
          style: FlutterFlowTheme.of(context).title1.override(
            fontFamily: 'Poppins',
            color: Color(0xFF0F1113),
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 16, 0),
            child: Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl:
                    currentUserPhoto==''?
                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60':currentUserPhoto,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      drawer: Drawer(
        elevation: 16,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      currentUserEmail,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      currentUserDisplayName,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'V 1.0.4',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadMoviesWidget()));
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Center(
                  child: Text(
                    'Upload Movies',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateLanguages()));

              },

              child: Container(

                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Center(
                  child: Text(
                    'Languages',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                        fontWeight: FontWeight.w600

                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateGeneres()));
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Center(
                  child: Text(
                    'Genres',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600

                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateCategory()));
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Center(
                  child: Text(
                    'Category',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600

                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddYouTubeVideo()));

              },

              child: Container(

                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Center(
                  child: Text(
                    'YouTube',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600

                    ),
                  ),
                ),
              ),
            ),


            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0, 1),
                child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (buildContext){
                      return AlertDialog(
                        title: Text('Logout?'),
                        content: Text('Do you want to Continue'),
                        actions: [
                          TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
                          TextButton(onPressed: () async {
                            await signOut();
                            await Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SigninWidget(),
                              ),
                                  (r) => false,
                            );
                          }, child: Text('Logout')),
                        ],
                      );
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                    ),
                    child: Center(
                      child: Text(
                        'Logout',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'This is your daily summary.',
                    style: FlutterFlowTheme.of(context).bodyText2.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 0,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 2, 2, 12),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersViewWidget()));
                          },
                          child: Container(

                            width: MediaQuery.of(context).size.width * 0.20,
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.teal,

                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x34090F13),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: Text(
                                      'Total Members',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          users.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 50,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 12),
                        child: InkWell(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SODView()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            height: MediaQuery.of(context).size.height * 0.25,

                            decoration: BoxDecoration(
                              color: Color(0xFFEE8B60),

                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x34090F13),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: Text(
                                      'Total Revenue',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '0',
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 55,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 12),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoManagmentWidget()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            height: MediaQuery.of(context).size.height * 0.25,

                            decoration: BoxDecoration(
                              color: Color(0xFF4B39EF),

                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x34090F13),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: Text(
                                      'Total Videos',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          movie.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 55,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

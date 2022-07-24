//@dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:netflix/auth/auth_util.dart';
import 'package:netflix/home_page/homeitems.dart';
import 'package:netflix/test_search.dart';
import 'package:netflix/type_items/type_items.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../EditProfile.dart';
import '../delailed_page/detailed_page.dart';
import '../login/login.dart';
import '../main.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../search_page.dart';

List videos=[];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key,}) : super(key: key);




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
List categories=[];
class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('////////////////////////////');
    print(currentUserEmail);
    getVideos();

    getCategories();
    getPinVideo();
    CurrentUsers();

  }

  List CurrentUserPlyList=[];
  CurrentUsers() async {
    DocumentSnapshot abc=await FirebaseFirestore.instance.collection('users').doc(currentUserUid).get();
    CurrentUserPlyList=abc['playList'];
    setState(() {

    });
  }

  getCategories() async {
    QuerySnapshot category = await FirebaseFirestore.instance.collection('categories').get();
    categories=category.docs;
    print(categories.length);
    setState(() {

    });
  }
List thisYear=[];

  List generes=[];
Map videoId={};
  getVideos() async {
    QuerySnapshot video = await FirebaseFirestore.instance.collection('movie').get();
    thisYear=[];
    videos=[];
    videoId={};

    for (DocumentSnapshot item in video.docs){
      print(item.data());
      videoId[item.reference.id]=item.data();
      videos.add(item);
      var date=item['date'].toDate().toString().substring(0,4);
      var today=Timestamp.now().toDate().toString().substring(0,4);
      if(date==today){
        thisYear.add(item);
        print('///////////////////////');
        print(thisYear.length);
      }

    }
    if(mounted){
      setState(() {

      });
    }

  }




  // String secondButtonText = 'Record video';
  // void recordVideo(File recordedVideo) async {
  //   print('aaaaaaaaaaaaaaa');
  //   showUploadMessage(context, '111111111111111111111111 saved');
  //   ImagePicker.platform.pickVideo(source: ImageSource.camera);
  //   if (recordedVideo != null && recordedVideo.path != null) {
  //     setState(() {
  //       secondButtonText = 'saving in progress...';
  //     });
  //     print('bbbbbbbbbbb');
  //     showUploadMessage(context, '22222222222222222222222222222222 saved');
  //     GallerySaver.saveVideo(recordedVideo.path).then(( path) {
  //       setState(() {
  //         secondButtonText = 'video saved!';
  //       });
  //       print('cccccccccccc');
  //       showUploadMessage(context, 'video saved');
  //     });
  //   }
  //   print('done');
  // }

  // String _localPath;


  String  pinId='';
  getPinVideo() async {
    FirebaseFirestore.instance.collection('movie').orderBy('likeCount',descending: true).snapshots().listen((event) {
      pinId=event.docs[0].id;

      print(pinId);
      print(videoId[pinId]);
      generes=videoId[pinId]['generes'];
      if(mounted){
        setState(() {

        });
      }
    });

  }
  StreamSubscription productStream;


  @override
  Widget build(BuildContext context) {

    h=MediaQuery.of(context).size.height;
    w=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body:
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[

            SliverAppBar(
              // bottom: TabBar(
              //   tabs: [
              //     Tab(child: Text('TV Shows',style: TextStyle(fontSize: 12))),
              //     Tab(child: Text('Movies',style: TextStyle(fontSize: 12))),
              //     Tab(child: Text('Categories',style: TextStyle(fontSize: 12))),
              //   ],
              // ),
              backgroundColor: Colors.black.withOpacity(0.7),
              pinned: true,
              elevation: 10,
              titleTextStyle:TextStyle(
                  fontSize: 12
              ) ,
              floating: true,
              // Display a placeholder widget to visualize the shrinking size.

              expandedHeight: MediaQuery.of(context).size.height*0.15,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(
                  bottom: w*0.03
                ),
                background: Container(
                 child:Padding(
                   padding: EdgeInsets.only(
                     left: w*0.05,
                     right: w*0.05,
                   ),
                   child: Row(
                     children: [
                       Image.asset('assets/images/m.png',height: w*0.1,),
                       Expanded(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             InkWell(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage(

                                   )));
                                 },
                                 child: Icon(Icons.search,color: Colors.white,size: w*0.07,)),
                             SizedBox(width: w*0.08,),
                             InkWell(
                               onTap: (){
                                 showDialog<String>(
                                     context: context,
                                     builder: (BuildContext context) => AlertDialog(
                                       backgroundColor: Colors.grey.shade900,

                                   content: Container(
                                     height: h*0.25,
                                     child: Column(
                                       children: [
                                         Expanded(child: SizedBox()),
                                         Expanded(child: SizedBox()),
                                         CircleAvatar(
                                           backgroundImage: NetworkImage(currentUserPhoto),
                                           radius: 40,
                                         ),
                                         Expanded(child: SizedBox()),
                                         Text(currentUserDisplayName,style: TextStyle(
                                           fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red
                                         ),),
                                         Expanded(child: SizedBox()),
                                         Text(currentUserEmail,style: TextStyle(
                                             color: Colors.white
                                         ),),
                                         Expanded(child: SizedBox()),
                                         Expanded(child: SizedBox()),
                                       ],
                                     ),
                                   ),
                                   actions: <Widget>[

                                     Center(
                                       child: Padding(
                                         padding: const EdgeInsets.all(10.0),
                                         child: Container(
                                           decoration: BoxDecoration(
                                             color: Colors.red,
                                             borderRadius: BorderRadius.circular(40)
                                           ),
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 10,right: 10),
                                             child: TextButton(
                                               onPressed: () async {
                                                 await showModalBottomSheet(
                                                   isScrollControlled: true,
                                                   context: context,
                                                   builder: (context) {
                                                     return Padding(
                                                       padding: MediaQuery.of(context).viewInsets,
                                                       child: Container(
                                                           height: 400,
                                                           child: EditWidget()),
                                                     );
                                                   },
                                                 );
                                                 Navigator.pop(context);
                                               },
                                               child: const Text('EDIT',style: TextStyle(
                                                 fontWeight: FontWeight.bold,color: Colors.white
                                               ),),
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ));
                               },
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(5),
                                   child: Image.asset('assets/images/profile.png',height: w*0.07,)),
                             ),
                             SizedBox(width: w*0.08,),
                             InkWell(
                               onTap: () async {
                                 final SharedPreferences localStorage =
                                     await SharedPreferences.getInstance();
                                 localStorage.remove('branchId');

                                 await signOut();
                                 await Navigator.pushAndRemoveUntil(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) => Login(),
                                   ),
                                       (r) => false,
                                 );
                               },
                                 child: Icon(Icons.logout,color: Colors.white,size: w*0.07,)
                             ),
                           ],
                         ),
                       )
                     ],
                   ),
                 ),

                ),
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TypeItems(
                          type:'Movie' ,
                        )));
                      },
                        child: Text('Movies',style: TextStyle(fontSize: 12))),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TypeItems(
                            type:'Series' ,
                          )));
                        },
                        child: Text('Series',style: TextStyle(fontSize: 12))),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TypeItems(
                            type:'Study Materials' ,
                          )));
                        },
                        child: Text('Study',style: TextStyle(fontSize: 12))),

                  ],
                ),
              ),
            ),
            videoId[pinId]!=null ? SliverToBoxAdapter(
              child: Container(
                height: h*0.5,width: w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(videoId[pinId]['thumbnail']),fit: BoxFit.fill
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: Column(
                    children: [
                      Expanded(child: SizedBox()),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: const Offset(
                                0.0,
                                5.0,
                              ),
                              blurRadius: 30.0,
                              spreadRadius: 10.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 10,),
                            Center(
                              child: Text(generes.join(' . '),style: TextStyle(
                                color: Colors.white70
                              ),),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        List PlyList=[];
                                        PlyList.add(pinId);
                                         FirebaseFirestore.instance.collection('users').doc(currentUserUid).update({
                                            'playList':FieldValue.arrayUnion(PlyList)
                                         });
                                        CurrentUserPlyList.contains(pinId)?
                                        showUploadMessage(context, 'video already added to playList'):
                                        showUploadMessage(context, 'video added to playlist successfully');
                                        },
                                        child: Icon(Icons.add,color: Colors.white,size: 30,)
                                    ),
                                    Text('My List',style: TextStyle(
                                        color: Colors.white70,fontSize: 10
                                    ),),
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                                      item: videoId[pinId],
                                      autoPlay: true,
                                    )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10,5,10,5),
                                      child: Row(
                                        children: [
                                          Icon(Icons.play_arrow),
                                          SizedBox(width: 10,),
                                          Text('Play',style: TextStyle(
                                              fontSize: 12,fontWeight: FontWeight.w600
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [

                                    InkWell(
                                      onTap:(){
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          builder: (context) {
                                            return Container(
                                              height: h*0.35,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade900,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(30),
                                                    topRight: Radius.circular(30),
                                                  )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius: BorderRadius.circular(5) ,
                                                            child: Image.network(videoId[pinId]['thumbnail'],height: h*0.15,width: w*0.22,fit: BoxFit.fill,)),
                                                        Expanded(child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: Container(
                                                            height: h*0.15,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(videoId[pinId]['title']+'(${videoId[pinId]['language']})',style: TextStyle(
                                                                              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18
                                                                          ),),
                                                                          SizedBox(height: 10,),
                                                                          Row(
                                                                            children: [
                                                                              Text(videoId[pinId]['date'].toDate().toString().substring(0,4),style: TextStyle(
                                                                                  color: Colors.white54,fontSize: 12
                                                                              ),),
                                                                              SizedBox(width: 15,),
                                                                              Text(videoId[pinId]['duration'],style: TextStyle(
                                                                                  color: Colors.white54,fontSize: 12
                                                                              ),),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap: (){
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child: CircleAvatar(
                                                                        backgroundColor: Colors.grey.shade700,
                                                                        radius: 15,
                                                                        child: Icon(Icons.close,color: Colors.white,),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 10,),
                                                                Expanded(
                                                                  child: Text(videoId[pinId]['description'],style: TextStyle(
                                                                      color: Colors.white
                                                                  ),),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(height: 15,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: (){
                                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                                                                  item:videoId[pinId],
                                                                  autoPlay: true,
                                                                )));
                                                              },
                                                              child: CircleAvatar(
                                                                backgroundColor: Colors.white,
                                                                radius: 18,
                                                                child: Icon(Icons.play_arrow,color: Colors.black,),
                                                              ),
                                                            ),
                                                            SizedBox(height: 5,),
                                                            Text('Play',style: TextStyle(
                                                                color: Colors.white54,fontSize: 12
                                                            ),),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            RoundedLoadingButton(
                                                              height: 40,
                                                              width: 40,
                                                              successColor: Colors.green,
                                                              successIcon: Icons.check_circle_outline,
                                                              color:  Colors.white.withOpacity(0.1),
                                                              child: Icon(Icons.download,color: Colors.white,),
                                                              controller: btnController,
                                                              onPressed: () async {
                                                                print('clicked');
                                                                print(videoId[pinId]['video'].toString());
                                                                print(videoId[pinId]['title'].toString());
                                                                downloadFile(
                                                                    '${videoId[pinId]['video']}',
                                                                    '${videoId[pinId]['title']+'.mp4'}',
                                                                    context
                                                                );

                                                              },
                                                            ),
                                                            Text('Download',style: TextStyle(
                                                                color: Colors.white54,fontSize: 12
                                                            ),),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            InkWell(
                                                              onTap:(){
                                                                List PlayList=[];
                                                                PlayList.add(pinId);
                                                                FirebaseFirestore.instance.collection('users').doc(currentUserUid).update({
                                                                  'playList':FieldValue.arrayUnion(PlayList)
                                                                });
                                                                showUploadMessage(context, 'video added to playlist successfully');
                                                              },
                                                              child: CircleAvatar(
                                                                backgroundColor: Colors.white.withOpacity(0.1),
                                                                radius: 18,
                                                                child: Icon(Icons.add,color: Colors.white,),
                                                              ),
                                                            ),
                                                            SizedBox(height: 5,),
                                                            Text('My List',style: TextStyle(
                                                                color: Colors.white54,fontSize: 12
                                                            ),),
                                                          ],
                                                        ),
                                                        // Column(
                                                        //   children: [
                                                        //     CircleAvatar(
                                                        //       backgroundColor: Colors.white.withOpacity(0.1),
                                                        //       radius: 18,
                                                        //       child: Icon(Icons.share,color: Colors.white,),
                                                        //     ),
                                                        //     SizedBox(height: 5,),
                                                        //     Text('Share',style: TextStyle(
                                                        //         color: Colors.white54,fontSize: 12
                                                        //     ),),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                    Divider(color: Colors.grey.shade600,),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                                                            item:videoId[pinId],
                                                            autoPlay: true,
                                                          )));
                                                        },
                                                        child: Row(
                                                          children:  [

                                                            Icon(Icons.info_outline,color: Colors.white,size: 20,),

                                                            SizedBox(width: 10,),
                                                            Expanded(
                                                              child: Text('Details & More',style: TextStyle(
                                                                  fontWeight: FontWeight.w600,color: Colors.white
                                                              ),),
                                                            ),SizedBox(width: 10,),

                                                            Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                        child: Icon(Icons.info_outline,color: Colors.white,size: 30,)
                                    ),

                                    Text('Info',style: TextStyle(
                                        color: Colors.white70,fontSize: 10
                                    ),),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ):SliverToBoxAdapter(
              child: Container(

              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: h*0.4,
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h*0.03,),
                    Padding(
                      padding:  EdgeInsets.only(left: w*0.05),
                      child: Text('Released in this Year',style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.white,
                        fontSize: 25
                      ),),
                    ),
                    Expanded(child: Container(
                      child: ListView.builder(
                        itemCount: thisYear.length,
                        padding: EdgeInsets.all(15),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  builder: (context) {
                                    return Container(
                                      height: h*0.35,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade900,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                    borderRadius: BorderRadius.circular(5) ,
                                                    child: Image.network(thisYear[index]['thumbnail'],height: h*0.15,width: w*0.22,fit: BoxFit.fill,)),
                                                Expanded(child: Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Container(
                                                    height: h*0.15,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(thisYear[index]['title']+'(${thisYear[index]['language']})',style: TextStyle(
                                                                      color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18
                                                                  ),),
                                                                  SizedBox(height: 10,),
                                                                  Row(
                                                                    children: [
                                                                      Text(thisYear[index]['date'].toDate().toString().substring(0,4),style: TextStyle(
                                                                          color: Colors.white54,fontSize: 12
                                                                      ),),
                                                                      SizedBox(width: 15,),
                                                                      Text(thisYear[index]['duration'],style: TextStyle(
                                                                          color: Colors.white54,fontSize: 12
                                                                      ),),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: (){
                                                                Navigator.pop(context);
                                                              },
                                                              child: CircleAvatar(
                                                                backgroundColor: Colors.grey.shade700,
                                                                radius: 15,
                                                                child: Icon(Icons.close,color: Colors.white,),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Expanded(
                                                          child: Text(thisYear[index]['description'],style: TextStyle(
                                                              color: Colors.white
                                                          ),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                              ],
                                            ),
                                            SizedBox(height: 15,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                                                          item:thisYear[index],
                                                          autoPlay: true,
                                                        )));
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        radius: 18,
                                                        child: Icon(Icons.play_arrow,color: Colors.black,),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Text('Play',style: TextStyle(
                                                        color: Colors.white54,fontSize: 12
                                                    ),),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    RoundedLoadingButton(
                                                      height: 40,
                                                      width: 40,
                                                      successColor: Colors.green,
                                                      successIcon: Icons.check_circle_outline,
                                                      color:  Colors.white.withOpacity(0.1),
                                                      child: Icon(Icons.download,color: Colors.white,),
                                                      controller: btnController,
                                                      onPressed: () async {
                                                        print('clicked');
                                                        print(thisYear[index]['video'].toString());
                                                        print(thisYear[index]['title'].toString());
                                                        downloadFile(
                                                            '${thisYear[index]['video']}',
                                                            '${thisYear[index]['title']+'.mp4'}',
                                                            context
                                                        );

                                                      },
                                                    ),
                                                    Text('Download',style: TextStyle(
                                                        color: Colors.white54,fontSize: 12
                                                    ),),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap:(){
                                                        List PlayList=[];
                                                        PlayList.add(thisYear[index].id);
                                                        FirebaseFirestore.instance.collection('users').doc(currentUserUid).update({
                                                          'playList':FieldValue.arrayUnion(PlayList)
                                                        });
                                                        Navigator.pop(context);
                                                        CurrentUserPlyList.contains(thisYear[index].id)?
                                                        showUploadMessage(context, 'video already added to playList'):
                                                        showUploadMessage(context, 'video added to playlist successfully');
                                                        },
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.white.withOpacity(0.1),
                                                        radius: 18,
                                                        child: Icon(Icons.add,color: Colors.white,),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Text('My List',style: TextStyle(
                                                        color: Colors.white54,fontSize: 12
                                                    ),),
                                                  ],
                                                ),
                                                // Column(
                                                //   children: [
                                                //     CircleAvatar(
                                                //       backgroundColor: Colors.white.withOpacity(0.1),
                                                //       radius: 18,
                                                //       child: Icon(Icons.share,color: Colors.white,),
                                                //     ),
                                                //     SizedBox(height: 5,),
                                                //     Text('Share',style: TextStyle(
                                                //         color: Colors.white54,fontSize: 12
                                                //     ),),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                            Divider(color: Colors.grey.shade600,),
                                            Expanded(
                                              child: InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                                                    item:thisYear[index],
                                                    autoPlay: true,
                                                  )));
                                                },
                                                child: Row(
                                                  children:  [

                                                    Icon(Icons.info_outline,color: Colors.white,size: 20,),

                                                    SizedBox(width: 10,),
                                                    Expanded(
                                                      child: Text('Details & More',style: TextStyle(
                                                          fontWeight: FontWeight.w600,color: Colors.white
                                                      ),),
                                                    ),SizedBox(width: 10,),

                                                    Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(thisYear[index]['thumbnail'],width: w*0.42,fit: BoxFit.cover,),),
                            ),
                          );
                        },
                      ),
                    ))
                  ],
                ),
              ),

            ),


            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context,index){
                  return HomeItems(category: categories[index]['categoryId'], name: categories[index]['name']);
                },
              )

            ),
          ],
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}










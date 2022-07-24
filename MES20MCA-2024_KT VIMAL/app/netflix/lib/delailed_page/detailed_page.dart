//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow.dart';
import '../main.dart';

class MovieViewWidget extends StatefulWidget {
  final dynamic item;
  final bool autoPlay;
  const MovieViewWidget({Key key, this.item, this.autoPlay}) : super(key: key);

  @override
  _MovieViewWidgetState createState() => _MovieViewWidgetState();
}

class _MovieViewWidgetState extends State<MovieViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List generes=[];
  List related=[];
  bool autoPlay;

  List CurrentUserPlyList=[];
  CurrentUsers() async {
    DocumentSnapshot abc=await FirebaseFirestore.instance.collection('users').doc(currentUserUid).get();
    CurrentUserPlyList=abc['playList'];
    setState(() {

    });
  }
  bool liked=false;
  int likeCount=0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    related=widget.item['related'];
    generes=widget.item['generes'];
    autoPlay=widget.autoPlay;

    CurrentUsers();
    getVideo();
  }
  int likeCounts=0;
  getVideo() async {
    await FirebaseFirestore.instance.collection('movie').doc(widget.item.id).snapshots().listen((movie) {
      likeCounts=movie.get('liked').length;
      print('#####################3');
      print(likeCounts);
      if(movie.get('liked').contains(currentUserUid)){
        liked=true;
      }
      else{
        liked=false;
      }
      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 24,
              ),
             SizedBox(width: 20,)
            ],
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [

      FlutterFlowVideoPlayer(
      path:
      widget.item['video'],
        videoType: VideoType.network,
        autoPlay:autoPlay,
        looping: true,
        showControls: true,
        allowFullScreen: true,
        allowPlaybackSpeedMenu: false,
      ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item['title']+'(${widget.item['language']})',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25
                    ),),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Text(widget.item['date'].toDate().toString().substring(0,4),style: TextStyle(
                            color: Colors.white54,fontSize: 14
                        ),),
                        SizedBox(width: 15,),
                        Text(widget.item['duration'],style: TextStyle(
                            color: Colors.white54,fontSize: 14
                        ),),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text(
                      generes.join(' . '),
                      style: TextStyle(
                          color: Colors.white54
                      ),
                    ),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text('PLAY',style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),


                    Text(
                      widget.item['description'],
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),

                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [


                        // Column(
                        //   children: [
                        //     CircleAvatar(
                        //       backgroundColor: Colors.white.withOpacity(0.1),
                        //       radius: 18,
                        //       child: Icon(Icons.add,color: Colors.white,),
                        //     ),
                        //     SizedBox(height: 5,),
                        //     Text('My List',style: TextStyle(
                        //         color: Colors.white54,fontSize: 12
                        //     ),),
                        //   ],
                        // ),
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
                                print(widget.item['video'].toString());
                                print(widget.item['title'].toString());
                                downloadFile(
                                    '${widget.item['video']}',
                                    '${widget.item['title']+'.mp4'}',
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
                              onTap: (){
                                if(liked==false){
                                  FirebaseFirestore.instance.collection('movie').doc(widget.item.id).update(
                                      {
                                        'liked':FieldValue.arrayUnion([currentUserUid]),
                                        'likeCount':FieldValue.increment(1),
                                        // 'likeCount':likeCounts
                                      });
                                  print('+++++++++++++++++');
                                  print(likeCounts);
                                  setState(() {

                                  });
                                }else{
                                  FirebaseFirestore.instance.collection('movie').doc(widget.item.id).update(
                                      {
                                        'liked':FieldValue.arrayRemove([currentUserUid]),
                                        'likeCount':FieldValue.increment(-1),
                                      });
                                  print('+++++++++++++++++');
                                  print(likeCounts);
                                  setState(() {

                                  });
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.1),
                                radius: 18,
                                child:liked==false? Icon(Icons.thumb_up_alt_outlined,color: Colors.white,):Icon(Icons.thumb_up_alt,color: Colors.red,),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(liked==false?'Like':'Liked',style: TextStyle(
                                color: Colors.white54,fontSize: 12
                            ),),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: (){

                                List PlayList=[];
                                PlayList.add(widget.item.id);
                                FirebaseFirestore.instance.collection('users').doc(currentUserUid).update({
                                  'playList':FieldValue.arrayUnion(PlayList)
                                });
                                CurrentUserPlyList.contains(widget.item.id)?
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
                      ],
                    ),
                    SizedBox(height: 15,),
                    related.length!=0?
                    Text('Related Videos',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18
                    ),):
                    Text(''),
                    SizedBox(height: 10,),
                    related.length!=0?
                         Container(
                           height: MediaQuery.of(context).size.height*0.2,
                           child: ListView.builder(
                             physics: BouncingScrollPhysics(),
                             scrollDirection: Axis.horizontal,
                             itemCount: related.length,
                               itemBuilder: (context, int index){
                               return StreamBuilder<DocumentSnapshot>(
                                   stream: FirebaseFirestore.instance.collection('movie').doc(related[index]).snapshots(),
                                   builder: (context, snapshot) {
                                     if(!snapshot.hasData){
                                       return Center(child: CircularProgressIndicator());
                                     }
                                     var data=snapshot.data;
                                   return Padding(
                                     padding: const EdgeInsets.only(right: 8.0),
                                     child: InkWell(
                                       onTap: (){
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                                           item:data,
                                           autoPlay: true,
                                         )));

                                       },
                                       child: Container(
                                         width: MediaQuery.of(context).size.width*0.3,
                                         decoration: BoxDecoration(
                                             color: Colors.grey[200],
                                           borderRadius: BorderRadius.circular(10)
                                         ),
                                         child: Image.network(data['thumbnail'],fit: BoxFit.cover,),
                                       ),
                                     ),
                                   );
                                 }
                               );

                               }
                           ),
                         )
                        :Container()


                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
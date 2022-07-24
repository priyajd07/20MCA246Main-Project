

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../auth/auth_util.dart';
import '../delailed_page/detailed_page.dart';
import '../main.dart';



class HomeItems extends StatefulWidget {
  final String category;
  final String name;
  const HomeItems({Key? key, required this.category, required this.name}) : super(key: key);

  @override
  State<HomeItems> createState() => _HomeItemsState();
}

class _HomeItemsState extends State<HomeItems> {

  List CurrentUserPlyList=[];
  CurrentUsers() async {
    DocumentSnapshot abc=await FirebaseFirestore.instance.collection('users').doc(currentUserUid).get();
    CurrentUserPlyList=abc['playList'];
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
    CurrentUsers();
  }
  List videos=[];
  getProduct() async {
    QuerySnapshot video = await FirebaseFirestore.instance.collection('movie').where('category',isEqualTo: widget.category).get();
    videos=video.docs;
   if(mounted){
     setState(() {

     });
   }
    print(videos);
  }

  // Future<File?> downloadFile1(String url,String name,) async {
  //   final appStorage =await getExternalStorageDirectory();
  //   final file=File('${appStorage?.path}/$name');
  //   print(appStorage?.path);
  //   try{
  //     final response=await Dio().get(
  //         url,
  //         options:Options(
  //           responseType:ResponseType.bytes,
  //           followRedirects:false,
  //           receiveTimeout:0,
  //
  //         )
  //     );
  //     print('bbbbbbbbbbbbbbbbbbb');
  //     final raf=file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     showUploadMessage(context, 'video downloaded Successfully');
  //     print(file);
  //     print(file.path);
  //     print('path printed');
  //     return file;
  //
  //   }catch(e){
  //     print('done');
  //     return null;
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return videos.length==0?Container(): Container(
      height: h*0.3,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h*0.03,),
          Padding(
            padding:  EdgeInsets.only(left: w*0.05),
            child: Text(widget.name,style: TextStyle(
                fontWeight: FontWeight.bold,color: Colors.white,
                fontSize: 20
            ),),
          ),
          Expanded(child: Container(
            child: ListView.builder(
              itemCount: videos.length,
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
                                          child: Image.network(videos[index]['thumbnail'],height: h*0.15,width: w*0.22,fit: BoxFit.fill,)),
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
                                                        Text(videos[index]['title']+'(${videos[index]['language']})',style: TextStyle(
                                                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18
                                                        ),),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          children: [
                                                            Text(videos[index]['date'].toDate().toString().substring(0,4),style: TextStyle(
                                                                color: Colors.white54,fontSize: 12
                                                            ),),
                                                            SizedBox(width: 15,),
                                                            Text(videos[index]['duration'],style: TextStyle(
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
                                                child: Text(videos[index]['description'],style: TextStyle(
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
                                              print(videos[index]);
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                                                item:videos[index],
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
                                              print(videos[index]['video'].toString());
                                              print(videos[index]['title'].toString());
                                              downloadFile(
                                                  '${videos[index]['video']}',
                                                  '${videos[index]['title']+'.mp4'}',
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
                                              PlayList.add(videos[index].id);
                                              FirebaseFirestore.instance.collection('users').doc(currentUserUid).update({
                                                'playList':FieldValue.arrayUnion(PlayList)
                                              });
                                              Navigator.pop(context);
                                              CurrentUserPlyList.contains(videos[index].id)?
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
                                          item:videos[index] ,
                                          autoPlay: false,
                                        )));

                                      },
                                      child: Row(
                                        children: [
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
                      child: Image.network(videos[index]['thumbnail'],width: w*0.28,fit: BoxFit.cover,),),
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}

//@dart=2.9
import 'package:flutter/material.dart';
import 'package:netflix/backend/backend.dart';

import '../delailed_page/detailed_page.dart';

class Recommended extends StatefulWidget {
  const Recommended({Key key}) : super(key: key);

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  List ytVideos=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Recommended Videos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('movie').orderBy('likeCount',descending: true).limit(5).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          var data=snapshot.data.docs;
          return GridView.builder(
              itemCount: data.length,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:0.8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10
              ),
              itemBuilder: (context , index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
                      item:data[index],
                      autoPlay: true,
                    )));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data[index]['thumbnail']),fit: BoxFit.cover
                              ),
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          // child: Align(
                          //   alignment: Alignment.bottomCenter,
                          //     child: Text(ytVideos[index]['movie'])
                          // ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(data[index]['title'],style: TextStyle(
                          fontWeight: FontWeight.bold,color: Colors.white
                      ),)
                    ],
                  ),
                );
              });
        }
      ),

    );
  }
}

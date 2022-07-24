//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../delailed_page/detailed_page.dart';

class TypeItems extends StatefulWidget {
  final String type;
  const TypeItems({Key key,  this.type}) : super(key: key);

  @override
  State<TypeItems> createState() => _TypeItemsState();
}

class _TypeItemsState extends State<TypeItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(widget.type),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('movie').where('type',isEqualTo: widget.type).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            var data=snapshot.data.docs;
            return data.length==0?Center(
              child: Text('No Videos Found',style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18
              ),),
            ):
            GridView.builder(
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
                  );
                });
          }
      ),
    );
  }
}

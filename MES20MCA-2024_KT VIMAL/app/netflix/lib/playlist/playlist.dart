//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth/auth_util.dart';
import '../delailed_page/detailed_page.dart';

class PlayList extends StatefulWidget {
  const PlayList({Key key}) : super(key: key);

  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
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
    CurrentUsers();

  }
  // setSearchParam(String caseNumber) {
  //   List<String> caseSearchList = List<String>();
  //   String temp = "";
  //
  //   List<String> nameSplits = caseNumber.split(" ");
  //   for (int i = 0; i < nameSplits.length; i++) {
  //     String name = "";
  //
  //     for (int k = i; k < nameSplits.length; k++) {
  //       name = name + nameSplits[k] + " ";
  //     }
  //     temp = "";
  //
  //     for (int j = 0; j < name.length; j++) {
  //       temp = temp + name[j];
  //       caseSearchList.add(temp.toUpperCase());
  //     }
  //   }
  //   return caseSearchList;
  // }
  //
  // updateProduct(){
  //   FirebaseFirestore.instance.collection('movie').get().then((value) {
  //     for(DocumentSnapshot snap in value.docs){
  //       // FirebaseFirestore.instance.collection('testProduct').add(snap.data());
  //       String name=snap['title'];
  //
  //       FirebaseFirestore.instance.collection('movie').doc(snap.id).update({
  //         'search':setSearchParam(name),
  //       });
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('My Play List'),
      ),
      body: GridView.builder(
          itemCount: CurrentUserPlyList.length,
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:0.8,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10
          ),
          itemBuilder: (context , index){
            return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('movie').doc(CurrentUserPlyList[index]).snapshots(),
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
          }),
    );
  }
}

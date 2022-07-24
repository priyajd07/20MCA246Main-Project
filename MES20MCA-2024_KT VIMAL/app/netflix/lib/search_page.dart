//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import 'delailed_page/detailed_page.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({Key key, }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    searchController=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Search Videos'),
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.fromLTRB(20,10,20,10),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.grey
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: Row(
                  children: [
                    Icon(Icons.search,color: Colors.grey.shade700,),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: searchController,

                        onChanged: (value){
                          setState(() {

                          });
                        },
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.normal,
                                color: Colors.black
                            )
                        ),
                        decoration:

                        InputDecoration(
                            contentPadding: const EdgeInsets.all(5),
                            fillColor: Colors.white,
                            hintText: 'Search',
                            hintStyle: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.normal,
                                    color: Colors.black
                                        .withOpacity(
                                        0.250))
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    9),
                                borderSide: const BorderSide(
                                    color: Color
                                        .fromRGBO(
                                        42,
                                        172,
                                        146,
                                        0.0))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    9),
                                borderSide: const BorderSide(
                                    color: Color
                                        .fromRGBO(
                                        42,
                                        172,
                                        146,
                                        0.0))),
                            filled: true,
                            suffixIcon: searchController.text.isNotEmpty
                                ? InkWell(
                              onTap: () => setState(
                                    () => searchController.clear(),
                              ),
                              child: const Icon(
                                Icons.clear,
                                color: Colors.grey,
                                size: 22,
                              ),
                            )
                                :null
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //     borderSide: BorderSide(color: Colors.yellow)),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:searchController.text==''?FirebaseFirestore.instance.collection('movie').snapshots():
              FirebaseFirestore.instance.collection('movie').where('search',arrayContains: searchController.text.toUpperCase()).snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                if(snapshot.data.docs.isEmpty){
                  return Center(
                    child: Text('No Videos Found',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18
                    ),),
                  );
                }
                var data=snapshot.data.docs;

                return  GridView.builder(
                    itemCount: data.length,
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio:0.8,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 15
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
                            SizedBox(height: 5,),
                            Text(data[index]['title'],maxLines: 1,style: TextStyle(
                                color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12
                            ),),
                            SizedBox(height: 5,),
                          ],
                        ),
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}

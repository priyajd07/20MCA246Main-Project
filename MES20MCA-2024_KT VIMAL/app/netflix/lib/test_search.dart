// //@dart=2.9
// import 'package:auto_complete_search/auto_complete_search.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'delailed_page/detailed_page.dart';
//
// class TestSearch extends StatefulWidget {
//   final String title;
//   final List areaList;
//   const TestSearch({Key key, this.title, this.areaList}) : super(key: key);
//
//   @override
//   State<TestSearch> createState() => _TestSearchState();
// }
//
// class _TestSearchState extends State<TestSearch> {
//   TextEditingController areaCtrl = TextEditingController();
//   GlobalKey key = new GlobalKey<AutoCompleteSearchFieldState<Area>>();
//   List<Area> areas = [];
//
//   @override
//   void initState() {
//     areaCtrl = TextEditingController();
//     List<Area> areas = widget.areaList
//         .map((area) => Area(title: area["title"]))
//         .toList();
//     Area.areas = areas;
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: AutoCompleteSearchField(
//                 key: key,
//                 controller: areaCtrl,
//                 decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.all(5),
//                     fillColor: Colors.white,
//                     hintText: 'Search',
//                     hintStyle: GoogleFonts.nunito(
//                         textStyle: TextStyle(
//                             fontSize: 12,
//                             fontWeight:
//                             FontWeight.normal,
//                             color: Colors.black
//                                 .withOpacity(
//                                 0.250))
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius:
//                         BorderRadius
//                             .circular(
//                             9),
//                         borderSide: const BorderSide(
//                             color: Color
//                                 .fromRGBO(
//                                 42,
//                                 172,
//                                 146,
//                                 0.0))),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius:
//                         BorderRadius
//                             .circular(
//                             9),
//                         borderSide: const BorderSide(
//                             color: Color
//                                 .fromRGBO(
//                                 42,
//                                 172,
//                                 146,
//                                 0.0))),
//                     filled: true,
//                     suffixIcon: areaCtrl.text.isNotEmpty
//                         ? InkWell(
//                       onTap: () => setState(
//                             () => areaCtrl.clear(),
//                       ),
//                       child: const Icon(
//                         Icons.clear,
//                         color: Colors.grey,
//                         size: 22,
//                       ),
//                     )
//                         :null
//                   // border: OutlineInputBorder(
//                   //     borderRadius: BorderRadius.circular(20),
//                   //     borderSide: BorderSide(color: Colors.yellow)),
//                 ),
//                 submitOnSuggestionTap: true,
//                 itemSorter: (Area a, Area b) =>
//                     a.title.toLowerCase().compareTo(b.title.toLowerCase()),
//                 suggestions: Area.areas,
//                 itemSubmitted: (Area area) {
//                   setState(() {
//                     this.areaCtrl.text = area.title;
//                   });
//                 },
//                 suggestionsDirection: SuggestionsDirection.down,
//                 suggestionWidgetSize: 50.0,
//                 itemBuilder: (context, suggestion) => new Padding(
//                     child: new ListTile(
//                       title: new Text(suggestion.title),
//                     ),
//                     padding: const EdgeInsets.all(4.0)),
//                 itemFilter: (suggestion, input) =>
//                     suggestion.title.toLowerCase().contains(input.toLowerCase()),
//                 clearOnSubmit: false,
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream:areaCtrl.text==''?FirebaseFirestore.instance.collection('movie').snapshots():
//                 FirebaseFirestore.instance.collection('movie').where('search',arrayContains: areaCtrl.text.toUpperCase()).snapshots(),
//                 builder: (context,snapshot){
//                   if(!snapshot.hasData){
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   if(snapshot.data.docs.isEmpty){
//                     return Center(
//                       child: Text('No Videos Found',style: TextStyle(
//                           color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18
//                       ),),
//                     );
//                   }
//                   var data=snapshot.data.docs;
//
//                   return  GridView.builder(
//                       itemCount: data.length,
//                       padding: EdgeInsets.all(10),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           childAspectRatio:0.8,
//                           mainAxisSpacing: 10,
//                           crossAxisSpacing: 15
//                       ),
//                       itemBuilder: (context , index){
//                         return InkWell(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieViewWidget(
//                               item:data[index],
//                               autoPlay: true,
//                             )));
//                           },
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           image: NetworkImage(data[index]['thumbnail']),fit: BoxFit.cover
//                                       ),
//                                       color: Colors.grey,
//                                       borderRadius: BorderRadius.circular(10)
//                                   ),
//                                   // child: Align(
//                                   //   alignment: Alignment.bottomCenter,
//                                   //     child: Text(ytVideos[index]['movie'])
//                                   // ),
//                                 ),
//                               ),
//                               SizedBox(height: 5,),
//                               Text(data[index]['title'],maxLines: 1,style: TextStyle(
//                                   color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12
//                               ),),
//                               SizedBox(height: 5,),
//                             ],
//                           ),
//                         );
//                       });
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// class Area {
//   final String title;
//   static List<Area> areas;
//
//   Area({this.title,});
// }
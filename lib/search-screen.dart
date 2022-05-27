// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'main.dart';
// import 'model/my_location.dart';
//
// class Search extends StatelessWidget {
//   TextEditingController textEditingController = TextEditingController();
//
//   Search({Key? key}) : super(key: key);
//
//   CheckForError(String s) async {
//     try {
//       Site site = await LocationViewModel().getLatLonFromCityName(s);
//       return false;
//     } on DioError {
//       return true;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(
//           height: 40,
//         ),
//         IconButton(
//           icon: const Icon(CupertinoIcons.search),
//           color: Colors.white,
//           onPressed: () {
//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return Dialog(
//                     elevation: 10,
//                     backgroundColor: const Color(0xFF232535),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       height: 100,
//                       width: 150,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             TextField(
//                               controller: textEditingController,
//                               style: const TextStyle(
//                                 color: Colors.white,),
//                               decoration: InputDecoration(
//                                   focusedBorder: const OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(color: Color(0xFF2e3341))),
//                                   enabledBorder: const OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(color: Color(0xFF2e3341))),
//                                   hintText: "Location",
//                                   hintStyle: TextStyle(
//                                       color: Colors.grey[600],
//                                   )),
//                             ),
//                             TextButton(
//                                 onPressed: () async {
//                                   if (textEditingController.text.isNotEmpty) {
//                                     bool error = await checkForError(
//                                         textEditingController.text);
//                                     if (error) {
//                                       showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             return Dialog(
//                                               elevation: 10,
//                                               backgroundColor:
//                                               const Color(0xFF232535),
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                   BorderRadius.circular(15),
//                                                 ),
//                                                 height: 100,
//                                                 width: 150,
//                                                 child: Padding(
//                                                   padding:
//                                                   const EdgeInsets.all(8.0),
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                     children: [
//                                                       Column(
//                                                         children: const [
//                                                           SizedBox(
//                                                             height: 10,
//                                                           ),
//                                                           Text(
//                                                             "Location Error",
//                                                             style: TextStyle(
//                                                               color: Colors
//                                                                   .white,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child: const Text(
//                                                           "OK",
//                                                           style: TextStyle(
//                                                             color:
//                                                             Colors.white,
//                                                           ),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           });
//                                     }
//                                     if (!error) {
//                                       MyLocation.cityName= textEditingController
//                                           .text;
//                                       MyLocation.isLocationResult = false;
//                                       //MyLocation.longitude.value
//                                       Navigator.pop(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => MyHomePage(),
//                                         ),
//                                       );
//                                     }
//                                   } else {
//                                     showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return Dialog(
//                                             elevation: 10,
//                                             backgroundColor:
//                                             const Color(0xFF232535),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                 BorderRadius.circular(15),
//                                               ),
//                                               height: 100,
//                                               width: 150,
//                                               child: Padding(
//                                                 padding:
//                                                 const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                                   children: [
//                                                     Column(
//                                                       children: const [
//                                                         SizedBox(
//                                                           height: 10,
//                                                         ),
//                                                         Text(
//                                                           "Please enter a location",
//                                                           style: TextStyle(
//                                                             color:
//                                                             Colors.white,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       child: const Text(
//                                                         "OK",
//                                                         style: TextStyle(
//                                                           color: Colors.white,
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         });
//                                   }
//                                 },
//                                 child: const Text(
//                                   "Search",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                 ))
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 });
//           },
//         ),
//       ],
//     );
//   }
// }
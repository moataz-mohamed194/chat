// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class ChatScreen extends StatelessWidget {
//   final String name;
//   final String uid;
//
//   ChatScreen({required this.uid, required this.name});
//
//
//   final TextEditingController _textEditingController = TextEditingController();
//   //the design of enter messages component
//   _buildMessageComposer() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.0),
//       height: 70.0,
//       // color: Theme.of(context),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: TextField(
//               controller: _textEditingController,
//               textCapitalization: TextCapitalization.sentences,
//               onChanged: (value) {},
//               decoration: InputDecoration.collapsed(
//                 hintText: 'Send a message...',
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             iconSize: 25.0,
//             // color: Theme.of(context).primaryColor,
//             onPressed: () {
//
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               name,
//               style: TextStyle(
//                 // fontSize: 28.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'online',
//               style: TextStyle(
//                 fontSize: 10.0,
//                 // fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//
//         elevation: 0.0,
//       ),
//       body:  Column(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).accentColor,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30.0),
//                     topRight: Radius.circular(30.0),
//                   ),
//                 ),
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30.0),
//                       topRight: Radius.circular(30.0),
//                     ),
//                     // child: StreamBuilder(
//                     //   stream: FirebaseDatabase()
//                     //       .reference()
//                     //       .child('Account')
//                     //       .child("${getMessageService.d0}")
//                     //       .child('Chat')
//                     //       .child('${user.phone}')
//                     //       .onValue,
//                     //   builder: (context, snapshot) {
//                     //     print(
//                     //         "Account; ${getMessageService.d0}; Chat; ${user.phone}");
//                     //     List<Widget> children;
//                     //     try{
//                     //       if(snapshot.hasError){
//                     //         children = <Widget>[ Center(
//                     //           child: Text("${snapshot.error}"),
//                     //         )];
//                     //       }else{
//                     //         Event e;
//                     //         Map<dynamic, dynamic> map ;
//                     //         List<dynamic> list, list0;
//                     //         switch (snapshot.connectionState) {
//                     //           case ConnectionState.none:
//                     //             children = <Widget>[Container(
//                     //               alignment: Alignment.center,
//                     //               width: MediaQuery.of(context).size.width,
//                     //               child: Text("Nothing found!!"),
//                     //             )];
//                     //             break;
//                     //           case ConnectionState.waiting:
//                     //             children = <Widget>[LoadingScreen()];
//                     //             break;
//                     //           case ConnectionState.active:
//                     //             e = snapshot.data;
//                     //             map = e.snapshot.value;
//                     //             list = map.values.toList()
//                     //               ..sort((a, b) => b['Time'].compareTo(a['Time']));
//                     //             print(map.keys);
//                     //             list0 = map.keys.toList()..sort((a, b) => b.compareTo(a));
//                     //             print(map.keys);
//                     //
//                     //             children = <Widget>[Expanded(
//                     //               child: ListView.builder(
//                     //                 itemCount: list.length,
//                     //                 reverse: true,
//                     //                 itemBuilder: (context, index) {
//                     //                   Timestamp myTimeStamp =
//                     //                   Timestamp.fromMicrosecondsSinceEpoch(
//                     //                       list[index]["Time"]+7200000000);
//                     //                   DateTime myDateTime = myTimeStamp.toDate();
//                     //                   String myDateTime0 = myDateTime.toString();
//                     //                   return MessageWidget(date: "${myDateTime0.substring(0, 16)}",
//                     //                     isLiked: list[index]["isLiked"],
//                     //                     id: list0.elementAt(index),
//                     //                     isMe: list[index]["isMe"],
//                     //                     message: list[index]["Body"],
//                     //                     user: user.phone,favorite: false,);
//                     //                 },
//                     //               ),
//                     //             )];
//                     //             break;
//                     //           case ConnectionState.done:
//                     //             e = snapshot.data;
//                     //             map = e.snapshot.value;
//                     //             list = map.values.toList()
//                     //               ..sort((a, b) => b['Time'].compareTo(a['Time']));
//                     //             print(map.keys);
//                     //             children = <Widget>[Expanded(
//                     //               child: ListView.builder(
//                     //                 itemCount: list.length,
//                     //                 reverse: true,
//                     //                 itemBuilder: (context, index) {
//                     //                   Timestamp myTimeStamp =
//                     //                   Timestamp.fromMicrosecondsSinceEpoch(
//                     //                       list[index]["Time"]+7200000000);
//                     //                   DateTime myDateTime = myTimeStamp.toDate();
//                     //                   String myDateTime0 = myDateTime.toString();
//                     //                   return MessageWidget(date: "${myDateTime0.substring(0, 16)}",
//                     //                     isLiked: list[index]["isLiked"],
//                     //                     id: list0.elementAt(index),
//                     //                     isMe: list[index]["isMe"],
//                     //                     message: list[index]["Body"],
//                     //                     user: user.phone,favorite: false,);
//                     //                 },
//                     //               ),
//                     //             )];
//                     //             break;
//                     //         }
//                     //       }}catch(e){
//                     //       return Center(
//                     //         child: Text("Nothing"),
//                     //       );
//                     //     }
//                     //     return Column(
//                     //       children: children,
//                     //     );
//                     //   },
//                     // )),
//               ),
//             ),),
//             _buildMessageComposer(),
//           ],
//         ),
//
//     );
//   }
// }

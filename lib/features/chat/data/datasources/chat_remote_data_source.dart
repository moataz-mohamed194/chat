import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ domain/entities/ChatEntities.dart';
import '../../../../core/error/Exception.dart';
import '../models/ChatModel.dart';
import 'package:http/http.dart' as http;

abstract class ChatRemoteDataSource {
  Future<Unit> addMeg(ChatEntities meg);
  Future<List<MessageModel>> getMeg(String toWho);
}

class ChatRemoteDataSourceImple extends ChatRemoteDataSource {
  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final String serverToken = 'eb4b98e0b9fb638f7f4f6e1b047da58bbd245803';

  Future<String> sendAndRetrieveMessage(String myId, String uId, String meg) async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      Map yourData=(await FirebaseDatabase.instance.ref(uId.toString()).once()).snapshot.value as Map;
      String name = yourData['name'];
      String yourToken = yourData['fcmToken'];
      // print(number['name']);

      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAATAwkXYk:APA91bFDhUKqhqHxbGZBwoX1ERsweXhgHrHzb367REn2Ajn7evwZvWH0Eak_Qh7x61SWqQZKZnpq-iQYqBE3Js-R90ncR3QWKE0qHbgoK8M5DJj1I3I-ia9QOzjREG0lmSnA2MiWDGWZ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': '$meg',
              'title': 'new message'
            },
            'priority': 'high',
            // 'data': <String, dynamic>{
            //   'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            //   'id': '1',
            //   'sound': 'pristine.mp3',
            //   'status': 'done'
            // },
            'to': yourToken
                // "d9DObnnLTbyUSkxuR_MAUB:APA91bHZq6zq54EP9CkZfVDYWlFWYzdu9UNFue3zjvkqMHQssB-Sg43rS_HrscWc-bT656tDw2q4Xgn50DZ75yWB3l-gEp9UDxMOAJAYBAdzuSMqGqWhZX75fuQ4kR-Sc0TuC2I82nUi"
          },
        ),
      );
      print('response: ${response}');
      print('body: ${response.body}');
      print('statusCode: ${response.statusCode}');
      print('headers: ${response.headers}');

      return response.statusCode.toString();//response.statusCode.toString();
    } catch (e) {
      return  e.toString();
    }
  }

  @override
  Future<Unit> addMeg(ChatEntities meg) async {
    try {
      DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

      DateTime currentPhoneDate = DateTime.now().toUtc(); //DateTime
      var formatted = formatter.format(currentPhoneDate);
      DateTime dateTime = DateTime.parse(formatted);
      Timestamp myTimeStamp = Timestamp.fromDate(dateTime);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? myId = prefs.getString('uid');
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('$myId/messages/${meg.toWho}/${myTimeStamp.microsecondsSinceEpoch}');

      await ref.set({"message": meg.meg, "to": meg.toWho, "my": true}).onError(
          (error, stackTrace) => print(error));
      DatabaseReference ref2 =
          FirebaseDatabase.instance.ref('${meg.toWho}/messages/$myId/${myTimeStamp.microsecondsSinceEpoch}');

      await ref2.set({"message": meg.meg, "to": myId, 'my': false}).onError(
          (error, stackTrace) => print(error));
      sendAndRetrieveMessage(myId.toString(),meg.toWho.toString(), meg.meg.toString());
      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<List<MessageModel>> getMeg(String toWho) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? myId = prefs.getString('uid');

      final ref = FirebaseDatabase.instance.ref('$myId/messages/$toWho').orderByKey();
      final snapshot = await ref.get();
      if (snapshot.value == null) {
        return [];
      }
      Map map = snapshot.value as Map;
      List<MessageModel> list = [];
      map.forEach((key, value) {
        MessageModel sickModel = MessageModel(
          you: value['my'],
          meg: value['message'],
        );
        list.add(sickModel);
      });
      return list;
    } catch (e) {
      throw OfflineException();
    }
  }
}

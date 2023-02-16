import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ domain/entities/sick.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/string/basic.dart';
import '../models/SickModel.dart';

abstract class SickRemoteDataSource {
  Future<Unit> addSick(Sick sick);
  Future<List<SickModel>> getSick(String toWho);
}

class SickRemoteDataSourceImple extends SickRemoteDataSource {
  @override
  Future<Unit> addSick(Sick sick) async {
    try {
      print(sick);
      print('meg: ${sick.meg}');
      print('to: ${sick.toWho}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? myId = prefs.getString('uid');
      print('my id: ${myId}');
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('$myId/messages/${sick.toWho}').push();

      await ref
          .set({"message": sick.meg, "to": sick.toWho, "my": true}).onError(
              (error, stackTrace) => print(error));
      DatabaseReference ref2 =
          FirebaseDatabase.instance.ref('${sick.toWho}/messages/$myId').push();

      await ref2.set({"message": sick.meg, "to": myId, 'my': false}).onError(
          (error, stackTrace) => print(error));
      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<List<SickModel>> getSick(String toWho) async {
    print('to: ${toWho}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? myId = prefs.getString('uid');
    print('my id: ${myId}');

    final ref = FirebaseDatabase.instance.ref('$myId/messages/$toWho');
    final snapshot = await ref.get();
    // if (snapshot.exists) {
    Map map = snapshot.value as Map;
    List<SickModel> list = [];
    map.forEach((key, value) {
      SickModel sickModel = SickModel(
        you: value['my'],
        meg: value['message'],
      );
      list.add(sickModel);
    });
    // Map<String, String> newMap = dataOfBanks.map((key, value) => MapEntry(key, value["name"]));
    print(list);
    return list; //[SickModel(id: 1, you: true, meg: 'meg'), SickModel(id: 2, you: false, meg: 'meg meg')];
    // throw OfflineException();
  }
}

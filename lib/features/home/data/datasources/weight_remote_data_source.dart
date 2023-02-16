import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/Exception.dart';
import '../../../auth/data/datasources/online_not_online.dart';

abstract class WeightRemoteDataSource {
  Future<Map?> getWeight();
  Future<Unit> logOut();
}

class WeightRemoteDataSourceImple extends WeightRemoteDataSource {
  @override
  Future<Map?> getWeight() async {
    try {
      // final DatabaseReference _itemsRef = FirebaseDatabase.instance.reference();
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.get();
      // if (snapshot.exists) {
      Map dataOfBanks = snapshot.value as Map;
      Map<String, String> newMap =
          dataOfBanks.map((key, value) => MapEntry(key, value["name"]));

      // List dataList = dataOfBanks.values.toList();
      // List namesList = dataList.map((data) => data["name"]).toList();
      return newMap;
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> logOut() async {
    // TODO: implement logOut
    try {

      OnlineNotOnline().changeStatusToBeOffline();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', 'null');
      prefs.setBool('login', false);

      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
  }
}

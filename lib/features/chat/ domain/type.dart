import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class type{
  Stream<dynamic> action(String uid)  async*{

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? myId = prefs.getString('uid');

    final ref = FirebaseDatabase.instance.ref('$uid');
    final snapshot = await ref.get();
    // if (snapshot.exists) {
    Map dataOfBanks = snapshot.value as Map;
    print(dataOfBanks['State']);
    // Map<dynamic, dynamic> newMap =
    // dataOfBanks.map((key, value) => MapEntry(key, value["name"]));
    // print('cccc');
// print(newMap);
yield dataOfBanks['State']!;
  }
}
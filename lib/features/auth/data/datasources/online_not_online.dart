import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnlineNotOnline {
  changeStatusToBeOnline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? uLogin = prefs.getBool('login');
    if (uLogin == true) {
      String? uid = prefs.getString('uid');
      await FirebaseDatabase.instance.ref().update({'$uid/State': 'online'});
    }
  }

  changeStatusToBeOffline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? uLogin = prefs.getBool('login');
    if (uLogin == true) {
      String? uid = prefs.getString('uid');
      await FirebaseDatabase.instance.ref().update({'$uid/State': ''});
    }
  }
}

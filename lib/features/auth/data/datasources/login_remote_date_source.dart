import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ domain/entities/login.dart';
import '../../../../core/error/Exception.dart';
import 'online_not_online.dart';

String verification = '';

abstract class LoginRemoteDataSource {
  Future<Unit> loginMethod(Login login);
  Future<Unit> loginByPhoneMethod(Login login);
  Future<Unit> createAccountMethod(Login login);
  Future<Unit> vilificationPhoneMethod(Login login);
}

class LoginRemoteDataSourceImple extends LoginRemoteDataSource {
  // final http.Client client;

  @override
  Future<Unit> loginMethod(Login login) async {
    final body = {
      'email': login.email.toString(),
      'password': login.password.toString()
    };
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print('token: ${fcmToken}');

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: login.email.toString(),
              password: login.password.toString())
          .onError((error, stackTrace) {
        throw FailuresLoginException();
      });
      // credential.user.uid
      await FirebaseDatabase.instance.ref().update({'${credential.user!.uid}/fcmToken': fcmToken.toString()});

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', credential.user!.uid);
      prefs.setBool('login', true);
      OnlineNotOnline().changeStatusToBeOnline();
      await FirebaseDatabase.instance.ref().update({'${credential.user!.uid}/fcmToken': fcmToken.toString()});
      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> createAccountMethod(Login login) async {
    final body = {
      'email': login.email.toString(),
      'password': login.password.toString(),
      'name': login.name.toString(),
      'phoneNumber': login.phoneNumber.toString(),
      'code': login.code.toString()
    };
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: login.email.toString(),
              password: login.password.toString())
          .onError((error, stackTrace) {
        throw FailuresLoginException();
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', credential.user!.uid);
      prefs.setBool('login', true);
      DatabaseReference ref =
          FirebaseDatabase.instance.ref(credential.user!.uid);
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print('token: ${fcmToken}');
      await ref.set({
        "name": login.name.toString(),
        "phoneNumber": login.phoneNumber.toString(),
        'password': login.password.toString(),
        "email": login.email.toString(),
        "State": "online",
        "fcmToken": fcmToken.toString()
      }).onError((error, stackTrace) => print(error));
      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> vilificationPhoneMethod(Login login) async {
    print('vilificationPhoneMethod');
    try {
      final body = {
        'email': login.email.toString(),
        'password': login.password.toString(),
        'name': login.name.toString(),
        'phoneNumber': login.phoneNumber.toString()
      };
      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: '+20${body["phoneNumber"]}',
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        verificationCompleted: (PhoneAuthCredential credential) {},
        codeSent: (String verificationId, int? resendToken) {
          verification = verificationId;
          print(resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return Future.value(unit);
    } catch (e) {
      throw FailuresLoginException();
    }
  }

  @override
  Future<Unit> loginByPhoneMethod(Login login) async {

    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print('token: ${fcmToken}');
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.get();
      // if (snapshot.exists) {
      Map dataOfBanks = snapshot.value as Map;
      print("dataOfBanks: $dataOfBanks");
      // final credential = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(
      //     email: login.email.toString(),
      //     password: login.password.toString())
      //     .onError((error, stackTrace) {
        throw FailuresLoginException();
      // });
      // // credential.user.uid
      // await FirebaseDatabase.instance.ref().update({'${credential.user!.uid}/fcmToken': fcmToken.toString()});
      //
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('uid', credential.user!.uid);
      // prefs.setBool('login', true);
      // OnlineNotOnline().changeStatusToBeOnline();
      // await FirebaseDatabase.instance.ref().update({'${credential.user!.uid}/fcmToken': fcmToken.toString()});
      return Future.value(unit);
    } catch (e) {
      throw OfflineException();
    }
    throw UnimplementedError();
  }
}

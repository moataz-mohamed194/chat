import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ domain/entities/login.dart';
import '../../../../core/error/Exception.dart';
import 'online_not_online.dart';

String verification = '';

abstract class LoginRemoteDataSource {
  Future<Unit> loginMethod(Login login);
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
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: login.email.toString(),
              password: login.password.toString())
          .onError((error, stackTrace) {
        throw FailuresLoginException();
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', credential.user!.uid);
      prefs.setBool('login', true);
      OnlineNotOnline().changeStatusToBeOnline();

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

      await ref.set({
        "name": login.name.toString(),
        "phoneNumber": login.phoneNumber.toString(),
        "email": login.email.toString(),
        "State": "online"
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
}

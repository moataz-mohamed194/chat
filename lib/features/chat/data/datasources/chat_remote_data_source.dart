import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ domain/entities/ChatEntities.dart';
import '../../../../core/error/Exception.dart';
import '../models/ChatModel.dart';

abstract class ChatRemoteDataSource {
  Future<Unit> addMeg(ChatEntities meg);
  Future<List<MessageModel>> getMeg(String toWho);
}

class ChatRemoteDataSourceImple extends ChatRemoteDataSource {
  @override
  Future<Unit> addMeg(ChatEntities meg) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? myId = prefs.getString('uid');
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('$myId/messages/${meg.toWho}').push();

      await ref
          .set({"message": meg.meg, "to": meg.toWho, "my": true}).onError(
              (error, stackTrace) => print(error));
      DatabaseReference ref2 =
          FirebaseDatabase.instance.ref('${meg.toWho}/messages/$myId').push();

      await ref2.set({"message": meg.meg, "to": myId, 'my': false}).onError(
          (error, stackTrace) => print(error));
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

      final ref = FirebaseDatabase.instance.ref('$myId/messages/$toWho');
      final snapshot = await ref.get();
      if(snapshot.value == null){
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
    }
    catch(e){
      throw OfflineException();
    }
  }
}

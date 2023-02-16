import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';

class CheckerCubit0 extends Cubit<String> {
  final databaseReference = FirebaseDatabase.instance.ref();
  final String uid;
  CheckerCubit0(this.uid) : super('');
  Future<void> getDataFromFirebase(String uid) async {
    final ref = FirebaseDatabase.instance.ref('${uid}');
    final snapshot = await ref.get();
    Map dataOfBanks = snapshot.value as Map;
    emit(dataOfBanks['State']);
  }
}
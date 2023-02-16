import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ pages/chat.dart';
import '../../../chat/presentation/ pages/get_all_sicks.dart';
import '../bloc/add_weight_bloc.dart';
import '../bloc/add_weight_event.dart';

class WeightListWidget extends StatelessWidget {
  final Map weight;
  const WeightListWidget({Key? key, required this.weight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weight.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChatScreen(
                    name: weight.values.toList()[index],
                    uid: weight.keys.toList()[index])));
          },
          title: Text(weight.values.toList()[index]),
        );
      },
    );
  }
}

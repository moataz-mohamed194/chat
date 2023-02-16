import 'package:flutter/material.dart';
import '../../../chat/presentation/ pages/get_all_sicks.dart';

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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/presentation/eyesBloc/CheckerCubit.dart';
import '../../../chat/presentation/ pages/get_all_messages.dart';
import '../../../chat/presentation/CheckBoxBloc/CheckerCubit.dart';

class WeightListWidget extends StatelessWidget {
  final Map weight;
  const WeightListWidget({Key? key, required this.weight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weight.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () async {
            BlocProvider.of<CheckerCubit0>(context).getDataFromFirebase(weight.keys.toList()[index]);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? myId = prefs.getString('uid');

            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChatScreen(
                    name: weight.values.toList()[index],
                    myId:myId!,
                    uid: weight.keys.toList()[index])));
          },
          title: Text(weight.values.toList()[index]),
        );
      },
    );
  }
}

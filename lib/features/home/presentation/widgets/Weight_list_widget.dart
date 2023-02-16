import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/eyesBloc/CheckerCubit.dart';
import '../../../chat/presentation/ pages/get_all_sicks.dart';
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
          onTap: () {
            BlocProvider.of<CheckerCubit0>(context).getDataFromFirebase(weight.keys.toList()[index]);

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

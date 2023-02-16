import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/sick.dart';
import 'form_widget.dart';

class SickListWidget extends StatelessWidget {
  final List<Sick> sick;
  final String uid;

  const SickListWidget({Key? key, required this.sick, required this.uid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: sick.length,
            itemBuilder: (context, index) {
              print(sick[index]);
              return Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      sick[index].meg.toString(),
                      style: TextStyle(
                          color: sick[index].you ? Colors.green : Colors.red),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Divider(thickness: 1),
          ),
        ),
        MessageComposer(uid: uid)
      ],
    );
  }
}

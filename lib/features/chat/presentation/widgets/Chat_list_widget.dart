import 'package:flutter/material.dart';

import '../../ domain/entities/ChatEntities.dart';
import 'form_widget.dart';

class ChatListWidget extends StatelessWidget {
  final List<ChatEntities> sick;
  final String uid;

  const ChatListWidget({Key? key, required this.sick, required this.uid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: sick.length,
            itemBuilder: (context, index) {
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

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
          child: ListView.builder(
            itemCount: sick.length,
            itemBuilder: (context, index) {
              return
                  Container(
                    width:1  ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: Colors.black12
                    ),
                    alignment:sick[index].you ?Alignment.centerRight: Alignment.centerLeft,
                    child: Text(
                      sick[index].meg.toString(),
                      style: TextStyle(
                          color: Colors.green),
                    ),
                  );
            },
            // separatorBuilder: (context, index) => Divider(thickness: 1),
          ),
        ),
        MessageComposer(uid: uid)
      ],
    );
  }
}

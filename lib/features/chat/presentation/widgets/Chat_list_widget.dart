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
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height-160,
          child: ListView.builder(
            // shrinkWrap: true,
            // reverse: true,
            itemCount: sick.length,
            itemBuilder: (context, index) {
              return
                  Container(
                    height:50  ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0),
                      ),
                      color: Colors.black12
                    ),

                    padding: sick[index].you ?EdgeInsets.only(right: 10): EdgeInsets.only(left: 10),
                    margin: sick[index].you ?EdgeInsets.only(left: MediaQuery.of(context).size.width/2): EdgeInsets.only(right: MediaQuery.of(context).size.width/2),
                    alignment:sick[index].you ?Alignment.centerRight: Alignment.centerLeft,
                    child: Text(
                      sick[index].meg.toString(),
                      style: const TextStyle(
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

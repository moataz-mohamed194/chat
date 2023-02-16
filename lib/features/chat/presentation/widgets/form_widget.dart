import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/ChatEntities.dart';
import '../bloc/add_chat_bloc.dart';
import '../bloc/add_chat_event.dart';

class MessageComposer extends StatelessWidget {
  final String uid;
  final TextEditingController _textEditingController = TextEditingController();

  MessageComposer({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      // color: Theme.of(context),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            onPressed: () {
              try {
                final sick = ChatEntities(
                    id: 0,
                    you: true,
                    meg: _textEditingController.text,
                    toWho: uid);
                BlocProvider.of<AddUpdateGetChatBloc>(context)
                    .add(AddMessageEvent(meg: sick));
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}

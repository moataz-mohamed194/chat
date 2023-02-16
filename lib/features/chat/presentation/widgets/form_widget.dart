import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/sick.dart';
import '../bloc/add_sick_bloc.dart';
import '../bloc/add_sick_event.dart';

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
            // color: Theme.of(context).primaryColor,
            onPressed: () {
              try {
                final sick = Sick(
                    id: 0,
                    you: true,
                    meg: _textEditingController.text,
                    toWho: uid);
                BlocProvider.of<AddUpdateGetSickBloc>(context)
                    .add(AddSickEvent(sick: sick));
              } catch (e) {
                print(e);
              }
              print(uid);
            },
          ),
        ],
      ),
    );
  }
}

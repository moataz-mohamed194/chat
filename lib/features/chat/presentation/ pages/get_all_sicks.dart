import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart' as di;
import '../../../../core/widgets/message_display_widget.dart';
import '../bloc/add_chat_bloc.dart';
import '../bloc/add_chat_event.dart';
import '../bloc/add_chat_state.dart';
import '../widgets/Chat_list_widget.dart';

class ChatScreen extends StatelessWidget {
  final String name;
  final String uid;

  ChatScreen({required this.uid, required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                // fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'online',
              style: TextStyle(
                fontSize: 10.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: BlocProvider<AddUpdateGetChatBloc>(
            create: (context) => di.sl<AddUpdateGetChatBloc>()
              ..add(GetMessagesEvent(
                toWho: uid,
              )),
            child: BlocBuilder<AddUpdateGetChatBloc, AddUpdateGetChatState>(
              builder: (context, state) {

                if (state is LoadingState) {
                  return LoadingWidget();
                } else if (state is LoadedState) {
                  return RefreshIndicator(
                      onRefresh: () => _onRefresh(context),
                      child: ChatListWidget(sick: state.sicks, uid: uid));
                } else if (state is ErrorState) {
                  return MessageDisplayWidget(message: state.message);
                }else if (state is MessageAddUpdateGetState) {
                  di.sl<AddUpdateGetChatBloc>()
                    .add(GetMessagesEvent(
                      toWho: uid,
                    ));
                  // Navigator.pop(context);
                  return Container();
                }
                return LoadingWidget();
              },
            )));
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddUpdateGetChatBloc>(context)
          .add(RefreshMessagesEvent(toWho: uid));
    } catch (e) {
      print(e);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart' as di;
import '../../../../core/widgets/message_display_widget.dart';
import '../bloc/add_sick_bloc.dart';
import '../bloc/add_sick_event.dart';
import '../bloc/add_sick_state.dart';
import '../widgets/Sick_list_widget.dart';

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
        child: BlocProvider<AddUpdateGetSickBloc>(
            create: (context) => di.sl<AddUpdateGetSickBloc>()
              ..add(GetSickEvent(
                toWho: uid,
              )),
            child: BlocBuilder<AddUpdateGetSickBloc, AddUpdateGetSickState>(
              builder: (context, state) {
                print(state);
                if (state is LoadingSicksState) {
                  return LoadingWidget();
                } else if (state is LoadedSicksState) {
                  return RefreshIndicator(
                      onRefresh: () => _onRefresh(context),
                      child: SickListWidget(sick: state.sicks, uid: uid));
                } else if (state is ErrorSicksState) {
                  return MessageDisplayWidget(message: state.message);
                }
                return LoadingWidget();
              },
            )));
  }

  _onRefresh(BuildContext context) async {
    try {
      BlocProvider.of<AddUpdateGetSickBloc>(context)
          .add(RefreshSickEvent(toWho: uid));
    } catch (e) {
      print(e);
    }
  }
}

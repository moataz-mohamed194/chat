import 'package:equatable/equatable.dart';

import '../../ domain/entities/ChatEntities.dart';

abstract class AddUpdateGetChatEvent extends Equatable {
  const AddUpdateGetChatEvent();

  @override
  List<Object> get props => [];
}

class AddMessageEvent extends AddUpdateGetChatEvent {
  final ChatEntities meg;

  AddMessageEvent({required this.meg});

  @override
  List<Object> get props => [meg];
}

class GetMessagesEvent extends AddUpdateGetChatEvent {
  final String toWho;

  GetMessagesEvent({required this.toWho});

  @override
  List<Object> get props => [toWho];
}

class RefreshMessagesEvent extends AddUpdateGetChatEvent {
  final String toWho;
  RefreshMessagesEvent({required this.toWho});

  @override
  List<Object> get props => [toWho];
}

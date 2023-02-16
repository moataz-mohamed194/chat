import 'package:equatable/equatable.dart';

import '../../ domain/entities/ChatEntities.dart';

abstract class AddUpdateGetChatState extends Equatable {
  const AddUpdateGetChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends AddUpdateGetChatState {}

class LoadingState extends AddUpdateGetChatState {}

class LoadedState extends AddUpdateGetChatState {
  final List<ChatEntities> sicks;

  LoadedState({required this.sicks});

  @override
  List<Object> get props => [sicks];
}

class ErrorState extends AddUpdateGetChatState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddUpdateGetState extends AddUpdateGetChatState {
  final String message;

  MessageAddUpdateGetState({required this.message});

  @override
  List<Object> get props => [message];
}

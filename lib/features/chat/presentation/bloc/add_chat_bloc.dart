import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/ChatEntities.dart';
import '../../ domain/usecases/add _message.dart';
import '../../ domain/usecases/get_all_message.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import 'add_chat_event.dart';
import 'add_chat_state.dart';

class AddUpdateGetChatBloc
    extends Bloc<AddUpdateGetChatEvent, AddUpdateGetChatState> {
  final AddMessage addSick;
  final GetAllMessage getSick;

  AddUpdateGetChatBloc({required this.addSick, required this.getSick})
      : super(ChatInitial()) {
    on<AddUpdateGetChatEvent>((event, emit) async {
      if (event is AddMessageEvent) {
        emit(LoadingState());
        final failureOrDoneMessage = await addSick(event.meg);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is GetMessagesEvent) {
        emit(LoadingState());
        final failureOrDoneMessage = await getSick(event.toWho);
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      } else if (event is RefreshMessagesEvent) {
        emit(LoadingState());
        final failureOrDoneMessage = await getSick(event.toWho);
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}

AddUpdateGetChatState _mapFailureOrPostsToStateForAdd(
    Either<Failures, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorState(message: _mapFailureToMessage(failure)),
    (_) => MessageAddUpdateGetState(
      message: message,
    ),
  );
}

AddUpdateGetChatState _mapFailureOrPostsToStateForGet(
    Either<Failures, List<ChatEntities>> either) {
  return either.fold(
    (failure) => ErrorState(message: _mapFailureToMessage(failure)),
    (sicks) => LoadedState(
      sicks: sicks,
    ),
  );
}

String _mapFailureToMessage(Failures failure) {
  switch (failure.runtimeType) {
    case OfflineFailures:
      return SERVER_FAILURE_MESSAGE;
    case OfflineFailures:
      return OFFLINE_FAILURE_MESSAGE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}

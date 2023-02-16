import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/sick.dart';
import '../../ domain/usecases/add _sick.dart';
import '../../ domain/usecases/get_all_sicks.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import 'add_sick_event.dart';
import 'add_sick_state.dart';

class AddUpdateGetSickBloc
    extends Bloc<AddUpdateGetSickEvent, AddUpdateGetSickState> {
  final AddSick addSick;
  final GetAllSick getSick;

  AddUpdateGetSickBloc({required this.addSick, required this.getSick})
      : super(SickInitial()) {
    on<AddUpdateGetSickEvent>((event, emit) async {
      if (event is AddSickEvent) {
        emit(LoadingSicksState());
        final failureOrDoneMessage = await addSick(event.sick);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is GetSickEvent) {
        emit(LoadingSicksState());
        final failureOrDoneMessage = await getSick(event.toWho);
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      } else if (event is RefreshSickEvent) {
        emit(LoadingSicksState());
        final failureOrDoneMessage = await getSick(event.toWho);
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}

AddUpdateGetSickState _mapFailureOrPostsToStateForAdd(
    Either<Failures, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorSicksState(message: _mapFailureToMessage(failure)),
    (_) => MessageAddUpdateGetSickState(
      message: message,
    ),
  );
}

AddUpdateGetSickState _mapFailureOrPostsToStateForGet(
    Either<Failures, List<Sick>> either) {
  return either.fold(
    (failure) => ErrorSicksState(message: _mapFailureToMessage(failure)),
    (sicks) => LoadedSicksState(
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

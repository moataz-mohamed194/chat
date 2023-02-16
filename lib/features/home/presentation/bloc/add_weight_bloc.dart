import 'package:chat/features/home/%20domain/usecases/log_out.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/usecases/get_all_weight.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import 'add_weight_event.dart';
import 'add_weight_state.dart';

class AddUpdateGetWeightBloc
    extends Bloc<AddUpdateGetWeightEvent, AddUpdateGetWeightState> {
  final GetAllUseCases getAllWeight;
  final LogOutUseCases logOut;

  AddUpdateGetWeightBloc({required this.getAllWeight, required this.logOut})
      : super(WeightInitial()) {
    on<AddUpdateGetWeightEvent>((event, emit) async {
      if (event is GetWeightEvent || event is RefreshWeightEvent) {
        emit(LoadingWeightState());
        final failureOrDoneMessage = await getAllWeight();
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      } else if (event is LogoutEvent) {
        emit(LoadingWeightState());
        final failureOrDoneMessage = await logOut();
        emit(_mapFailureOrPostsToStateForAdd(failureOrDoneMessage, 'DONE'));
      }
    });
  }
}

AddUpdateGetWeightState _mapFailureOrPostsToStateForAdd(
    Either<Failures, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorWeightState(message: _mapFailureToMessage(failure)),
    (_) => MessageAddUpdateGetWeightState(
      message: message,
    ),
  );
}

AddUpdateGetWeightState _mapFailureOrPostsToStateForGet(
    Either<Failures, Map?> either) {
  return either.fold(
    (failure) => ErrorWeightState(message: _mapFailureToMessage(failure)),
    (weight) => LoadedWeightState(
      weight: weight,
    ),
  );
}

String _mapFailureToMessage(Failures failure) {
  switch (failure.runtimeType) {
    case OfflineFailures:
      return SERVER_FAILURE_MESSAGE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}

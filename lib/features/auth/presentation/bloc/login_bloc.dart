import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/usecases/create_user.dart';
import '../../ domain/usecases/login_by_phone_usecases.dart';
import '../../ domain/usecases/login_usecases.dart';
import '../../ domain/usecases/vilification_phone.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCases loginMethod;
  final LoginByPhoneUseCases loginByPhoneMethod;
  final CreateUseCases createUseMethod;
  final VilificationPhoneUseCases vilificationPhoneUseMethod;

  LoginBloc(
      {required this.loginMethod,
      required this.createUseMethod,
      required this.loginByPhoneMethod,
      required this.vilificationPhoneUseMethod})
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginMethodEvent) {
        emit(LoadingLoginState());
        final failureOrDoneMessage = await loginMethod(event.login);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, LOGIN_SUCCESS_MESSAGE));
      } else if (event is LoginByPhoneMethodEvent) {
        emit(LoadingLoginState());
        final failureOrDoneMessage = await loginByPhoneMethod(event.login);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, LOGIN_SUCCESS_MESSAGE));
      } else if (event is AddUserEvent) {
        emit(LoadingCreateState());
        final failureOrDoneMessage = await createUseMethod(event.login);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is VerificationUserEvent) {
        emit(LoadingVerificationState());
        final failureOrDoneMessage =
            await vilificationPhoneUseMethod(event.login);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      }
    });
  }

  LoginState _mapFailureOrPostsToStateForAdd(
      Either<Failures, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorLoginState(message: _mapFailureToMessage(failure)),
      (_) => MessageLoginState(
        message: message,
      ),
    );
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case UsedDataFailures:
        return OLD_DATA;
      case CheckDataFailures:
        return LOGIN_FAILURE_MESSAGE;
      case OfflineFailures:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailures:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return OLD_DATA;
    }
  }
}

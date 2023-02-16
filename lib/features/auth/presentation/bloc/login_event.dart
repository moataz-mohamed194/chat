import 'package:equatable/equatable.dart';

import '../../ domain/entities/login.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class RefreshLoginEvent extends LoginEvent {}

class LoginMethodEvent extends LoginEvent {
  final Login login;

  LoginMethodEvent({required this.login});

  @override
  List<Object> get props => [login];
}

class AddUserEvent extends LoginEvent {
  final Login login;

  AddUserEvent({required this.login});

  @override
  List<Object> get props => [login];
}

class VerificationUserEvent extends LoginEvent {
  final Login login;

  VerificationUserEvent({required this.login});

  @override
  List<Object> get props => [login];
}

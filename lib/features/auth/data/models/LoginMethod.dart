import '../../ domain/entities/login.dart';

class LoginMethod extends Login {
  LoginMethod(
      {required String email,
      required String password,
      String? name,
      String? code,
      String? phoneNumber})
      : super(
            email: email,
            password: password,
            name: name,
            code: code,
            phoneNumber: phoneNumber);
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/login.dart';
import '../repositories/Login_repositorie.dart';

class LoginByPhoneUseCases {
  final LoginRepositorie repositorie;

  LoginByPhoneUseCases(this.repositorie);

  Future<Either<Failures, Unit>> call(Login login) async {
    return await repositorie.loginByPhoneMethod(login);
  }
}

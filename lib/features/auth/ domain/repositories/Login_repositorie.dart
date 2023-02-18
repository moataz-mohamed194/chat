import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/login.dart';

abstract class LoginRepositorie {
  Future<Either<Failures, Unit>> loginMethod(Login login);
  Future<Either<Failures, Unit>> loginByPhoneMethod(Login login);
  Future<Either<Failures, Unit>> createAccountMethod(Login login);
  Future<Either<Failures, Unit>> vilificationPhoneMethod(Login login);
}

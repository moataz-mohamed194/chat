import 'package:dartz/dartz.dart';

import '../../ domain/entities/login.dart';
import '../../ domain/repositories/Login_repositorie.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/login_remote_date_source.dart';
import '../models/LoginMethod.dart';

class LoginRepositoriesImpl extends LoginRepositorie {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, Unit>> loginMethod(Login login) async {
    final LoginMethod loginMethod =
        LoginMethod(email: login.email, password: login.password);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.loginMethod(loginMethod);
        return Right(unit);
      } catch (e) {
        return Left(FailuresLoginFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> createAccountMethod(Login login) async {
    final LoginMethod loginMethod =
        LoginMethod(email: login.email, password: login.password,name: login.name, phoneNumber: login.phoneNumber);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createAccountMethod(loginMethod);
        return Right(unit);
      } catch (e) {
        return Left(FailuresLoginFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> vilificationPhoneMethod(Login login) async {
    final LoginMethod loginMethod =
    LoginMethod(email: login.email, password: login.password,name: login.name, phoneNumber: login.phoneNumber);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.vilificationPhoneMethod(loginMethod);
        return Right(unit);
      } catch (e) {
        return Left(FailuresLoginFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }
}

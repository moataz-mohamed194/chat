import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/weight_repositorie.dart';

class LogOutUseCases {
  final WeightRepository repository;

  LogOutUseCases(this.repository);

  Future<Either<Failures, Unit>> call() async {
    return await repository.LogOut();
  }
}

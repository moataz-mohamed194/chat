import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class WeightRepository {
  Future<Either<Failures, Map?>> getAllWeight();
  Future<Either<Failures, Unit>> LogOut();
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/sick.dart';

abstract class SickRepository {
  Future<Either<Failures, List<Sick>>> getAllSick(String toWho);
  Future<Either<Failures, Unit>> addSick(Sick sick);
}

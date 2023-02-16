import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/sick.dart';
import '../repositories/Sick_repositorie.dart';

class GetAllSick {
  final SickRepository repository;

  GetAllSick(this.repository);

  Future<Either<Failures, List<Sick>>> call(String toWho) async {
    return await repository.getAllSick(toWho);
  }
}

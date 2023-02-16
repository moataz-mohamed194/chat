import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/sick.dart';
import '../repositories/Sick_repositorie.dart';

class AddSick {
  final SickRepository repository;

  AddSick(this.repository);

  Future<Either<Failures, Unit>> call(Sick sick) async {
    return await repository.addSick(sick);
  }
}

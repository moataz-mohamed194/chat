import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/weight_repositorie.dart';

class GetAllUseCases {
  final WeightRepository repository;

  GetAllUseCases(this.repository);

  Future<Either<Failures, Map?>> call() async {
    return await repository.getAllWeight();
  }
}

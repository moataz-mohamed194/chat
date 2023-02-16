import 'package:dartz/dartz.dart';

import '../../ domain/entities/weight.dart';
import '../../ domain/repositories/weight_repositorie.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/weight_remote_data_source.dart';
import '../models/weight_Model.dart';

class WeightRepositoriesImpl implements WeightRepository {
  final WeightRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WeightRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, Map?>> getAllWeight() async {
    if (await networkInfo.isConnected) {
      try {
        final currentWeight = await remoteDataSource.getWeight();
        if (currentWeight != null) {
          return Right(currentWeight);
        } else {
          return Left(OfflineFailures());
        }
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> LogOut() async {
    if (await networkInfo.isConnected) {
      try {
        final currentWeight = await remoteDataSource.logOut();
        if (currentWeight != null) {
          return Right(currentWeight);
        } else {
          return Left(OfflineFailures());
        }
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }
}

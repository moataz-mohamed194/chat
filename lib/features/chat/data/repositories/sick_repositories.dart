import 'package:dartz/dartz.dart';

import '../../ domain/entities/sick.dart';
import '../../ domain/repositories/Sick_repositorie.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/sick_remote_data_source.dart';
import '../models/SickModel.dart';

class SickRepositoriesImpl implements SickRepository {
  final SickRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SickRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failures, Unit>> addSick(Sick sick) async {
    final SickModel sickModel =
        SickModel(id: sick.id, you: sick.you, meg: sick.meg, toWho: sick.toWho);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addSick(sickModel);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List<Sick>>> getAllSick(String toWho) async {
    if (await networkInfo.isConnected) {
      try {
        final currentSick = await remoteDataSource.getSick(toWho);
        return Right(currentSick);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../ domain/entities/ChatEntities.dart';
import '../../ domain/repositories/Chat_repositorie.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/chat_remote_data_source.dart';
import '../models/ChatModel.dart';

class MessageRepositoriesImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MessageRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failures, Unit>> addMessage(ChatEntities meg) async {
    final MessageModel megModel =
        MessageModel(id: meg.id, you: meg.you, meg: meg.meg, toWho: meg.toWho);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addMeg(megModel);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List<ChatEntities>>> getAllMessages(String toWho) async {
    if (await networkInfo.isConnected) {
      try {
        final currentSick = await remoteDataSource.getMeg(toWho);
        return Right(currentSick);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }
}

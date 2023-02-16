import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/ChatEntities.dart';
import '../repositories/Chat_repositorie.dart';

class GetAllMessage {
  final ChatRepository repository;

  GetAllMessage(this.repository);

  Future<Either<Failures, List<ChatEntities>>> call(String toWho) async {
    return await repository.getAllMessages(toWho);
  }
}

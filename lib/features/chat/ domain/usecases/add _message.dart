import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/ChatEntities.dart';
import '../repositories/Chat_repositorie.dart';

class AddMessage {
  final ChatRepository repository;

  AddMessage(this.repository);

  Future<Either<Failures, Unit>> call(ChatEntities chat) async {
    return await repository.addMessage(chat);
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/ChatEntities.dart';

abstract class ChatRepository {
  Future<Either<Failures, List<ChatEntities>>> getAllMessages(String toWho);
  Future<Either<Failures, Unit>> addMessage(ChatEntities meg);
}

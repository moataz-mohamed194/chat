import 'package:equatable/equatable.dart';

class ChatEntities extends Equatable {
  final int? id;
  final bool you;
  final String meg;
  final String? toWho;

  ChatEntities({this.id, required this.you, required this.meg, this.toWho});

  @override
  List<Object?> get props => [id, you, meg];
}

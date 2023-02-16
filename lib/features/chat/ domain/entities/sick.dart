import 'package:equatable/equatable.dart';

class Sick extends Equatable {
  final int? id;
  final bool you;
  final String meg;
  final String? toWho;

  Sick({this.id, required this.you, required this.meg, this.toWho});

  @override
  List<Object?> get props => [id, you, meg];
}

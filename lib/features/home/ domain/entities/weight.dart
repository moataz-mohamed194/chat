import 'package:equatable/equatable.dart';

class Weight extends Equatable {
  final int? id;
  final String name;

  Weight({required this.id, required this.name});

  @override
  List<Object?> get props => [name];
}

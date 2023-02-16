import 'package:equatable/equatable.dart';

import '../../ domain/entities/weight.dart';

abstract class AddUpdateGetWeightEvent extends Equatable {
  const AddUpdateGetWeightEvent();

  @override
  List<Object> get props => [];
}

class AddWeightEvent extends AddUpdateGetWeightEvent {
  final Weight weight;

  AddWeightEvent({required this.weight});

  @override
  List<Object> get props => [Weight];
}

class LogoutEvent extends AddUpdateGetWeightEvent {}

class DeleteWeightEvent extends AddUpdateGetWeightEvent {
  final String weightId;

  DeleteWeightEvent({required this.weightId});

  @override
  List<Object> get props => [weightId];
}

class GetWeightEvent extends AddUpdateGetWeightEvent {}

class RefreshWeightEvent extends AddUpdateGetWeightEvent {}

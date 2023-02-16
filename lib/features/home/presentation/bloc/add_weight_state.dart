import 'package:equatable/equatable.dart';

abstract class AddUpdateGetWeightState extends Equatable {
  const AddUpdateGetWeightState();

  @override
  List<Object> get props => [];
}

class WeightInitial extends AddUpdateGetWeightState {}

class LoadingWeightState extends AddUpdateGetWeightState {}

class LoadedWeightState extends AddUpdateGetWeightState {
  final Map? weight;

  LoadedWeightState({required this.weight});

  @override
  List<Object> get props => [weight!];
}

class ErrorWeightState extends AddUpdateGetWeightState {
  final String message;

  ErrorWeightState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddUpdateGetWeightState extends AddUpdateGetWeightState {
  final String message;

  MessageAddUpdateGetWeightState({required this.message});

  @override
  List<Object> get props => [message];
}

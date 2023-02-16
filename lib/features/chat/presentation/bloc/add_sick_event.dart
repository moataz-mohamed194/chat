import 'package:equatable/equatable.dart';

import '../../ domain/entities/sick.dart';

abstract class AddUpdateGetSickEvent extends Equatable {
  const AddUpdateGetSickEvent();

  @override
  List<Object> get props => [];
}

class AddSickEvent extends AddUpdateGetSickEvent {
  final Sick sick;

  AddSickEvent({required this.sick});

  @override
  List<Object> get props => [sick];
}

class GetSickEvent extends AddUpdateGetSickEvent {
  final String toWho;

  GetSickEvent({required this.toWho});

  @override
  List<Object> get props => [toWho];
}

class RefreshSickEvent extends AddUpdateGetSickEvent {
  final String toWho;
  RefreshSickEvent({required this.toWho});

  @override
  List<Object> get props => [toWho];
}

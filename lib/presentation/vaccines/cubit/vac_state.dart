import 'package:equatable/equatable.dart';
import 'package:fda/app/common/model/vacmodel.dart';

abstract class VacState extends Equatable {
  @override
  List<Object> get props => [];
}

class VacInitial extends VacState {}

class VacLoading extends VacState {}

class VacLoaded extends VacState {
  final List<Vacmodel> reports;

  VacLoaded({required this.reports});

  @override
  List<Object> get props => [reports];
}

class VacError extends VacState {
  final String message;

  VacError({required this.message});

  @override
  List<Object> get props => [message];
}

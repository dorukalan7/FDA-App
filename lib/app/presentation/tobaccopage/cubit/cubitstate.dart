import 'package:equatable/equatable.dart';
import 'package:fda/model/tobaccomodel.dart';

abstract class TobaccoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TobaccoInitial extends TobaccoState {}

class TobaccoLoading extends TobaccoState {}

class TobaccoLoaded extends TobaccoState {
  final List<TobaccoReport> reports;

  TobaccoLoaded({required this.reports});

  @override
  List<Object?> get props => [reports];
}

class TobaccoError extends TobaccoState {
  final String message;

  TobaccoError({required this.message});

  @override
  List<Object?> get props => [message];
}

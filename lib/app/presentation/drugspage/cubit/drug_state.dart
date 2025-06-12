part of 'drug_cubit.dart';

@immutable
abstract class DrugState {}

class DrugInitial extends DrugState {}

class DrugLoading extends DrugState {}

class DrugLoaded extends DrugState {
  final List<DrugInfo> drugs;

  DrugLoaded(this.drugs);
}

class DrugError extends DrugState {
  final String message;

  DrugError(this.message);
}

part of 'status_cubit.dart';

abstract class StatusState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StatusInitial extends StatusState {}

class StatusLoading extends StatusState {}

class StatusLoaded extends StatusState {
  final List<RecallModel> recalls;

  StatusLoaded(this.recalls);

  @override
  List<Object?> get props => [recalls];
}

class StatusError extends StatusState {
  final String message;

  StatusError(this.message);

  @override
  List<Object?> get props => [message];
}

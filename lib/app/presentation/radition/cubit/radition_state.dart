abstract class RadiationState {}

class RadiationInitial extends RadiationState {}

class RadiationLoading extends RadiationState {}

class RadiationLoaded extends RadiationState {
  final List<dynamic> devices;

  RadiationLoaded({required this.devices});
}

class RadiationError extends RadiationState {
  final String message;

  RadiationError({required this.message});
}

part of 'medical_device_cubit.dart';

abstract class MedicalDeviceState extends Equatable {
  @override
  List<Object> get props => [];
}

class MedicalDeviceInitial extends MedicalDeviceState {}

class MedicalDeviceLoading extends MedicalDeviceState {}

class MedicalDeviceLoaded extends MedicalDeviceState {
  final List<dynamic> devices;

  MedicalDeviceLoaded({required this.devices});

  @override
  List<Object> get props => [devices];
}

class MedicalDeviceError extends MedicalDeviceState {
  final String message;

  MedicalDeviceError({required this.message});

  @override
  List<Object> get props => [message];
}

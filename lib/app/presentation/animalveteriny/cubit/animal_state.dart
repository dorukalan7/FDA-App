part of 'animal_cubit.dart';

abstract class AnimalState {}

class AnimalInitial extends AnimalState {}

class AnimalLoading extends AnimalState {}

class AnimalLoaded extends AnimalState {
  final List<AnimalModel> animals;

  AnimalLoaded(this.animals);
}

class AnimalError extends AnimalState {
  final String message;

  AnimalError(this.message);
}

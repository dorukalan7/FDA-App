import 'package:fda/view/animalveteriny/service/animalservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fda/view/animalveteriny/model/animal_model.dart';

part 'animal_state.dart';

class AnimalCubit extends Cubit<AnimalState> {
  final AnimalService animalService;

  AnimalCubit({required this.animalService}) : super(AnimalInitial());

  Future<void> fetchAnimalsBySpecies(String species) async {
    emit(AnimalLoading());
    try {
      final animals = await animalService.fetchAnimalsBySpecies(species);
      emit(AnimalLoaded(animals));
    } catch (e) {
      emit(AnimalError(e.toString()));
    }
  }

  Future<void> fetchAnimalsBySpeciesAndGender(
    String species,
    String gender,
  ) async {
    emit(AnimalLoading());
    try {
      final animals = await animalService.fetchAnimalsBySpeciesAndGender(
        species,
        gender,
      );
      emit(AnimalLoaded(animals));
    } catch (e) {
      emit(AnimalError(e.toString()));
    }
  }
}

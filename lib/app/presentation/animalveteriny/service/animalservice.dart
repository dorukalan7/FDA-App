import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fda/view/animalveteriny/model/animal_model.dart';

class AnimalService {
  final String baseUrl =
      'https://api.fda.gov/animalandveterinary/event.json?limit=40&search=original_receive_date:[20040101+TO+20161107]';

  Future<List<AnimalModel>> fetchAnimalsBySpecies(String species) async {
    final url = '$baseUrl+AND+animal.species:"$species"';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'] ?? [];
      return results.map((e) => AnimalModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch animals');
    }
  }

  Future<List<AnimalModel>> fetchAnimalsBySpeciesAndGender(
    String species,
    String gender,
  ) async {
    final url =
        '$baseUrl+AND+animal.species:"$species"+AND+animal.gender:"$gender"';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'] ?? [];
      return results.map((e) => AnimalModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch animals by species and gender');
    }
  }
}

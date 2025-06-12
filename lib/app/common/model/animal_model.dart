class AnimalModel {
  final String species;
  final String breed;
  final String gender;
  final List<String> reactions;

  AnimalModel({
    required this.species,
    required this.breed,
    required this.gender,
    required this.reactions,
  });

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    List<String> reactionNames = [];

    if (json['reaction'] != null) {
      if (json['reaction'] is List) {
        reactionNames =
            (json['reaction'] as List<dynamic>).map((item) {
              if (item is Map<String, dynamic> &&
                  item['veddra_term_name'] != null) {
                return item['veddra_term_name'].toString();
              } else {
                return item.toString();
              }
            }).toList();
      } else if (json['reaction'] is Map) {
        final item = json['reaction'] as Map<String, dynamic>;
        reactionNames.add(
          item['veddra_term_name']?.toString() ?? item.toString(),
        );
      } else if (json['reaction'] is String) {
        reactionNames.add(json['reaction'] as String);
      }
    }

    // animal alt alanları
    final animal = json['animal'] as Map<String, dynamic>? ?? {};
    final breedMap = animal['breed'] as Map<String, dynamic>?;

    return AnimalModel(
      species: animal['species']?.toString() ?? 'Unknown',
      gender: animal['gender']?.toString() ?? 'Unknown',
      breed: breedMap?['breed_component']?.toString() ?? 'Unknown',
      reactions: reactionNames,
    );
  }
}

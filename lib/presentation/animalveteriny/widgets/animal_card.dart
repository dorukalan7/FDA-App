import 'package:flutter/material.dart';
import 'package:fda/app/common/model/animal_model.dart';

class AnimalCard extends StatelessWidget {
  final AnimalModel animal;

  const AnimalCard({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.08),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white24),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık
            Row(
              children: [
                const Icon(Icons.pets, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  animal.species,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Cins
            _buildInfoRow(Icons.category, 'Breed', animal.breed),

            // Cinsiyet
            _buildInfoRow(Icons.male, 'Gender', animal.gender),

            // Tepkiler
            _buildInfoRow(
              Icons.warning_amber_rounded,
              'Reactions',
              animal.reactions.join(', '),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

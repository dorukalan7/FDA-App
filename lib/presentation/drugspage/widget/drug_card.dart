import 'package:fda/app/common/cubit/favorite_cubit.dart';
import 'package:fda/app/common/model/FavoriteModel.dart';
import 'package:fda/app/common/model/Drug_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrugCard extends StatefulWidget {
  final DrugInfo drug;

  const DrugCard({super.key, required this.drug});

  @override
  State<DrugCard> createState() => _DrugCardState();
}

class _DrugCardState extends State<DrugCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final drug = widget.drug;
    final favoriteItem = FavoriteItem(
      id: drug.applicationNumber,
      title: drug.brandName,
      category: "Drugs",
      data: drug,
    );

    return Card(
      color: Colors.white.withOpacity(0.08),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.white24),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst Bilgiler
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopLabel(
                  Icons.date_range,
                  drug.submissiondate,
                  isDate: true,
                ),
                _buildTopLabel(Icons.numbers, drug.applicationNumber),
              ],
            ),
            const SizedBox(height: 12),

            // Başlık ve genişlet butonu
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.medication_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    drug.brandName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.add,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildInfoRow(Icons.science, "Etken Madde", drug.genericName),
            _buildInfoRow(Icons.business, "Firma", drug.sponsorName),
            _buildInfoRow(Icons.route, "Alım Yolu", drug.route),
            _buildInfoRow(Icons.medical_services, "Dozaj", drug.dosageForm),

            // Favori bölümü
            if (_isExpanded)
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add to Favorites",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    BlocBuilder<FavoritesCubit, List<FavoriteItem>>(
                      builder: (context, state) {
                        final isFavorite = context
                            .read<FavoritesCubit>()
                            .isFavorite(favoriteItem);

                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white70,
                          ),
                          onPressed: () {
                            context.read<FavoritesCubit>().toggleFavorite(
                              favoriteItem,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopLabel(IconData icon, String value, {bool isDate = false}) {
    final color = isDate ? Colors.white : const Color.fromARGB(153, 30, 255, 0);
    final textStyle =
        isDate
            ? const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )
            : const TextStyle(color: Colors.white60, fontSize: 16);

    return Row(
      children: [
        Icon(icon, color: color, size: isDate ? 18 : 16),
        const SizedBox(width: 4),
        Text(value, style: textStyle),
      ],
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

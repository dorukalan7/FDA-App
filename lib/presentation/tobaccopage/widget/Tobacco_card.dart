import 'package:fda/app/common/cubit/favorite_cubit.dart';
import 'package:fda/app/common/model/FavoriteModel.dart';
import 'package:fda/app/common/model/tobaccomodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TobaccoReportCard extends StatefulWidget {
  final TobaccoReport report;

  const TobaccoReportCard({super.key, required this.report});

  @override
  State<TobaccoReportCard> createState() => _TobaccoReportCardState();
}

class _TobaccoReportCardState extends State<TobaccoReportCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final report = widget.report;
    final favoriteItem = FavoriteItem(
      id: report.reportId.toString(), // Benzersiz ID
      title:
          report.tobaccoProducts.isNotEmpty
              ? report.tobaccoProducts.first
              : 'Unknown Product', // Başlık olarak ilk ürün
      category: "TobaccoProducts",
      data: report,
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
            /// Top labels (Date + ID)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopLabel(
                  Icons.date_range,
                  report.dateSubmitted,
                  isDate: true,
                ),
                _buildTopLabel(Icons.report, 'ID: ${report.reportId}'),
              ],
            ),

            const SizedBox(height: 12),

            /// Title row (Health Problem)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.health_and_safety,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    report.reportedHealthProblems.join(', '),
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

            /// Info rows
            _buildInfoRow(
              Icons.warning,
              'Product Problems',
              report.reportedProductProblems.join(', '),
            ),
            _buildInfoRow(
              Icons.smoking_rooms,
              'Tobacco Products',
              report.tobaccoProducts.join(', '),
            ),
            _buildInfoRow(
              Icons.person_off,
              'Nonuser Affected',
              report.nonuserAffected,
            ),
            _buildInfoRow(
              Icons.numbers,
              'Number of Products',
              report.numberTobaccoProducts.toString(),
            ),
            _buildInfoRow(
              Icons.local_hospital,
              'Number of Health Problems',
              report.numberHealthProblems.toString(),
            ),

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

import 'package:fda/app/common/cubit/favorite_cubit.dart';
import 'package:fda/app/common/model/FavoriteModel.dart';
import 'package:fda/app/common/model/vacmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VacReportCard extends StatefulWidget {
  final Vacmodel report;

  const VacReportCard({super.key, required this.report});

  @override
  State<VacReportCard> createState() => _VacReportCardState();
}

class _VacReportCardState extends State<VacReportCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final report = widget.report;
    final favoriteItem = FavoriteItem(
      id: report.packageNdcFirst4,
      title: report.proprietaryName,
      category: "Vaccines",
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
            /// Top labels (Marketing Start Date + Package NDC)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopLabel(
                  Icons.date_range,
                  _formatDate(report.marketingStartDate),
                  isDate: true,
                ),
                _buildTopLabel(Icons.confirmation_num, report.packageNdcFirst4),
              ],
            ),

            const SizedBox(height: 12),

            /// Title row (Proprietary Name)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.vaccines, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    report.proprietaryName,
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
            _buildInfoRow(Icons.category, 'Product Type', report.productType),
            _buildInfoRow(
              Icons.local_offer,
              'Marketing Category',
              report.marketingCategory,
            ),
            _buildInfoRow(Icons.medication, 'Dosage Form', report.dosageForm),
            if (report.applicationNumberOrCitation != null)
              _buildInfoRow(
                Icons.article,
                'Application Number',
                report.applicationNumberOrCitation!,
              ),
            if (report.marketingEndDate != null)
              _buildInfoRow(
                Icons.event_busy,
                'Marketing End Date',
                _formatDate(report.marketingEndDate!),
              ),
            if (report.inactivationDate != null)
              _buildInfoRow(
                Icons.cancel,
                'Inactivation Date',
                _formatDate(report.inactivationDate!),
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

  String _formatDate(String yyyymmdd) {
    if (yyyymmdd.length != 8) return yyyymmdd;
    try {
      final year = yyyymmdd.substring(0, 4);
      final month = yyyymmdd.substring(4, 6);
      final day = yyyymmdd.substring(6, 8);
      return "$day-$month-$year"; // 13-03-2025 gibi
    } catch (e) {
      return yyyymmdd;
    }
  }
}

import 'package:fda/cubit/favorite_cubit.dart';
import 'package:fda/model/FavoriteModel.dart';
import 'package:fda/model/medicaldevicemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalDeviceCard extends StatefulWidget {
  final MedicalDeviceModel device;

  const MedicalDeviceCard({super.key, required this.device});

  @override
  State<MedicalDeviceCard> createState() => _MedicalDeviceCardState();
}

class _MedicalDeviceCardState extends State<MedicalDeviceCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final device = widget.device;
    final favoriteItem = FavoriteItem(
      id: widget.device.pmaNumber,
      title: widget.device.deviceName,
      category: "Medical Devices",
      data: widget.device,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopLabel(
                  Icons.date_range,
                  device.decisionDate,
                  isDate: true,
                ),
                _buildTopLabel(Icons.check_circle, device.decisionCode),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.medical_services,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    device.deviceName,
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

            _buildInfoRow(Icons.numbers, 'PMA Number', device.pmaNumber),
            _buildInfoRow(Icons.business, 'Applicant', device.applicant),
            _buildInfoRow(
              Icons.medical_services,
              'Device Name',
              device.deviceName,
            ),
            _buildInfoRow(
              Icons.people,
              'Advisory Committee',
              device.advisoryCommitteeDescription,
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
                            color:
                                isFavorite ? Colors.redAccent : Colors.white70,
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

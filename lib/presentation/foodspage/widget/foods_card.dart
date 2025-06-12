import 'package:fda/app/common/cubit/favorite_cubit.dart';
import 'package:fda/app/common/model/FavoriteModel.dart';
import 'package:fda/app/common/model/Food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecallCard extends StatefulWidget {
  final RecallModel recall;

  const RecallCard({super.key, required this.recall});

  @override
  State<RecallCard> createState() => _RecallCardState();
}

class _RecallCardState extends State<RecallCard> {
  bool isExpanded = false;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final recall = widget.recall;
    final report = widget.recall;
    final favoriteItem = FavoriteItem(
      id:
          '${report.productDescription}-${report.city}-${report.recallDate ?? 'unknown'}', // Benzersiz ID için kombinasyon
      title: report.productDescription,
      category: "Foods",
      status: recall.status,
      data: report,
    );

    final recallDate = parseDateString(recall.recallDate);

    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Card(
        color: Colors.white.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white24),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tarih ve Durum
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        size: 18,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        recallDate != null
                            ? '${recallDate.day.toString().padLeft(2, '0')}.${recallDate.month.toString().padLeft(2, '0')}.${recallDate.year}'
                            : 'Tarih yok',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          recall.status == 'Terminated'
                              ? Colors.redAccent
                              : recall.status == 'Ongoing'
                              ? Colors.orangeAccent
                              : Colors.greenAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      recall.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Ürün Bilgisi
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.medication_outlined, color: Colors.white70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Ürün Adı: ',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: recall.productDescription,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Lokasyon
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.white70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Lokasyon: ',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: '${recall.city}, ${recall.state}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Favori alanı (expanded durumunda göster)
              if (isExpanded) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Favorilere ekle',
                        style: TextStyle(color: Colors.white70),
                      ),
                      BlocBuilder<FavoritesCubit, List<FavoriteItem>>(
                        builder: (context, state) {
                          final isFavorite = context
                              .read<FavoritesCubit>()
                              .isFavorite(favoriteItem);

                          return IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
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
            ],
          ),
        ),
      ),
    );
  }
}

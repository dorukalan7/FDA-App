import 'package:fda/app/presentation/tobaccopage/cubit/cubit.dart';
import 'package:fda/app/presentation/tobaccopage/cubit/cubitstate.dart';
import 'package:fda/app/presentation/tobaccopage/services/tobacco_service.dart';
import 'package:fda/app/presentation/tobaccopage/widget/Tobacco_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CosmeticStatuss extends StatefulWidget {
  final String title;
  final String status;

  const CosmeticStatuss({required this.title, required this.status, super.key});

  @override
  State<CosmeticStatuss> createState() => _TobaccoStatussState();
}

class _TobaccoStatussState extends State<CosmeticStatuss> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              TobaccoCubit(service: TobaccoService())..fetchReports("active"),
      child: Scaffold(
        body: BlocBuilder<TobaccoCubit, TobaccoState>(
          builder: (context, state) {
            if (state is TobaccoLoading) {
              return _buildGradientBackground(
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            } else if (state is TobaccoError) {
              return _buildGradientBackground(
                child: Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else if (state is TobaccoLoaded) {
              final reports = state.reports;
              return _buildGradientBackground(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '${widget.status} Reports',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // Filtre ikonu ve menüsü
                          PopupMenuButton<SortOrder>(
                            icon: const Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                            color: Colors.white,
                            onSelected: (SortOrder selected) {
                              context.read<TobaccoCubit>().sortReports(
                                selected,
                              );
                            },
                            itemBuilder:
                                (context) => const [
                                  PopupMenuItem<SortOrder>(
                                    value: SortOrder.descending,
                                    child: Text("Yeniden Eskiye"),
                                  ),
                                  PopupMenuItem<SortOrder>(
                                    value: SortOrder.ascending,
                                    child: Text("Eskiden Yeniye"),
                                  ),
                                ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ...reports
                          .map((report) => TobaccoReportCard(report: report))
                          .toList(),
                    ],
                  ),
                ),
              );
            }

            return _buildGradientBackground(child: const SizedBox());
          },
        ),
      ),
    );
  }

  Widget _buildGradientBackground({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 25, 66, 100),
            Color.fromARGB(255, 106, 34, 119),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}

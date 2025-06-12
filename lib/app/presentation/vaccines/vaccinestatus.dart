import 'package:fda/app/presentation/vaccines/cubit/vac_state.dart';
import 'package:fda/app/presentation/vaccines/cubit/vaccubit.dart';
import 'package:fda/app/presentation/vaccines/services/vacservices.dart';
import 'package:fda/app/presentation/vaccines/widget/vac_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VaccineStatus extends StatefulWidget {
  final String title;
  final String status;

  const VaccineStatus({required this.title, required this.status, super.key});

  @override
  State<VaccineStatus> createState() => _VaccineStatusState();
}

class _VaccineStatusState extends State<VaccineStatus> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VacCubit(service: VacService())..fetchVacs(widget.status),
      child: Scaffold(
        body: BlocBuilder<VacCubit, VacState>(
          builder: (context, state) {
            if (state is VacLoading) {
              return _buildGradientBackground(
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            } else if (state is VacError) {
              return _buildGradientBackground(
                child: Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else if (state is VacLoaded) {
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
                          PopupMenuButton<SortOrder>(
                            icon: const Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                            color: Colors.white,
                            onSelected: (SortOrder selected) {
                              context.read<VacCubit>().sortReports(selected);
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
                          .map((report) => VacReportCard(report: report))
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

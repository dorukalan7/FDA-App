import 'package:fda/view/foodspage/service/foodsservice.dart';
import 'package:fda/view/foodspage/widget/foods_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/status_cubit.dart';

class FilteredStatusPage extends StatelessWidget {
  final String title;
  final String status;

  const FilteredStatusPage({
    super.key,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StatusCubit(RecallService())..fetchRecallsByStatus(status),
      child: Builder(
        builder: (contextWithProvider) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '$title - $status',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 25, 66, 100),
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  onPressed: () {
                    final parentContext = contextWithProvider;
                    showModalBottomSheet(
                      context: parentContext,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (bottomSheetContext) {
                        return SizedBox(
                          height: 160,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.arrow_upward),
                                title: const Text(
                                  'Tarihe göre artan (eski → yeni)',
                                ),
                                onTap: () {
                                  Navigator.pop(bottomSheetContext);
                                  parentContext
                                      .read<StatusCubit>()
                                      .fetchRecallsByStatusSorted(
                                        status,
                                        ascending: true,
                                      );
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.arrow_downward),
                                title: const Text(
                                  'Tarihe göre azalan (yeni → eski)',
                                ),
                                onTap: () {
                                  Navigator.pop(bottomSheetContext);
                                  parentContext
                                      .read<StatusCubit>()
                                      .fetchRecallsByStatusSorted(
                                        status,
                                        ascending: false,
                                      );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            body: Container(
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
              child: BlocBuilder<StatusCubit, StatusState>(
                builder: (context, state) {
                  if (state is StatusLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  } else if (state is StatusLoaded) {
                    return ListView.builder(
                      itemCount: state.recalls.length,
                      itemBuilder: (context, index) {
                        return RecallCard(recall: state.recalls[index]);
                      },
                    );
                  } else if (state is StatusError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

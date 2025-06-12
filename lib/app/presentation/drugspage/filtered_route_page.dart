import 'package:fda/app/presentation/drugspage/service/drugservice.dart';
import 'package:fda/app/presentation/drugspage/cubit/drug_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fda/app/presentation/drugspage/widget/drug_card.dart';

class FilteredRoutePage extends StatelessWidget {
  final String route;
  final String title;

  const FilteredRoutePage({
    super.key,
    required this.route,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              DrugCubit(drugService: DrugService())..fetchDrugsByRoute(route),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '$route Drugs',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 25, 66, 100),

          iconTheme: const IconThemeData(color: Colors.white),
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
          child: BlocBuilder<DrugCubit, DrugState>(
            builder: (context, state) {
              if (state is DrugLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else if (state is DrugError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else if (state is DrugLoaded) {
                if (state.drugs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No drugs found.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: state.drugs.length,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ), // Üst-alt boşluk
                  itemBuilder: (context, index) {
                    final drug = state.drugs[index];
                    return DrugCard(drug: drug);
                  },
                  separatorBuilder:
                      (context, index) =>
                          const SizedBox(height: 12), // 🔥 Araya boşluk ekler
                );
              }

              return const SizedBox(); // DrugInitial durumu
            },
          ),
        ),
      ),
    );
  }
}

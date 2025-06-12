import 'package:fda/app/presentation/animalveteriny/service/animalservice.dart';
import 'package:fda/app/presentation/animalveteriny/cubit/animal_cubit.dart';
import 'package:fda/app/presentation/animalveteriny/widgets/animal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredSpeciesPage extends StatefulWidget {
  final String species;
  final String title;

  const FilteredSpeciesPage({
    super.key,
    required this.species,
    required this.title,
  });

  @override
  State<FilteredSpeciesPage> createState() => _FilteredSpeciesPageState();
}

class _FilteredSpeciesPageState extends State<FilteredSpeciesPage> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              AnimalCubit(animalService: AnimalService())
                ..fetchAnimalsBySpecies(widget.species),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                '${widget.title} Species',
                style: const TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 25, 66, 100),
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
              child: Column(
                children: [
                  // 🔽 Dropdown filter
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedGender,
                      decoration: InputDecoration(
                        labelText: 'Filter by Gender',
                        labelStyle: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18, // ✅ Yazı büyütüldü
                        ),
                        filled: true,
                        fillColor: Colors.white12,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white30),
                        ),
                      ),
                      dropdownColor: const Color.fromARGB(255, 45, 45, 60),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 30, // ✅ Ok büyütüldü
                      ),
                      style: const TextStyle(color: Colors.white),
                      items: const [
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                        context
                            .read<AnimalCubit>()
                            .fetchAnimalsBySpeciesAndGender(
                              widget.species,
                              value!,
                            );
                      },
                    ),
                  ),

                  // 📋 BlocBuilder for animal list
                  Expanded(
                    child: BlocBuilder<AnimalCubit, AnimalState>(
                      builder: (context, state) {
                        if (state is AnimalLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        } else if (state is AnimalError) {
                          return Center(
                            child: Text(
                              'Error: ${state.message}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (state is AnimalLoaded) {
                          if (state.animals.isEmpty) {
                            return const Center(
                              child: Text(
                                'No animals found.',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: state.animals.length,
                            itemBuilder: (context, index) {
                              final animal = state.animals[index];
                              return AnimalCard(animal: animal);
                            },
                          );
                        }
                        return const SizedBox(); // Initial state
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

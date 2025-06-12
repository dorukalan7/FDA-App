import 'package:fda/app/common/model/news_model.dart';
import 'package:fda/app/presentation/animalveteriny/view/animalstatus.dart';
import 'package:fda/app/common/widgets/pages_box.dart';
import 'package:fda/app/common/widgets/featuredcard.dart';
import 'package:flutter/material.dart';

class Animalveteriny extends StatelessWidget {
  final String title;
  final String imageUrl;

  const Animalveteriny({
    required this.title,
    required this.imageUrl,
    super.key,
  });

  void _navigateToFilteredPage(BuildContext context, String species) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FilteredSpeciesPage(title: species, species: species),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, // <-- Başlığı ortalar
        title: Text(
          title,
          style: const TextStyle(color: Colors.white), // Zaten beyaz
        ),
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
        child: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight + 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FeaturedCard(
                  news: NewsModel(
                    title: title,
                    description: "",
                    imageUrl: imageUrl,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Boxx(
                            label: 'Dog',
                            onTap:
                                () => _navigateToFilteredPage(context, 'Dog'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Boxx(
                            label: 'Cat',
                            onTap:
                                () => _navigateToFilteredPage(context, 'Cat'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Boxx(
                            label: 'Horse',
                            onTap:
                                () => _navigateToFilteredPage(context, 'Horse'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Boxx(
                            label: 'Chicken',
                            onTap:
                                () => _navigateToFilteredPage(context, 'Horse'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

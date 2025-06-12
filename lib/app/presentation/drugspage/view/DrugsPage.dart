import 'package:fda/app/common/model/news_model.dart';
import 'package:fda/app/presentation/drugspage/view/filtered_route_page.dart';
import 'package:fda/app/common/widgets/pages_box.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/featuredcard.dart';

class DrugsPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  const DrugsPage({super.key, required this.title, required this.imageUrl});

  void _navigateToFilteredRoutePage(BuildContext context, String route) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FilteredRoutePage(route: route, title: title),
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
        centerTitle: true,
        title: Text(title, style: const TextStyle(color: Colors.white)),

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
                    description:
                        "Explore drug categories by route of administration.",
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
                        Boxx(
                          label: 'Oral',
                          onTap:
                              () =>
                                  _navigateToFilteredRoutePage(context, 'ORAL'),
                        ),
                        Boxx(
                          label: 'Intravenous',
                          onTap:
                              () => _navigateToFilteredRoutePage(
                                context,
                                'INTRAVENOUS',
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Boxx(
                          label: 'Topical',
                          onTap:
                              () => _navigateToFilteredRoutePage(
                                context,
                                'TOPICAL',
                              ),
                        ),
                        Boxx(
                          label: 'Subcutaneous',
                          onTap:
                              () => _navigateToFilteredRoutePage(
                                context,
                                'SUBCUTANEOUS',
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

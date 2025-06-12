import 'package:fda/app/common/model/news_model.dart';
import 'package:fda/app/presentation/foodspage/view/Filtered_statuspage.dart';
import 'package:fda/app/common/widgets/pages_box.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/featuredcard.dart';

class FoodsPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  const FoodsPage({required this.title, required this.imageUrl, super.key});

  void navigateToFoodsPage(BuildContext context, String status) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FilteredStatusPage(title: title, status: status),
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
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false, // Otomatik geri tuşunu kapatır
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
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
          padding: const EdgeInsets.only(top: kToolbarHeight + 48),
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
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Boxx(
                  label: 'Ongoing',
                  onTap: () => navigateToFoodsPage(context, 'Ongoing'),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Boxx(
                  label: 'Terminated',
                  onTap: () => navigateToFoodsPage(context, 'Terminated'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fda/cubit/favorite_cubit.dart';
import 'package:fda/model/FavoriteModel.dart';
import 'package:fda/model/MenuItem.dart';
import 'package:fda/viewmodel/MenuItems.dart';
import 'package:fda/view/WebViewPage.dart';
import 'package:fda/view/favorite_page.dart';
import 'package:fda/view/homescreen/router/category_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _handleTap(BuildContext context, MenuItem item) {
    Navigator.of(context).pop();

    if (item.title == 'Favorites') {
      // Favoriler sayfasına git
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => FavoritesPage()),
      );
    } else if (item.category != null) {
      navigateToCategoryPage(
        item.category!,
        context,
        item.title,
        'https://example.com/fake-image.jpg',
      );
    } else if (item.url != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => WebViewPage(url: item.url!)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No page assigned for ${item.title}')),
      );
    }
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<MenuItem> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: Colors.white54,
          thickness: 1,
          height: 20,
          indent: 16,
          endIndent: 16,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        ...items.map(
          (item) => ListTile(
            leading:
                item.title == 'Favorites'
                    ? BlocBuilder<FavoritesCubit, List<FavoriteItem>>(
                      builder: (context, favorites) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(item.icon, color: Colors.white, size: 24),
                            if (favorites.isNotEmpty)
                              Positioned(
                                right: -6,
                                top: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${favorites.length}', // Dinamik sayı
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    )
                    : Icon(item.icon, color: Colors.white, size: 24),

            title: Text(
              item.title,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () => _handleTap(context, item),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 25, 66, 100),
              Color.fromARGB(255, 106, 34, 119),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ... DrawerHeader aynı
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to FDA Menu',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: SizedBox(
                      width: 95,
                      height: 95,
                      child: ClipOval(
                        child: Transform.scale(
                          scale: 1.5,
                          child: Image.asset(
                            'assets/images/logo_fda.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildSection(context, 'Home', featuredItems),
            _buildSection(context, 'Products', productItems),
            _buildSection(context, 'Topics', topicItems),
            _buildSection(context, 'Information For', infoItems),
          ],
        ),
      ),
    );
  }
}

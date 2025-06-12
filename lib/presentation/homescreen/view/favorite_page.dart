import 'package:fda/app/common/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesCubit>().state;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Favorites'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.black,
      body:
          favorites.isEmpty
              ? const Center(
                child: Text(
                  'No favorites yet',
                  style: TextStyle(color: Colors.white70),
                ),
              )
              : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return Card(
                    color: Colors.white10,
                    margin: const EdgeInsets.all(12),
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {},

                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'GO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        item.category,
                        style: const TextStyle(color: Colors.white54),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          context.read<FavoritesCubit>().toggleFavorite(item);
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }
}

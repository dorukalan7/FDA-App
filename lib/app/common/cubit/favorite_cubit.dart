import 'package:fda/model/FavoriteModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesCubit extends Cubit<List<FavoriteItem>> {
  FavoritesCubit() : super([]) {
    loadFavorites();
  }

  void toggleFavorite(FavoriteItem item) {
    final current = List<FavoriteItem>.from(state);

    if (isFavorite(item)) {
      current.removeWhere((f) => f.id == item.id);
    } else {
      current.add(item);
    }

    emit(current);
    saveFavorites(current);
  }

  bool isFavorite(FavoriteItem item) {
    return state.any((f) => f.id == item.id);
  }

  Future<void> saveFavorites(List<FavoriteItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        items
            .map(
              (e) => jsonEncode({
                'id': e.id,
                'title': e.title,
                'category': e.category,
                'status': e.status,
              }),
            )
            .toList();

    await prefs.setStringList('favorites', jsonList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('favorites') ?? [];

    final items =
        jsonList.map((e) {
          final map = jsonDecode(e);
          return FavoriteItem(
            id: map['id'],
            title: map['title'],
            category: map['category'],
            status: map['status'],
          );
        }).toList();

    emit(items);
  }
}

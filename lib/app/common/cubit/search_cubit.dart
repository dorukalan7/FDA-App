import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/FavoriteModel.dart';

class SearchState {
  final List<FavoriteItem> results;
  SearchState(this.results);
}

class SearchCubit extends Cubit<SearchState> {
  final List<FavoriteItem> allItems;
  SearchCubit(this.allItems) : super(SearchState(allItems));

  void search(String query) {
    if (query.isEmpty) {
      emit(SearchState(allItems));
      return;
    }

    final lowerQuery = query.toLowerCase();

    final filtered =
        allItems.where((item) {
          final title = item.title.toLowerCase();
          final category = item.category.toLowerCase();
          return title.contains(lowerQuery) || category.contains(lowerQuery);
        }).toList();

    emit(SearchState(filtered));
  }
}

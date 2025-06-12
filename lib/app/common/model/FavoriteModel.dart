class FavoriteItem {
  final String id; // benzersiz ID (örneğin NDC veya başka alan)
  final String title;
  final String category;
  final String? status;
  final dynamic data; // Kart verisinin tamamı (gerekirse)

  FavoriteItem({
    required this.id,
    required this.title,
    required this.category,
    this.status,
    this.data,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

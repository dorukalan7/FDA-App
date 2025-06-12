class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String? url; // Burayı nullable yap

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.url, // opsiyonel
  });
}

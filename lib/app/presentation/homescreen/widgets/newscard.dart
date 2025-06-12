import 'package:fda/app/common/model/news_model.dart';
import 'package:fda/app/presentation/webviewpage/WebViewPage.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (news.url != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => WebViewPage(url: news.url!)),
          );
        }
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                news.imageUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    news.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

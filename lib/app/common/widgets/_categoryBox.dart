import 'package:fda/app/presentation/homescreen/router/category_router.dart';
import 'package:flutter/material.dart';
import 'package:fda/app/common/enum/category_type.dart' as my_cat;

Widget categoryBox(my_cat.Category category, BuildContext context) {
  final text = category.title;
  final imageUrl = category.imageUrl;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.5, vertical: 6),
    child: GestureDetector(
      onTap:
          () => navigateToCategoryPage(
            category,
            context,
            category.title,
            category.imageUrl,
          ),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

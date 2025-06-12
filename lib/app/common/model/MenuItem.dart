import 'package:flutter/material.dart';
import 'package:fda/enum/category_type.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final String? url;
  final Category? category;

  MenuItem({required this.icon, required this.title, this.url, this.category});
}

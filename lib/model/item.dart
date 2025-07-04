import 'package:flutter/material.dart';

class ArticleItem {
  String description;
  int quantity;
  double price;

  ArticleItem({
    required this.description,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;
}

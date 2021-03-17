import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String image;
  final String imagePath;
  final String description;
  final double price;
  final String phoneNumber;
  final bool isFavorite;
  final String userEmail;
  final String userId;
  final String productCategory;

  Product(
      {@required this.id,
      @required this.title,
      @required this.image,
      @required this.description,
      @required this.price,
      @required this.phoneNumber,
      @required this.userEmail,
      @required this.userId,
      @required this.imagePath,
      this.isFavorite = false, //assume false if not selected
      @required this.productCategory,
      });
}

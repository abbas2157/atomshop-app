import 'dart:ui';

import 'package:flutter/material.dart';

class LatestProductsModel {
  final String name;
  final String price;
  final String image;
  final List<Color> colors;
  final Color backgroundColor;
  final String discountedPrice;

  LatestProductsModel({
    required this.name,
    required this.price,
    required this.image,
    required this.colors,
    required dynamic backgroundColor, // Accepts both Color & Hex String
    required this.discountedPrice,
  }) : backgroundColor = backgroundColor is String
          ? _hexToColor(backgroundColor) // Convert hex string to Color
          : backgroundColor as Color; // If already a Color, use it

  /// Convert Hex String to Flutter Color
  static Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('0xFF$hex')); // Add FF for full opacity
    } else if (hex.length == 8) {
      return Color(int.parse('0x$hex')); // Already has alpha value
    }
    return Colors.grey; // Default fallback
  }
}


final List<LatestProductsModel> latestProducts = [
  LatestProductsModel(
    name: 'Jordan',
    price: '25.00',
    image: 'assets/images/shoes.png',
    colors: [Colors.red, Colors.blue, Colors.green],
    backgroundColor: '#FCE4EC', // Light Pink
    discountedPrice: '20.00',
  ),
  LatestProductsModel(                          
    name: 'AJK Headphones',
    price: '30.00',
    image: 'assets/images/headphones.jpg',
    colors: [Colors.yellow, Colors.purple, Colors.pink],
    backgroundColor: '#FFF9C4', // Light Yellow
    discountedPrice: '25.00',
  ),
  LatestProductsModel(
    name: 'Rayban Glasses',
    price: '30.00',
    image: 'assets/images/glasses.png',
    colors: [Colors.yellow, Colors.purple, Colors.pink],
    backgroundColor: '#E3F2FD', // Light Blue
    discountedPrice: '25.00',
  ),
  LatestProductsModel(
    name: 'Nike Shoes',
    price: '50.00',
    image: 'assets/images/shoes.png',
    colors: [Colors.red, Colors.blue, Colors.green],
    backgroundColor: '#E8F5E9', // Light Green
    discountedPrice: '45.00',
  ),
  LatestProductsModel(
    name: 'Sony Headphones',
    price: '60.00',
    image: 'assets/images/headphones.jpg',
    colors: [Colors.yellow, Colors.purple, Colors.pink],
    backgroundColor: '#FFECB3', // Light Orange
    discountedPrice: '55.00',
  ),
  LatestProductsModel(
    name: 'Aviator Sunglasses',
    price: '40.00',
    image: 'assets/images/glasses.png',
    colors: [Colors.yellow, Colors.purple, Colors.pink],
    backgroundColor: '#F3E5F5', // Light Purple
    discountedPrice: '35.00',
  ),
];

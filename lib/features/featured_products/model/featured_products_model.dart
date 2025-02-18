import 'package:flutter/material.dart';

class LatestProductsModel {
  final int id;
  final String name;
  final int price;
  final String formattedPrice;
  final String image;
  final String category;
  final String brand;
  final Color backgroundColor;

  LatestProductsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.formattedPrice,
    required this.image,
    required this.category,
    required this.brand,
    required dynamic backgroundColor, // Hex String or Color
  }) : backgroundColor = backgroundColor is String
          ? _hexToColor(backgroundColor) // Convert Hex String to Color
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

  /// Factory constructor to create from JSON
  factory LatestProductsModel.fromJson(Map<String, dynamic> json) {
    return LatestProductsModel(
      id: json['id'],
      name: json['title'] ?? 'Unknown Product',
      price: json['price'],
      formattedPrice: json['formatted_price'],
      image: json['product_picture'],
      category: json['category']['title'] ?? 'Unknown Category',
      brand: json['brand']['title'] ?? 'Unknown Brand',
      backgroundColor: "#F4F5FD", // Static light background color
    );
  }
}

import 'package:flutter/material.dart';

class ProductsCoffee extends ChangeNotifier {
  final String id;
  final double price;
  final String product;

  ProductsCoffee({
    required this.id,
    required this.price,
    required this.product,
  });

  factory ProductsCoffee.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return ProductsCoffee(
      id: json['id'].toString(),
      price: attributes['price'].toDouble(),
      product: attributes['product'],
    );
  }
}

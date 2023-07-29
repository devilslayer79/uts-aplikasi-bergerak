import 'package:flutter/material.dart';

class ProductsCoffee extends ChangeNotifier {
  final String id;
  final double price;
  final String product;
  final PictureCoffee pictureCoffee; 

  ProductsCoffee({
    required this.id,
    required this.price,
    required this.product,
    required this.pictureCoffee, 
  });

  factory ProductsCoffee.fromJson(Map<String, dynamic> json, String baseUrl) {
    final attributes = json['attributes'];
    return ProductsCoffee(
      id: json['id'].toString(),
      price: attributes['price'].toDouble(),
      product: attributes['product'],
      pictureCoffee: PictureCoffee.fromJson(attributes['pictureCoffee'], baseUrl),
    );
  }
}


class PictureCoffee {
  final String name;
  final String url;
  final String baseUrl; 
  final String fullUrl; 

  PictureCoffee({
    required this.name,
    required this.url,
    required this.baseUrl,
    required this.fullUrl,
  });

  factory PictureCoffee.fromJson(Map<String, dynamic> json, String baseUrl) {
    final data = json['data']['attributes'];
    final url = data['url'];
    return PictureCoffee(
      name: data['name'],
      url: url,
      baseUrl: baseUrl,
      fullUrl: baseUrl + url, 
    );
  }
}


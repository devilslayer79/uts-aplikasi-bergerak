import 'package:coffe_shop/models/product_coffee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProvider with ChangeNotifier {
  // get coffee list
  List<ProductsCoffee> _productsCoffee = [];
  List<ProductsCoffee> get productsCoffee => _productsCoffee;

  // user cart
  final List<ProductsCoffee> _productCart = [];
  // get user cart
  List<ProductsCoffee> get productCart => _productCart;

  Future<void> fetchproductsCoffeeFromStrapi() async {
    final apiUrl = 'http://localhost:1337/api/coffees';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final data = responseData['data'] as List<dynamic>;
      _productsCoffee =
          data.map((item) => ProductsCoffee.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load products from Strapi');
    }
  }

// add item to cart
  void addItemToCart(ProductsCoffee coffee) {
    _productCart.add(coffee);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(ProductsCoffee coffee) {
    _productCart.remove(coffee);
    notifyListeners();
  }

  // remove item from cart
  void clearCart() {
    _productCart.clear();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import 'coffee.dart';

class CoffeeShop extends ChangeNotifier {
  final List<Coffee> _shop = [
    Coffee(
      name: 'Black Coffee',
      price: '15k',
      imagePath: 'assets/images/Black Coffee.png',
    ),
    Coffee(
      name: 'Cold Coffee',
      price: '12k',
      imagePath: 'assets/images/Cold Coffee.png',
    ),
    Coffee(
      name: 'Espresso',
      price: '10k',
      imagePath: 'assets/images/Espresso.png',
    ),
    Coffee(
      name: 'Latte',
      price: '13k',
      imagePath: 'assets/images/Latte.png',
    ),
  ];

  // user cart
  final List<Coffee> _userCart = [];

  // get coffee list
  List<Coffee> get coffeeShop => _shop;

  // get user cart
  List<Coffee> get userCart => _userCart;

  // add item to cart
  void addItemToCart(Coffee coffee) {
    _userCart.add(coffee);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(Coffee coffee) {
    _userCart.remove(coffee);
    notifyListeners();
  }
}

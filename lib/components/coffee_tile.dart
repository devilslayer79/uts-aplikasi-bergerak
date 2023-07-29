import 'package:coffe_shop/const.dart';
import 'package:coffe_shop/models/product_coffee.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoffeeTile extends StatelessWidget {
  CoffeeTile(
      {super.key,
      required this.coffee,
      required this.onPressed,
      required this.icon});
  final Widget icon;
  final ProductsCoffee coffee;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: ListTile(
        title: Text(
          coffee.product,
          style: TextStyle(color: textColor),
        ),
        subtitle: Text('Rp ${coffee.price}'),
        leading: coffee.pictureCoffee.url.isNotEmpty
            ? Image.network(coffee.pictureCoffee.fullUrl)
            : const SizedBox.shrink(),
        trailing: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}

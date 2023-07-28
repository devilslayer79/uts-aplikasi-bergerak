import 'package:coffe_shop/components/coffee_tile.dart';
import 'package:coffe_shop/const.dart';
import 'package:coffe_shop/models/product_coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.fetchproductsCoffeeFromStrapi();
  }

  // add coffee to cart
  void addToCart(ProductsCoffee coffee) {
    // add to cart
    Provider.of<DataProvider>(context, listen: false).addItemToCart(coffee);

    // let user know it add been successfully added
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const StadiumBorder(),
        title: Text(
          "Successfully added to cart",
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        if (dataProvider.productsCoffee.isEmpty) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Text(
                    "Choose your favorite coffee",
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Show CircularProgressIndicator when productsCoffee is empty
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Text(
                    "Choose your favorite coffee",
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // list of coffee to buy
                  Expanded(
                    child: ListView.builder(
                      itemCount: dataProvider.productsCoffee.length,
                      itemBuilder: (context, index) {
                        // get individual coffee
                        ProductsCoffee eachCoffee =
                            dataProvider.productsCoffee[index];

                        // return the tile for this coffee
                        return CoffeeTile(
                          coffee: eachCoffee,
                          onPressed: () {
                            addToCart(eachCoffee);
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: kPrimaryColor,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

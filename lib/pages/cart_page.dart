import 'package:coffe_shop/components/coffee_tile.dart';
import 'package:coffe_shop/const.dart';
import 'package:coffe_shop/models/product_coffee.dart';
import 'package:coffe_shop/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // remove item from cart
  void removeFromCart(ProductsCoffee coffee) {
    Provider.of<DataProvider>(context, listen: false)
        .removeItemFromCart(coffee);

    // let user know it add been successfully DELETE
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const StadiumBorder(),
        title: Text(
          "Successfully deleted from cart",
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

// Method to display the payment confirmation dialog
  void openAlertDialog(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Confirmation'),
          content: Text(
            'Total Price: Rp ${calculateTotalPrice(dataProvider.productCart)}',
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: textColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Confirm Payment',
                style: TextStyle(color: textColor),
              ),
              onPressed: () {
                Provider.of<DataProvider>(context, listen: false).clearCart();
                Navigator.of(context).pop(); // Close the dialog

                // Tampilkan Snackbar untuk notifikasi "Payment Confirmed" di bagian atas
                final snackBar = SnackBar(
                  content: const Text('Payment Confirmed'),
                  margin: const EdgeInsets.only(bottom: 100, left: 50, right: 50),
                  backgroundColor: snackbarColor,
                  behavior: SnackBarBehavior.floating,
                  elevation: 20.0,
                  duration: const Duration(milliseconds: 2000),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }

  // Method untuk menghitung total harga dari productCart
  double calculateTotalPrice(List<ProductsCoffee> productCart) {
    double totalPrice = 0;
    for (var product in productCart) {
      totalPrice += product.price;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Text(
                "Your Cart",
                style: TextStyle(fontSize: 20, color: textColor),
              ),

              const SizedBox(
                height: 25,
              ),

              // list of cart items
              Expanded(
                child: ListView.builder(
                  itemCount: dataProvider.productCart.length,
                  itemBuilder: (context, index) {
                    // get individual cart items
                    ProductsCoffee eachCoffee = dataProvider.productCart[index];

                    // return coffee tile
                    return CoffeeTile(
                      coffee: eachCoffee,
                      onPressed: () {
                        removeFromCart(eachCoffee);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: kPrimaryColor,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              // pay button
              GestureDetector(
                onTap: () {
                  openAlertDialog(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.brown[300],
                  ),
                  child: const Center(
                    child: Text(
                      "Pay Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

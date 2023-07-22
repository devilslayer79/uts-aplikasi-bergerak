import 'package:coffe_shop/Login/login_screen.dart';
import 'package:coffe_shop/components/bottom_navbar.dart';
import 'package:coffe_shop/const.dart';
import 'package:coffe_shop/pages/shop_page.dart';
import 'package:flutter/material.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // navigate bottom bar
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // pages
  final List<Widget> _pages = [
    
    // shop page
    const ShopPage(),

    // cart page
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: backgroundColor),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/header coffee.png",
                    scale: 3.9,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: kPrimaryColor,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: textColor),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: kPrimaryColor,
              ),
              title: Text("Logout", style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: BottomNavBar(
        onTabChange: (index) => navigateBottomBar(
          index,
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

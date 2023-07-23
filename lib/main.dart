// import 'package:coffe_shop/models/coffee_shop.dart';
// import 'package:coffe_shop/pages/splash_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'const.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => CoffeeShop(),
//       builder: (context, child) => MaterialApp(
//         title: 'Coffee Shop',
//         theme: ThemeData(
//           scaffoldBackgroundColor: Colors.white,
//           elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ElevatedButton.styleFrom(
//               elevation: 0,
//               backgroundColor: kPrimaryColor,
//               shape: const StadiumBorder(),
//               maximumSize: const Size(double.infinity, 56),
//               minimumSize: const Size(double.infinity, 56),
//             ),
//           ),
//           inputDecorationTheme: InputDecorationTheme(
//             filled: true,
//             fillColor: Colors.grey[200],
//             prefixIconColor: kPrimaryColor,
//             suffixIconColor: kPrimaryColor,
//             contentPadding: const EdgeInsets.symmetric(
//                 horizontal: defaultPadding, vertical: defaultPadding),
//             border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(30)),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//         debugShowCheckedModeBanner: false,
//         home: const Splash(),
//       ),
//     );
//   }
// }

import 'package:coffe_shop/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: 'My App',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.fetchproductsCoffeeFromStrapi();
  }

  @override
  Widget build(BuildContext context) {
    // final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Consumer<DataProvider>(
          builder: (context, dataProvider, child) {
            if (dataProvider.productsCoffee.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: dataProvider.productsCoffee.length,
                itemBuilder: (context, index) {
                  final productCoffee = dataProvider.productsCoffee[index];
                  return ListTile(
                    title: Text(productCoffee.product),
                    // subtitle: Text(productCoffee.description),
                    trailing: Text(productCoffee.price.toStringAsFixed(0)),
                  );
                },
              );
            }
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     dataProvider.fetchproductsCoffeeFromStrapi();
      //   },
      //   child: Icon(Icons.refresh),
      // ),
    );
  }
}

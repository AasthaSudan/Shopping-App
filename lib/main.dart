import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import 'providers/cart_provider.dart';
import 'providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(
        create: (ctx) => Products(),
        ),
      ChangeNotifierProvider(
        create: (ctx) => Cart(),
      ),
    ],
        child: MaterialApp(
           title: 'My Shop',
           theme: ThemeData(
             primarySwatch: Colors.blue,
          ),
        home: ProductsOverviewScreen(),
           routes: {
             ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
             CartScreen.routeName: (ctx) => CartScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
     );
  }
}

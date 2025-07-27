import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import 'providers/cart_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => Products(),
        child: MaterialApp(
           title: 'My Shop',
           theme: ThemeData(
             primarySwatch: Colors.blue,
          ),
        home: ProductsOverviewScreen(),
           routes: {
             ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
     );
  }
}

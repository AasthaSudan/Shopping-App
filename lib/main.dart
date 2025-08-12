import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/cart_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';  // Assuming you have a Products provider
import './providers/auth_provider.dart';  // New import for AuthProvider
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';  // AuthScreen to handle login/signup

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(), // Providing AuthProvider for authentication
        ),
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          splashFactory: InkRipple.splashFactory,
        ),
        home: Consumer<AuthProvider>(
          builder: (ctx, auth, _) =>
          auth.isAuth ? ProductsOverviewScreen() : AuthScreen(), // Conditionally show AuthScreen or ProductsOverviewScreen
        ),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(), // Add AuthScreen route
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

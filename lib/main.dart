import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:untitled6/providers/cart_provider.dart';

import './providers/auth_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // ✅ Ensure Firebase is initialized before building the app
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Firebase init failed: ${snapshot.error}"),
              ),
            ),
          );
        }

        print('✅ Firebase initialized successfully');

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => Products()),
            ChangeNotifierProvider(create: (_) => Cart()),
            ChangeNotifierProvider(create: (_) => Orders()),
          ],
          child: Consumer<AuthProvider>(
            builder: (ctx, auth, _) => MaterialApp(
              title: 'My Shop',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                splashFactory: InkRipple.splashFactory,
              ),
              home: StreamBuilder<User?>(
                stream: auth.authStateChanges, // ✅ No "?"
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (userSnapshot.hasData) {
                    return ProductsOverviewScreen(); // ✅ logged in
                  }
                  return AuthScreen(); // ❌ not logged in
                },
              ),
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
                AuthScreen.routeName: (ctx) => AuthScreen(),
              },
              debugShowCheckedModeBanner: false,
            ),
          ),
        );
      },
    );
  }
}

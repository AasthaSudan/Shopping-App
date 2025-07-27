import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  final List<Product> cartItems;

  CartScreen(this.cartItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            leading: Image.network(
              cartItems[index].imageUrl,
              fit: BoxFit.cover,
              width: 50,
            ),
            title: Text(cartItems[index].title),
            subtitle: Text('\$${cartItems[index].price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}

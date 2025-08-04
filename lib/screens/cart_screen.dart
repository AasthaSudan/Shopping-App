import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_items.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
                padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 Text('Total',
                  style: TextStyle(
                  fontSize: 20,
                  ),
                ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4), // Reduce padding for smaller size
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 20),
                  // Padding(padding: EdgeInsets.only(left: 20.0),)
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount
                      );
                      cart.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                    child: Text('ORDER NOW'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => CartItems(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


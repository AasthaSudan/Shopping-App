import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    print('product rebuilds');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
         backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
             icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border, // Change icon based on favorite status
              color: product.isFavorite ? Colors.red : Colors.white,
           ),
          onPressed: () {
               product.toggleFavorite();
          }, // Toggle favorite state
        ),
            child: Text('Never changes!'),
          ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {}, // Add product to cart
        ),
      ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
                arguments: product.id,
            );
          },
          child: Image.network(
             product.imageUrl,
             fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

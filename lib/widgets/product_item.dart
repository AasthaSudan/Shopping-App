import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(
      this.id,
      this.title,
      this.imageUrl,
      );

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _isFavorite = false; // State for favorite button

  // Handle favorite button click
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  // Handle adding to cart
  void _addToCart() {
    print('${widget.title} added to cart!');
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border, // Change icon based on favorite status
            color: _isFavorite ? Colors.red : Colors.white,
          ),
          onPressed: _toggleFavorite, // Toggle favorite state
        ),
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: _addToCart, // Add product to cart
        ),
      ),
    );
  }
}

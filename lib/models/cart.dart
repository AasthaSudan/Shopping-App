import 'product.dart';

class Cart {
  final List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  void addProduct(Product product) {
    _items.add(product);
  }

  void removeProduct(Product product) {
    _items.remove(product);
  }

  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      total += item.price;
    }
    return total;
  }
}

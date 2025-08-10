import 'package:flutter/material.dart';
import './product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Cotton T-shirt',
      description: 'Soft and breathable cotton T-shirt available in multiple colors and sizes.',
      price: 14.99,
      imageUrl: 'https://contents.mediadecathlon.com/p2450382/c690e7784cbd506eda9ff50499f419bc/p2450382.jpg?format=auto&quality=70&f=2520x0',
    ),
    Product(
      id: 'p2',
      title: 'Jeans',
      description: 'Comfortable denim jeans with a slim fit design.',
      price: 39.99,
      imageUrl: 'https://offduty.in/cdn/shop/products/f656d2d7-0bfd-4cf7-b81a-62bc7e8377a1_540x.jpg?v=1676893043',
    ),
    Product(
      id: 'p3',
      title: 'Hydrating Skincare Serum',
      description: 'Hydrating serum with vitamin C, for a brighter and more youthful complexion.',
      price: 29.99,
      imageUrl: 'https://www.clinikally.com/cdn/shop/files/DERMEDICHYDRAINHYDRATINGserumFORFACE_NECKANDDECOLLETAGE_30ml-2.jpg?v=1724998304',
    ),
    Product(
      id: 'p4',
      title: 'Sunscreen Lotion',
      description: 'SPF 50 sunscreen lotion for all-day protection against UV rays.',
      price: 19.99,
      imageUrl: 'https://brintoncare.com/wp-content/uploads/2024/11/uv-doux-dtan.webp',
    ),
    Product(
      id: 'p5',
      title: 'Yoga Mat',
      description: 'Non-slip yoga mat made of eco-friendly material for a comfortable practice.',
      price: 24.99,
      imageUrl: 'https://sppartos.com/cdn/shop/files/31VX-aIlgWL.jpg?v=1702469142',
    ),
    Product(
      id: 'p6',
      title: 'Smartphone Stand',
      description: 'Adjustable phone stand for hands-free viewing and better comfort.',
      price: 14.99,
      imageUrl: 'https://lamicallshop.com/cdn/shop/files/A-1.jpg?v=1692867271',
    ),
    Product(
      id: 'p7',
      title: 'Travel Pillow',
      description: 'Memory foam travel pillow with adjustable strap for extra comfort.',
      price: 18.99,
      imageUrl: 'https://contents.mediadecathlon.com/p2581266/4186617fde9577befd65306c58753c8a/p2581266.jpg',
    ),
    Product(
      id: 'p8',
      title: 'Bluetooth Speaker',
      description: 'Portable Bluetooth speaker with 360-degree sound and waterproof design.',
      price: 79.99,
      imageUrl: 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1725555398-71SkRGwcKL.jpg?crop=1xw:1.00xh;center,top&resize=980:*',
    ),
    Product(
      id: 'p9',
      title: 'Cotton Socks Pack',
      description: 'Pack of 3 pairs of soft, breathable cotton socks.',
      price: 9.99,
      imageUrl: 'https://www.cotstyle.com/cdn/shop/files/Men_s_Socks_370734_1.webp?v=1692430366',
    ),
    Product(
      id: 'p10',
      title: 'Electric Toothbrush',
      description: 'Rechargeable electric toothbrush with two cleaning modes and a built-in timer.',
      price: 49.99,
      imageUrl: 'https://images.ctfassets.net/iy5ifr0uwt25/5uPMEwX5qDgKstru1bErDF/19aa119c5d00e51d3d36f1753b1514e9/file.png?fm=webp&q=85',
    ),
  ];

  var _showFavoritesOnly = false;

  List<Product> get items {
    // if(_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product? findById(String id) {
    try {
      return _items.firstWhere((prod) => prod.id == id);
    } catch (_) {
      return null;
    }
  }


  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  //
  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }
  
  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if(prodIndex>=0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('Product not found');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
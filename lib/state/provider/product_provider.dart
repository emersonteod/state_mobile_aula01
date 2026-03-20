import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  bool favorite;

  Product({
    required this.name,
    required this.price,
    this.favorite = false,
  });
}

class ProductProvider extends ChangeNotifier {
  final List<Product> _allProducts = [
    Product(name: 'Notebook', price: 3500),
    Product(name: 'Mouse', price: 120),
    Product(name: 'Teclado', price: 250),
    Product(name: 'Monitor', price: 900),
    Product(name: 'Cadeira', price: 780),
    Product(name: 'Webcam', price: 220),
  ];

  bool _showFavoritesOnly = false;

  List<Product> get products {
    if (_showFavoritesOnly) {
      return _allProducts.where((product) => product.favorite).toList();
    }
    return List<Product>.from(_allProducts);
  }

  int get favoritesCount => _allProducts.where((product) => product.favorite).length;

  bool get showFavoritesOnly => _showFavoritesOnly;

  void toggleFavorite(Product product) {
    product.favorite = !product.favorite;
    notifyListeners();
  }

  void setShowFavoritesOnly(bool value) {
    _showFavoritesOnly = value;
    notifyListeners();
  }

  void resetFavoritesFilter() {
    _showFavoritesOnly = false;
    notifyListeners();
  }
}

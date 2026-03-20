import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String description;
  final String image;
  bool favorite;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    this.favorite = false,
  });
}

class FakeApi {
  static Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Product(
        name: 'Notebook',
        price: 3500,
        description: 'Excelente notebook para produtividade e jogos.',
        image: 'https://placeimg.com/640/480/tech',
      ),
      Product(
        name: 'Mouse',
        price: 120,
        description: 'Mouse ergonômico com sensor de alta precisão.',
        image: 'https://placeimg.com/640/480/tech',
      ),
      Product(
        name: 'Teclado',
        price: 250,
        description: 'Teclado mecânico com iluminação RGB.',
        image: 'https://placeimg.com/640/480/tech',
      ),
      Product(
        name: 'Monitor',
        price: 900,
        description: 'Monitor 27" Full HD com taxa de atualização de 144Hz.',
        image: 'https://placeimg.com/640/480/tech',
      ),
      Product(
        name: 'Cadeira',
        price: 780,
        description: 'Cadeira gamer com apoio lombar ajustável.',
        image: 'https://placeimg.com/640/480/tech',
      ),
      Product(
        name: 'Webcam',
        price: 220,
        description: 'Webcam 1080p com microfone embutido.',
        image: 'https://placeimg.com/640/480/tech',
      ),
    ];
  }
}

class ProductProvider extends ChangeNotifier {
  final List<Product> _allProducts = [];

  bool _showFavoritesOnly = false;
  bool isLoading = false;
  String? error;

  List<Product> get products {
    if (_showFavoritesOnly) {
      return _allProducts.where((product) => product.favorite).toList();
    }
    return List<Product>.from(_allProducts);
  }

  int get favoritesCount => _allProducts.where((product) => product.favorite).length;

  bool get showFavoritesOnly => _showFavoritesOnly;

  Future<void> loadProducts() async {
    if (isLoading) return;
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final fetched = await FakeApi.fetchProducts();
      _allProducts.clear();
      _allProducts.addAll(fetched);
    } catch (e) {
      error = 'Falha ao carregar produtos';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

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


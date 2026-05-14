import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service;
  final List<Product> _allProducts = [];

  bool _showFavoritesOnly = false;
  bool isLoading = false;
  String? error;

  ProductProvider([ProductService? service]) : _service = service ?? ProductService();

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
      final fetched = await _service.fetchProducts();
      _allProducts
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      error = 'Falha ao carregar produtos';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final created = await _service.addProduct(product);
      _allProducts.add(created);
    } catch (e) {
      error = 'Falha ao cadastrar produto';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    if (product.id == null) {
      error = 'Produto inválido para atualização';
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final updated = await _service.updateProduct(product);
      final index = _allProducts.indexWhere((item) => item.id == updated.id);
      if (index >= 0) {
        _allProducts[index] = updated;
      }
    } catch (e) {
      error = 'Falha ao atualizar produto';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _service.deleteProduct(id);
      _allProducts.removeWhere((product) => product.id == id);
    } catch (e) {
      error = 'Falha ao excluir produto';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(String id) {
    final index = _allProducts.indexWhere((product) => product.id == id);
    if (index < 0) return;

    _allProducts[index].favorite = !_allProducts[index].favorite;
    notifyListeners();
  }

  void clear() {
    _allProducts.clear();
    _showFavoritesOnly = false;
    error = null;
    isLoading = false;
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


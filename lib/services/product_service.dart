import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  static const _baseUrl = 'dummyjson.com';
  final http.Client _client;

  ProductService([http.Client? client]) : _client = client ?? http.Client();

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.https(_baseUrl, '/products', {'limit': '20'});
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Falha ao buscar produtos: ${response.statusCode}');
    }

    final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
    final products = jsonBody['products'] as List<dynamic>;
    return products
        .cast<Map<String, dynamic>>()
        .map(Product.fromJson)
        .toList();
  }

  Future<Product> addProduct(Product product) async {
    final uri = Uri.https(_baseUrl, '/products/add');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Falha ao cadastrar produto: ${response.statusCode}');
    }

    return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<Product> updateProduct(Product product) async {
    if (product.id == null) {
      throw Exception('Produto sem id não pode ser atualizado');
    }

    final uri = Uri.https(_baseUrl, '/products/${product.id}');
    final response = await _client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar produto: ${response.statusCode}');
    }

    return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<void> deleteProduct(String id) async {
    final uri = Uri.https(_baseUrl, '/products/$id');
    final response = await _client.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir produto: ${response.statusCode}');
    }
  }

  Future<Product> fetchProductById(String id) async {
    final uri = Uri.https(_baseUrl, '/products/$id');
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar detalhes do produto: ${response.statusCode}');
    }

    return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}

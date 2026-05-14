import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final service = ProductService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
      ),
      body: FutureBuilder<Product>(
        future: service.fetchProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final product = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    height: 240,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(
                      height: 240,
                      child: Center(child: Icon(Icons.broken_image, size: 72)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text('R\$ ${product.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                Text(product.description),
              ],
            ),
          );
        },
      ),
    );
  }
}

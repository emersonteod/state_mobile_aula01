import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../state/provider/product_provider.dart';
import 'product_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final updatedProduct = provider.products.firstWhere(
      (p) => p.id == product.id,
      orElse: () => product,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductFormScreen(product: updatedProduct),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              if (updatedProduct.id != null) {
                await provider.deleteProduct(updatedProduct.id!);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                updatedProduct.imageUrl,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 240,
                  child: Center(child: Icon(Icons.broken_image, size: 72)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(updatedProduct.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('R\$ ${updatedProduct.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Text(updatedProduct.description),
            const Spacer(),
            ElevatedButton.icon(
              icon: Icon(updatedProduct.favorite ? Icons.star : Icons.star_border),
              label: Text(updatedProduct.favorite ? 'Remover de favoritos' : 'Marcar como favorito'),
              onPressed: () {
                provider.toggleFavorite(updatedProduct.id!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
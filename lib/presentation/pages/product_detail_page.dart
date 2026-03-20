import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/provider/product_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.image,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 180),
              ),
            ),
            const SizedBox(height: 16),
            Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('R\$ ${product.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Text(product.description),
            const Spacer(),
            ElevatedButton.icon(
              icon: Icon(product.favorite ? Icons.star : Icons.star_border),
              label: Text(product.favorite ? 'Remover dos favoritos' : 'Marcar como favorito'),
              onPressed: () {
                final provider = context.read<ProductProvider>();
                provider.toggleFavorite(product);
              },
            ),
          ],
        ),
      ),
    );
  }
}

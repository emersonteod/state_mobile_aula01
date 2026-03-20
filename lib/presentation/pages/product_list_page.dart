import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/provider/product_provider.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<ProductProvider>();
    provider.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    if (productProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Produtos')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (productProvider.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Produtos')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Erro: ${productProvider.error}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: productProvider.loadProducts,
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    final products = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: SizedBox(
              width: 56,
              height: 56,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
              ),
            ),
            title: Text(product.name),
            subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(
                product.favorite ? Icons.star : Icons.star_border,
                color: product.favorite ? Colors.amber : null,
              ),
              onPressed: () => productProvider.toggleFavorite(product),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

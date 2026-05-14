import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
<<<<<<< HEAD
import '../state/provider/auth_provider.dart';
=======
>>>>>>> main
import '../state/provider/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';
import 'product_form_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final auth = context.watch<AuthProvider>();
=======
>>>>>>> main
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('Produtos • ${auth.user?.displayName ?? ''}'),
=======
        title: const Text('Produtos'),
>>>>>>> main
        actions: [
          IconButton(
            icon: Icon(provider.showFavoritesOnly ? Icons.filter_alt : Icons.filter_alt_outlined),
            tooltip: provider.showFavoritesOnly ? 'Mostrar todos' : 'Mostrar apenas favoritos',
            onPressed: () => provider.setShowFavoritesOnly(!provider.showFavoritesOnly),
          ),
<<<<<<< HEAD
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.read<ProductProvider>().clear();
            },
          ),
=======
>>>>>>> main
        ],
      ),
      body: Builder(
        builder: (context) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Erro: ${provider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: provider.loadProducts,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          final products = provider.products;
          if (products.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          }

          return RefreshIndicator(
            onRefresh: provider.loadProducts,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
<<<<<<< HEAD
                        builder: (_) => ProductDetailScreen(productId: product.id!),
=======
                        builder: (_) => ProductDetailScreen(product: product),
>>>>>>> main
                      ),
                    );
                  },
                  onEdit: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductFormScreen(product: product),
                      ),
                    );
                  },
                  onDelete: () async {
                    await provider.deleteProduct(product.id!);
                  },
                  onToggleFavorite: () => provider.toggleFavorite(product.id!),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

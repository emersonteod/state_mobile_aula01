
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/provider/product_provider.dart';

class ProviderPage extends StatelessWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final products = provider.products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos (${provider.favoritesCount} favoritos)'),
        actions: [
          IconButton(
            icon: Icon(
              provider.showFavoritesOnly ? Icons.filter_alt : Icons.filter_alt_outlined,
            ),
            tooltip: provider.showFavoritesOnly ? 'Mostrar todos' : 'Mostrar apenas favoritos',
            onPressed: () => provider.setShowFavoritesOnly(!provider.showFavoritesOnly),
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(child: Text('Nenhum produto disponível nessa seleção.'))
          : ListView.separated(
              itemCount: products.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: product.favorite ? Colors.amber.shade700 : Colors.grey.shade300,
                    child: Text(product.name[0]),
                  ),
                  title: Text(product.name),
                  subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(
                      product.favorite ? Icons.star : Icons.star_border,
                      color: product.favorite ? Colors.amber : null,
                    ),
                    onPressed: () => provider.toggleFavorite(product),
                  ),
                  tileColor: product.favorite ? Colors.amber.shade50 : null,
                );
              },
            ),
      floatingActionButton: provider.showFavoritesOnly
          ? FloatingActionButton.extended(
              onPressed: provider.resetFavoritesFilter,
              icon: const Icon(Icons.clear),
              label: const Text('Limpar filtro'),
            )
          : null,
    );
  }
}


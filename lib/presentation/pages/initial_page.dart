import 'package:flutter/material.dart';
import 'product_list_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Inicial')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.list),
          label: const Text('Ir para Produtos'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductListPage()),
            );
          },
        ),
      ),
    );
  }
}

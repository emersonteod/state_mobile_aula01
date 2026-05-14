import 'package:flutter/material.dart';

import '../../screens/product_list_screen.dart';

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
              MaterialPageRoute(builder: (context) => const ProductListScreen()),
            );
          },
        ),
      ),
    );
  }
}

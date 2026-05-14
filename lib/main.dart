import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import 'presentation/pages/initial_page.dart';
import 'services/product_service.dart';
import 'state/provider/product_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: provider.ChangeNotifierProvider(
        create: (_) => ProductProvider(ProductService()),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Patterns',
      home: const InitialPage(),
    );
  }
}
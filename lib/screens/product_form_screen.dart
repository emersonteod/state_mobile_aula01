import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../state/provider/product_provider.dart';
import '../widgets/product_form_field.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imageController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.product?.description ?? '');
    _imageController = TextEditingController(text: widget.product?.imageUrl ?? 'https://placeimg.com/640/480/tech');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProductProvider>();
    final product = Product(
      id: widget.product?.id,
      name: _nameController.text.trim(),
      price: double.tryParse(_priceController.text.replaceAll(',', '.')) ?? 0,
      description: _descriptionController.text.trim(),
      imageUrl: _imageController.text.trim(),
      favorite: widget.product?.favorite ?? false,
    );

    setState(() => _isSaving = true);
    try {
      if (widget.product == null) {
        await provider.addProduct(product);
      } else {
        await provider.updateProduct(product);
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar produto: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Produto' : 'Cadastrar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ProductFormField(
                label: 'Nome',
                controller: _nameController,
                validator: (value) => value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              ProductFormField(
                label: 'Preço',
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o preço';
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ProductFormField(
                label: 'Descrição',
                controller: _descriptionController,
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Informe a descrição' : null,
              ),
              const SizedBox(height: 12),
              ProductFormField(
                label: 'URL da imagem',
                controller: _imageController,
                keyboardType: TextInputType.url,
                validator: (value) => value == null || value.isEmpty ? 'Informe a URL da imagem' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveForm,
                  child: _isSaving ? const CircularProgressIndicator(color: Colors.white) : const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

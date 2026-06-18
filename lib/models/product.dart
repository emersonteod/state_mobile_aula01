class Product {
  final String? id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  bool favorite;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.favorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final imagesList = json['images'] as List?;
    final image = imagesList != null && imagesList.isNotEmpty
        ? imagesList[0] as String? ?? ''
        : json['thumbnail'] as String? ?? json['image'] as String? ?? '';

    return Product(
      id: json['id']?.toString(),
      name: json['title'] as String? ?? json['name'] as String? ?? '',
      price: _parsePrice(json['price']),
      description: json['description'] as String? ?? '',
      imageUrl: image,
    );
  }

  static double _parsePrice(dynamic price) {
    if (price == null) return 0.0;
    if (price is int) return price.toDouble();
    if (price is double) return price;
    if (price is String) {
      return double.tryParse(price) ?? 0.0;
    }
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': int.tryParse(id!),
      'title': name,
      'price': price,
      'description': description,
      'images': [imageUrl],
      'thumbnail': imageUrl,
      'category': 'smartphones',
      'brand': 'Generic',
    };
  }
}

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
    final image = json['images'] is List && json['images'].isNotEmpty
        ? json['images'][0] as String
        : json['thumbnail'] as String? ?? json['image'] as String? ?? '';

    return Product(
      id: json['id']?.toString(),
      name: json['title'] as String? ?? json['name'] as String? ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'] is double
              ? json['price'] as double
              : double.tryParse(json['price']?.toString() ?? '0') ?? 0,
      description: json['description'] as String? ?? '',
      imageUrl: image,
    );
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

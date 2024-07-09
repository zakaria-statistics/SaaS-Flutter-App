class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String>? imageUrls;
  final String category;
  final int stock;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.imageUrls,
    required this.category,
    required this.stock,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    try {
      return Product(
        id: id,
        name: data['name'] ?? 'Unknown',
        description: data['description'] ?? 'No description available',
        price: (data['price'] is num) ? (data['price'] as num).toDouble() : 0.0,
        imageUrl: data['imageUrl'] ?? '',
        imageUrls: data['imageUrls'] != null ? List<String>.from(data['imageUrls']) : [],
        category: data['category'] ?? 'Uncategorized',
        stock: data['stock'] ?? 0,
      );
    } catch (e) {
      print('Error parsing product data entity level: $e');
      throw Exception('Error parsing product data');
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'imageUrls': imageUrls,
      'category': category,
      'stock': stock,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, imageUrls: $imageUrls, category: $category, stock: $stock}';
  }
}

// models/product.dart
import 'package:equatable/equatable.dart';
import 'package:my_web_app/features/user_auth/presentation/backend/entities/product_entity.dart';

/*class Product extends Equatable {
  final String id;
  final String title;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.price,
  });

  @override
  List<Object> get props => [id, title, price];
}*/

// models/cart_item.dart

class CartItem extends Equatable {
  final Product product;
  final String id;
  final String image;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.product,
    required this.id,
    required this.image,
    required this.title,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object> get props => [id, title, quantity, price];
}

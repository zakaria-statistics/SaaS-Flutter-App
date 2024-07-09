part of 'products_bloc.dart';


abstract class ProductEvent {}

class AddProductEvent extends ProductEvent {
  Product product;
  String? userId;

  AddProductEvent({required this.product, this.userId});
}

class AllProductsEvent extends ProductEvent {}
class ProductByIdEvent extends ProductEvent {
  String productId;
  ProductByIdEvent({required this.productId});
}

class UserProductsEvent extends ProductEvent {
  String userId;
  UserProductsEvent({required this.userId}){
    print('!!!user products event $userId');
  }
}

class UpdateProductEvent extends ProductEvent {
  String id;
  Product product;
  String? userId;
  UpdateProductEvent({required this.id, required this.product, this.userId});
}

class DeleteProductEvent extends ProductEvent {
  String id;
  String? userId;
  DeleteProductEvent({required this.id, this.userId});
}


part of 'cart_bloc.dart';


abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvent {
  final Product product;

  AddItem(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveAllItems extends CartEvent {
  final String productId;

  RemoveAllItems({required this.productId});

  @override
  List<Object> get props => [productId];
}

class RemoveItem extends CartEvent {
  final String productId;

  RemoveItem(this.productId);


  // list of properties that will be used to determine whether two items are equals
  @override
  List<Object> get props => [productId];
}

class ResetCart extends CartEvent {}



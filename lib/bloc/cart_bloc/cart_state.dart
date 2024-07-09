part of 'cart_bloc.dart';

class CartState extends Equatable {
  final Map<String, CartItem> items;

  CartState({required this.items});

  @override
  List<Object> get props => [items];

  double get totalAmount {
    return items.values.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  int get itemCount {
    return items.length;
  }
}

class InitialCartState extends CartState {
  InitialCartState() : super(items: {});
}

class LoadingCartState extends CartState {
  LoadingCartState({required Map<String, CartItem> items}) : super(items: items);
}

class SuccessCartState extends CartState {
  SuccessCartState({required Map<String, CartItem> items}) : super(items: items);
}

class ErrorCartState extends CartState {
  final String errorMessage;

  ErrorCartState({required Map<String, CartItem> items, required this.errorMessage}) : super(items: items);

  @override
  List<Object> get props => [items, errorMessage];
}


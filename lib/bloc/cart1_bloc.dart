/*
// bloc/cart_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/user_auth/presentation/backend/entities/cart_item.dart';

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
class LoadingCartState extends CartState {
  LoadingCartState({required super.items});
}
class SuccessCartState extends CartState {
  SuccessCartState({required super.items});
}
class ErrorCartState extends CartState {
  ErrorCartState({required super.items});
}

// bloc/cart_event.dart


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

class RemoveItem extends CartEvent {
  final String productId;

  RemoveItem(this.productId);

  @override
  List<Object> get props => [productId];
}

// bloc/cart_bloc.dart



class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: {})){
    on((AddItem event, emit) {
      emit(
          LoadingCartState(items: {})
      );
      try {
        final updatedItems = Map<String, CartItem>.from(state.items);
        if (updatedItems.containsKey(event.product.id)) {
          updatedItems.update(event.product.id, (existingItem) => CartItem(
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity + 1,
            price: existingItem.price,
          ),
          );
          print(updatedItems.toString());
        } else {
          updatedItems.putIfAbsent(
            event.product.id,
                () => CartItem(
              id: DateTime.now().toString(),
              title: event.product.title,
              quantity: 1,
              price: event.product.price,
            ),
          );
          print(updatedItems.toString());
        }
        emit(
            SuccessCartState(items: updatedItems)
        );
      } catch (e) {
        emit(
            ErrorCartState(items: {})
        );
      }
    });
    on((RemoveItem event, emit) {
      emit(
          LoadingCartState(items: {})
      );
      try {
        final updatedItems = Map<String, CartItem>.from(state.items);
        updatedItems.remove(event.productId);
        emit(
            SuccessCartState(items: updatedItems)
        );
      } catch (e) {
        emit(
            ErrorCartState(items: {})
        );
      }
    });
  }
}*/

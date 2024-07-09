import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../features/user_auth/presentation/backend/entities/cart_item.dart';
import '../../features/user_auth/presentation/backend/entities/product_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartBloc() : super(CartState(items: {})) {
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<RemoveAllItems>(_onRemoveAllItem);
    on<ResetCart>(_onRestCart);
  }

  void _onAddItem(AddItem event, Emitter<CartState> emit) {
    try {
      final updatedItems = Map<String, CartItem>.from(state.items);
      if (updatedItems.containsKey(event.product.id)) {
        updatedItems.update(
          event.product.id!,
              (existingItem) => CartItem(
                product: existingItem.product,
                image: existingItem.image,
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity + 1,
            price: existingItem.price,
          ),
        );
      } else {
        updatedItems.putIfAbsent(
          event.product.id!,
              () => CartItem(
                product: event.product,
                image: event.product.imageUrl,
            id: event.product.id!,
            title: event.product.id!,
            quantity: 1,
            price: event.product.price,
          ),
        );
      }
      emit(SuccessCartState(items: updatedItems));
    } catch (e) {
      emit(ErrorCartState(items: state.items, errorMessage: e.toString()));
    }
  }

  void _onRemoveItem(RemoveItem event, Emitter<CartState> emit) {
    try {
      final updatedItems = Map<String, CartItem>.from(state.items);
      if (updatedItems.containsKey(event.productId)) {
        final cartItem = updatedItems[event.productId]!;
        if (cartItem.quantity > 1) {
          updatedItems.update(
            event.productId,
                (existingItem) => CartItem(
                  product: existingItem.product,
                  image: existingItem.image,
              id: existingItem.id,
              title: existingItem.title,
              quantity: existingItem.quantity - 1,
              price: existingItem.price,
            ),
          );
        } else {
          updatedItems.remove(event.productId);
        }
      }
      emit(SuccessCartState(items: updatedItems));
    } catch (e) {
      emit(ErrorCartState(items: state.items, errorMessage: e.toString()));
    }
  }
  void _onRemoveAllItem(RemoveAllItems event, Emitter<CartState> emit) {
    try {
      final updatedItems = Map<String, CartItem>.from(state.items);
      if (updatedItems.containsKey(event.productId)) { // why we check here the id???
          updatedItems.remove(event.productId);
      }
      emit(SuccessCartState(items: updatedItems));
    } catch (e) {
      emit(ErrorCartState(items: state.items, errorMessage: e.toString()));
    }
  }
  void _onRestCart(ResetCart event, Emitter<CartState> emit) {
    try {
      emit(SuccessCartState(items: {}));
    } catch (e) {
      emit(ErrorCartState(items: state.items, errorMessage: e.toString()));
    }
  }

}

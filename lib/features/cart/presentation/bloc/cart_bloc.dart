import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartAddItem>(_onAddItem);
    on<CartRemoveItem>(_onRemoveItem);
  }

  void _onAddItem(CartAddItem event, Emitter<CartState> emit) {
    final index = state.items.indexWhere((i) => i.meal.id == event.meal.id);
    final updated = List<CartItem>.from(state.items);
    if (index >= 0) {
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + 1,
      );
    } else {
      updated.add(CartItem(meal: event.meal, quantity: 1));
    }
    emit(state.copyWith(items: updated));
  }

  void _onRemoveItem(CartRemoveItem event, Emitter<CartState> emit) {
    final index = state.items.indexWhere((i) => i.meal.id == event.mealId);
    if (index < 0) return; // unknown id — no state change
    final updated = List<CartItem>.from(state.items);
    if (updated[index].quantity > 1) {
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity - 1,
      );
    } else {
      updated.removeAt(index);
    }
    emit(state.copyWith(items: updated));
  }
}

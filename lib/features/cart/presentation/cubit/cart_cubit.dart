import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_item.dart';
import '../../../home/domain/entities/meal_entity.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addItem(MealEntity meal) {
    final index = state.items.indexWhere((i) => i.meal.id == meal.id);
    final updated = List<CartItem>.from(state.items);
    if (index >= 0) {
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + 1,
      );
    } else {
      updated.add(CartItem(meal: meal, quantity: 1));
    }
    emit(state.copyWith(items: updated));
  }

  void removeItem(String mealId) {
    final index = state.items.indexWhere((i) => i.meal.id == mealId);
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

  void clearAll() {
    emit(const CartState());
  }
}

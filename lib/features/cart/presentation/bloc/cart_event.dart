import '../../../home/domain/entities/meal_entity.dart';

abstract class CartEvent {
  const CartEvent();
}

/// Adds [meal] to the cart. If it is already present, increments its quantity.
class CartAddItem extends CartEvent {
  final MealEntity meal;
  const CartAddItem(this.meal);
}

/// Decrements the quantity of the item identified by [mealId].
/// Removes the item entirely when quantity reaches zero.
class CartRemoveItem extends CartEvent {
  final String mealId;
  const CartRemoveItem(this.mealId);
}

/// Removes all items from the cart (e.g. on logout).
class CartClearAll extends CartEvent {
  const CartClearAll();
}
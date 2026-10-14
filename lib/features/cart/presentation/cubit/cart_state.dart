import '../../domain/entities/cart_item.dart';

class CartState {
  final List<CartItem> items;

  const CartState({this.items = const []});

  /// Total number of individual units across all cart items.
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  CartState copyWith({List<CartItem>? items}) =>
      CartState(items: items ?? this.items);
}

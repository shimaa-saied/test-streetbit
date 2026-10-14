import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'cartTitle'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (ctx, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Theme.of(ctx).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'cartEmpty'.tr(),
                    style: Theme.of(ctx).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.items.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (ctx, idx) {
              final item = state.items[idx];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.meal.thumbnailUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, _, _) => Container(
                      width: 56,
                      height: 56,
                      color: Theme.of(ctx).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.broken_image_outlined, size: 24),
                    ),
                  ),
                ),
                title: Text(
                  item.meal.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  item.meal.category,
                  style: Theme.of(ctx).textTheme.bodySmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '×${item.quantity}',
                      style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      tooltip: 'removeItem'.tr(),
                      icon: Icon(
                        Icons.remove_circle_outline_rounded,
                        color: Theme.of(ctx).colorScheme.error,
                      ),
                      onPressed: () =>
                          ctx.read<CartCubit>().removeItem(item.meal.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

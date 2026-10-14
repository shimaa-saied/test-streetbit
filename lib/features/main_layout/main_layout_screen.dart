import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_test/core/dependency_injection/injection.dart';
import '../cart/presentation/cubit/cart_cubit.dart';
import '../cart/presentation/cubit/cart_state.dart';
import '../cart/presentation/screens/cart_screen.dart';
import '../favorites/favorites_screen.dart';
import '../home/presentation/screens/home_screen.dart';
import '../profile/profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.locale;
  }

  static const List<Widget> _tabs = [
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartCubit>(),
      child: Scaffold(
        body: _tabs[_currentIndex],
        bottomNavigationBar: BlocSelector<CartCubit, CartState, int>(
          selector: (state) => state.itemCount,
          builder: (ctx, cartCount) => NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) =>
                setState(() => _currentIndex = index),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home_rounded),
                label: 'homeTab'.tr(),
              ),
              NavigationDestination(
                icon: const Icon(Icons.favorite_outline_rounded),
                selectedIcon: const Icon(Icons.favorite_rounded),
                label: 'favoritesTab'.tr(),
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  child: const Icon(Icons.shopping_cart_rounded),
                ),
                label: 'cartTab'.tr(),
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline_rounded),
                selectedIcon: const Icon(Icons.person_rounded),
                label: 'profileTab'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

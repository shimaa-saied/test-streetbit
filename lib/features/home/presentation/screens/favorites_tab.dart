import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'favoritesEmpty'.tr(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

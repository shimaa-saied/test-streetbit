import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'ordersEmpty'.tr(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

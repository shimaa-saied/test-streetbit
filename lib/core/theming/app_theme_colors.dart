import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Resolves colors from the active theme. Use for colors that may
/// differ between light and dark modes. For static brand colors use [AppColors].
abstract final class AppThemeColors {
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color error(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color onSurface(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;
}

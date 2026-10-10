import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Brand ────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF7A5CFA);
  static const Color primaryDark = Color(0xFF2B2E83);

  // ── Card gradient ─────────────────────────────────────────────────────────
  static const List<Color> cardGradient = [primaryDark, primary];

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color deposit = Colors.green;
  static const Color withdraw = Colors.red;
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  static const Color successAccent = Colors.greenAccent;

  // ── Text / Surface ────────────────────────────────────────────────────────
  static const Color textOnCard = Colors.white;
  static const Color textOnCardMuted = Colors.white70;
  static const Color textMuted = Colors.grey;
  static const Color blackColor = Colors.black;
}

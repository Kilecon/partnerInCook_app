import 'package:flutter/material.dart';

abstract class AppColors {
  // Couleurs neutres
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Couleurs d'état - Versions pastel (douces et harmonieuses)
  static const Color errorColorPastel = Color(
    0xFFFECDD3,
  ); // Rouge pastel très doux
  static const Color warningColorPastel = Color(
    0xFFFEF3C7,
  ); // Jaune pastel très doux
  static const Color successColorPastel = Color(
    0xFFD1FAE5,
  ); // Vert pastel très doux
  static const Color infoColorPastel = Color(
    0xFFDBEAFE,
  ); // Bleu pastel très doux

  // Couleurs d'état - Versions intermédiaires (entre normal et pastel)
  static const Color background = Color(0xFFFDF7E9); // Rouge clair
  static const Color primaryOrange = Color(0xFFFFF9009); // Orange
  static const Color lightOrange = Color(0xFFFFE9CE); // Orange clair
  static const Color lightGray = Color(0xFF666666); // Orange foncé

  static const Color infoColorLight = Color(0xFF93C5FD); // Bleu clair
  static const Color successColorLight = Color(0xFF6EE7B7); // Vert clair
  static const Color warningColorLight = Color(0xFFFCD34D); // Ja
}


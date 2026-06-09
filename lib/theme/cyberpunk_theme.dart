import 'package:flutter/material.dart';

class CyberColors {
  CyberColors._();

  // Fondos
  static const Color bgDark = Color(0xFF0A0A0F);
  static const Color bgCard = Color(0xFF1A0033);
  static const Color bgInput = Color(0xFF2D004D);

  // Neones principales
  static const Color purple = Color(0xFF9C27B0);
  static const Color magenta = Color(0xFFFF00FF);
  static const Color cyan = Color(0xFF00F5FF);
  static const Color cyanAccent = Colors.cyanAccent;

  // Texto
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0FF);

  // Bordes
  static const Color border = Color(0xFF4D0080);
}

extension EstadoEmoji on String {
  String get emoji {
    switch (this) {
      case 'Pendiente':
        return '💤 Pendiente 💤';
      case 'En Progreso':
        return '🚀 En Progreso 🚀';
      case 'Completada':
        return '🚀 Tarea Completada 🚀';
      default:
        return this;
    }
  }

  Color get estadoColor {
    switch (this) {
      case 'Pendiente':
        return CyberColors.magenta;
      case 'En Progreso':
        return CyberColors.cyan;
      case 'Completada':
        return Colors.greenAccent;
      default:
        return CyberColors.textSecondary;
    }
  }
}

class CyberGlow {
  CyberGlow._();

  static List<BoxShadow> of(Color color, {double intensity = 1.0}) => [
        BoxShadow(
          color: color.withOpacity(0.6 * intensity),
          blurRadius: 12 * intensity,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: color.withOpacity(0.3 * intensity),
          blurRadius: 30 * intensity,
          spreadRadius: 2,
        ),
      ];
}

ThemeData cyberTheme() => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CyberColors.bgDark,
      colorScheme: const ColorScheme.dark(
        primary: CyberColors.cyan,
        secondary: CyberColors.purple,
        surface: CyberColors.bgCard,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );

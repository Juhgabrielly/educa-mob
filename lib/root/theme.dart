
import 'package:flutter/material.dart';
import 'pallet.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppPalette.fundo,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppPalette.roxo,
        primary: AppPalette.roxo,
        surface: AppPalette.superficie,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.fundo,
        foregroundColor: AppPalette.roxoEscuro,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          color: AppPalette.textoSecundario,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: AppPalette.borda,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: AppPalette.borda,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: AppPalette.roxo,
            width: 1.5,
          ),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Color(0xFFEDE3FF),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 11),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:poloniex_app/core/constants/colors.dart';

abstract final class AppThemes {
  static ThemeData get light => _lightTheme;
  static ThemeData get dark => _darkTheme;
}

final _darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primary,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size.fromHeight(50)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 06,
        horizontal: 12,
      ),
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.primary,
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xff414141),
      contentTextStyle: const TextStyle(
        color: Colors.white,
      ),
    ));

final _lightTheme = ThemeData.light().copyWith(
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
        backgroundColor: const Color(0xff334155),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size.fromHeight(50)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 06,
      horizontal: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    ),
  ),
);

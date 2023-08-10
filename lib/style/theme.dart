import 'package:flutter/material.dart';
import 'package:parallel/style/app_colors.dart';

final lightTheme = ThemeData(
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'SF-Pro-Display',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.gray600,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.gray600,
      ),
      labelLarge: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.gray600,
      ),
      labelMedium: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.gray600,
      ),
      titleLarge: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.gray400,
      ),
      titleSmall: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: AppColors.gray300,
      ),
      displayMedium: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.gray400,
      ),
      bodySmall: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: AppColors.gray500,
      ),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        titleTextStyle: TextStyle(
          fontFamily: 'SF-Pro-Text',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.gray600,
        )),
    scaffoldBackgroundColor: AppColors.background,
    disabledColor: AppColors.gray200,
    highlightColor: AppColors.pink.withOpacity(0.1),
    splashColor: AppColors.blue.withOpacity(0.3),
    listTileTheme: ListTileThemeData(
      tileColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 16,
        bottom: 16,
      ),
      isDense: true,
      disabledBorder: InputBorder.none,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(
          color: AppColors.gray600,
        ),
      ),
      hintStyle: const TextStyle(
        color: AppColors.gray300,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      iconColor: AppColors.gray300,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.gray100,
        ),
      ),
      errorStyle: const TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.red,
      ),
      labelStyle: const TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.gray600,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.gray400,
      onPrimary: AppColors.gray600,
      secondary: AppColors.gray600,
      onSecondary: AppColors.white,
      error: AppColors.red,
      background: AppColors.white,
      onError: AppColors.orange,
      surface: AppColors.gray200,
      onBackground: AppColors.gray100,
      onSurface: AppColors.gray300,
      tertiary: AppColors.completed,
    ),
);

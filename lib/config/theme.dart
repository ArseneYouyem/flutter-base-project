import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constant_colors.dart';
import 'style.dart';

ThemeData currentTheme({bool lightTheme = false}) {
  ThemeData light = ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppColor.backGround,
      primaryColor: AppColor.white,
      inputDecorationTheme: InputDecorationTheme(hintStyle: titleBodyStyle()),
      colorScheme: ThemeData.light().colorScheme.copyWith(
            // surfaceTint: AppColor.blue210,
            // primaryContainer: AppColor.primaryYellow,
            primary: AppColor.primary,
          ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColor.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          iconTheme: const IconThemeData(color: AppColor.primary),
          foregroundColor: AppColor.primary,
          titleTextStyle: titleStyle(size: 14, fontWeight: FontWeight.w800),
          backgroundColor: AppColor.white),
      textTheme: TextTheme(bodyMedium: titleBodyStyle()));

  ThemeData dark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColor.backGround,
      colorScheme: ThemeData.dark().colorScheme.copyWith(
            primary: AppColor.white,
            brightness: Brightness.dark,
            onSurfaceVariant: AppColor.primary,
            onSurface: Colors.white,
          ),
      appBarTheme: AppBarTheme(
          centerTitle: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColor
                .transparent, // Définit la couleur de fond de la barre de statut
            statusBarIconBrightness: Brightness
                .light, // Définit la luminosité des icônes de la barre de statut
            // Pour Android, utilisez statusBarBrightness.
            statusBarBrightness: Brightness.dark, // iOS seulement
          ),
          iconTheme: const IconThemeData(color: AppColor.white),
          foregroundColor: AppColor.white,
          titleTextStyle: titleStyle(size: 14),
          backgroundColor: AppColor.transparent),
      textTheme: TextTheme(bodyMedium: titleBodyStyle(color: AppColor.white)));
  return lightTheme ? light : dark;
}

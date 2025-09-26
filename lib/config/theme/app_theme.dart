import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';

const colorSeed = AppColors.primary;
const scaffoldBackgroundColor = AppColors.tertiary;

class AppTheme {
  ThemeData getTheme() => ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins().copyWith(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.poppins().copyWith(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleSmall: GoogleFonts.poppins().copyWith(
        fontSize: 20,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.poppins().copyWith(color: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.white,

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w700),
        ),
        backgroundColor: WidgetStatePropertyAll(colorSeed),
      ),
    ),

    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.poppins().copyWith(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    colorSchemeSeed: colorSeed,
  );
}

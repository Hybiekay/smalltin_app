import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smalltin/themes/color.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      cardColor: AppColor.pColor,
      canvasColor: AppColor.scaffoldBg,
      textTheme: TextTheme(
        titleLarge: GoogleFonts.inter(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: LightModeColor.textColor,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: LightModeColor.textColor,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: LightModeColor.textColor,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 13.8,
          color: LightModeColor.textColor,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 15,
          color: LightModeColor.textColor,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 17,
          color: LightModeColor.textColor,
        ),
      ),
      // Define container styles
      scaffoldBackgroundColor: LightModeColor.scaffoldBg,
      primaryColor: LightModeColor.pimary,
      appBarTheme: const AppBarTheme(
        backgroundColor: LightModeColor.scaffoldBg,
        centerTitle: true,
        iconTheme: IconThemeData(color: LightModeColor.pimary),
      ),
      iconTheme: const IconThemeData(color: LightModeColor.pimary));

/*
 this in the 
 dart mode



 */

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      textTheme: TextTheme(
        titleLarge: GoogleFonts.inter(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: AppColor.gray,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: AppColor.gray,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: AppColor.gray,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 13.8,
          color: AppColor.gray,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 15,
          color: AppColor.gray,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 17,
          color: DarkModeColor.textColor,
        ),
      ),
      cardColor: AppColor.gray,
      canvasColor: AppColor.pColor,
      // Define container styles
      scaffoldBackgroundColor: DarkModeColor.scaffoldBg,
      primaryColor: DarkModeColor.pimary,
      appBarTheme: const AppBarTheme(
        backgroundColor: DarkModeColor.scaffoldBg,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.gray),
      ),
      iconTheme: const IconThemeData(color: AppColor.gray));
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smalltin/themes/color.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      cardColor: AppColor.pColor,
      canvasColor: AppColor.scaffoldBg,
      textTheme: TextTheme(
        titleLarge: GoogleFonts.inter(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: LightModeColor.textColor,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: LightModeColor.textColor,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: LightModeColor.textColor,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12.sp,
          color: LightModeColor.textColor,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13.sp,
          color: LightModeColor.textColor,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16.sp,
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
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.gray,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.gray,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.gray,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12.sp,
          color: AppColor.gray,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13.sp,
          color: AppColor.gray,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16.sp,
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

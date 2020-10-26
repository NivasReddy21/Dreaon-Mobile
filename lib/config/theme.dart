
import 'dart:io';

import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.deepOrange,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.scaffoldColor,
  fontFamily: AppConstants.primaryFont,
  appBarTheme: AppBarTheme(
    brightness: Platform.isIOS ? Brightness.light : Brightness.dark,
    color: AppColors.appBarColor,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black54,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black54,
        fontFamily: AppConstants.primaryFont,
      ),
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    onPrimary: Colors.black87,
    primaryVariant: Colors.white38,
    secondary: AppColors.secondaryColor,
  ),
  iconTheme: IconThemeData(
    color: Colors.black54,
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Colors.grey,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepOrange,
  primaryColor: AppColors.primaryColor,
  primaryColorLight: AppColors.primaryDarkColor,
  primaryColorDark: AppColors.primaryLightColor,
  scaffoldBackgroundColor: AppColors.scaffoldColorDark,
  fontFamily: GoogleFonts.poppins().fontFamily,
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    color: AppColors.appBarColorDark,
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white54,
        fontFamily: AppConstants.primaryFont,
      ),
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.black38,
    onPrimary: Colors.white70,
    primaryVariant: Colors.black,
    secondary: AppColors.secondaryColor,
  ),
  iconTheme: IconThemeData(
    color: Colors.white54,
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Colors.white24,
    ),
  ),
);

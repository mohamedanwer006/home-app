import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_app/theme/color.dart';

///darkTheme
ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
    headline6: GoogleFonts.arvo(color: AppColors.textColor2_dark),
    headline5: GoogleFonts.arvo(color: AppColors.textColor2_dark),
    headline4: GoogleFonts.arvo(color: AppColors.textColor_dark),
    headline3: GoogleFonts.arvo(color: AppColors.textColor_dark),
    headline2: GoogleFonts.arvo(color: AppColors.textColor2_dark),
    headline1: GoogleFonts.arvo(color: AppColors.textColor2_dark),
    subtitle1: GoogleFonts.arvo(color: AppColors.textColor_dark),
    subtitle2: GoogleFonts.arvo(color: AppColors.textColor2_dark),
    bodyText1: GoogleFonts.arvo(color: AppColors.textColor_dark),
    bodyText2: GoogleFonts.arvo(color: AppColors.textColor2_dark),
  ),
  backgroundColor: AppColors.backgroundColor_dark,
  primaryColor: AppColors.primaryColor_dark,
  iconTheme: IconThemeData(color: AppColors.iconsColor_dark),
  cardColor: AppColors.cardColor_dark,
  accentColor: AppColors.accentColor_dark,
  dialogTheme: DialogTheme(elevation: 0),
  dialogBackgroundColor: AppColors.cardColor_dark,
  canvasColor: AppColors.backgroundColor_dark,
  hoverColor: AppColors.accentColor_dark.withOpacity(0.2),
  highlightColor: AppColors.accentColor_dark.withOpacity(0.4),
  dividerColor: AppColors.dividerColor_dark,
);

///lightTheme
ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    headline6: GoogleFonts.arvo(color: AppColors.textColor_light),
    headline5: GoogleFonts.arvo(color: AppColors.textColor2_light),
    headline4: GoogleFonts.arvo(color: AppColors.textColor_light),
    headline3: GoogleFonts.arvo(color: AppColors.textColor_light),
    headline2: GoogleFonts.arvo(color: AppColors.textColor2_light),
    headline1: GoogleFonts.arvo(color: AppColors.textColor2_light),
    subtitle1: GoogleFonts.arvo(color: AppColors.textColor_light),
    subtitle2: GoogleFonts.arvo(color: AppColors.textColor_light),
    bodyText1: GoogleFonts.arvo(color: AppColors.textColor_light),
    bodyText2: GoogleFonts.arvo(color: AppColors.textColor2_light),
  ),
  backgroundColor: AppColors.backgroundColor_light,
  primaryColor: AppColors.primaryColor_light,
  iconTheme: IconThemeData(color: AppColors.iconsColor_light),
  cardColor: AppColors.cardColor_light,
  accentColor: AppColors.accentColor_light,
  dialogTheme: DialogTheme(elevation: 0),
  dialogBackgroundColor: AppColors.cardColor_light,
  canvasColor: AppColors.backgroundColor_light,
  hoverColor: AppColors.primaryColor_light.withOpacity(0.2),
  highlightColor: AppColors.primaryColor_light.withOpacity(0.4),
  dividerColor: AppColors.dividerColor_light,
);

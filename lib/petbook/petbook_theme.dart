// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class PetbookTheme {
  static PetbookTheme of(BuildContext context) => LightModeTheme();

  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;
  Color alternate;
  Color primaryBackground;
  Color secondaryBackground;
  Color primaryText;
  Color secondaryText;

  Color primaryDark;
  Color background;
  Color grayIcon;
  Color gray200;
  Color dark600;

  TextStyle get title1 => GoogleFonts.getFont(
        'Inter',
        color: primaryDark,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      );
  TextStyle get title2 => GoogleFonts.getFont(
        'Inter',
        color: primaryDark,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );
  TextStyle get title3 => GoogleFonts.getFont(
        'Inter',
        color: primaryDark,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Inter',
        color: grayIcon,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Inter',
        color: primaryDark,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Inter',
        color: grayIcon,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Inter',
        color: primaryDark,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class LightModeTheme extends PetbookTheme {
  Color primaryColor = const Color(0xFF3A405A);
  Color secondaryColor = const Color(0xFF84A59D);
  Color tertiaryColor = const Color(0xFFF7EDE2);
  Color alternate = const Color(0x00000000);
  Color primaryBackground = const Color(0x00000000);
  Color secondaryBackground = const Color(0x00000000);
  Color primaryText = const Color(0x00000000);
  Color secondaryText = const Color(0x00000000);

  Color primaryDark = Color(0xFF1A1F24);
  Color background = Color(0xFFF1F4F8);
  Color grayIcon = Color.fromARGB(255, 115, 121, 126);
  Color gray200 = Color(0xFFDBE2E7);
  Color dark600 = Color(0xFF262D34);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
    double lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              height: lineHeight,
            );
}

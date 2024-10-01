import 'package:flutter/material.dart';
import 'package:parmosys_flutter/gen/fonts.gen.dart';

class TextStyles {
  static const TextStyle ralewayStyles = TextStyle(
    fontFamily: FontFamily.raleway,
    color: Colors.white,
  );

  static TextStyle get bold => ralewayStyles.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 20.0,
      );

  static TextStyle get extraBold => ralewayStyles.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 40.0,
      );

  static TextStyle get light => ralewayStyles.copyWith(fontWeight: FontWeight.w300);

  static TextStyle get black => ralewayStyles.copyWith(
        fontWeight: FontWeight.w900,
        fontSize: 20.0,
        letterSpacing: 6.0,
      );

  static TextStyle get medium => ralewayStyles.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 10.0,
        letterSpacing: 2.0,
      );
}

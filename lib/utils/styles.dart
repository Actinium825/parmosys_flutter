import 'package:flutter/material.dart';
import 'package:parmosys_flutter/gen/fonts.gen.dart';

class TextStyles {
  static const TextStyle ralewayStyles = TextStyle(
    fontFamily: FontFamily.raleway,
    color: Colors.white,
  );

  static TextStyle get bold => ralewayStyles.copyWith(fontWeight: FontWeight.w700);

  static TextStyle get extraBold => ralewayStyles.copyWith(fontWeight: FontWeight.w800);

  static TextStyle get light => ralewayStyles.copyWith(fontWeight: FontWeight.w300);
}

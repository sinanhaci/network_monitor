import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextFontParams {
  static double fontSize_6 = 4.sp;
  static double fontSize_7 = 5.sp;
  static double fontSize_8 = 6.sp;
  static double fontSize_9 = 7.sp;
  static double fontSize_10 = 8.sp;
  static double fontSize_11 = 9.sp;
  static double fontSize_12 = 10.sp;
  static double fontSize_13 = 11.sp;
  static double fontSize_14 = 12.sp;
  static double fontSize_16 = 13.sp;

  static const FontWeight boldFontWeight = FontWeight.w700;
  static const FontWeight normalFontWeight = FontWeight.normal;

  static fontBase(Color color, double size, FontWeight fontWeight) {
    return GoogleFonts.roboto(
        color: color, fontSize: size, fontWeight: fontWeight);
  }
}

class CustomTextStyle {
  static TextStyle boldFont6(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_6, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont6(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_6, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFont7(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_7, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont7(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_7, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFont8(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_8, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont8(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_8, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFont9(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_9, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont9(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_9, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFont10(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_10, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont10(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_10, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFont11(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_11, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont11(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_11, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFont12(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_12, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont12(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_12, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFont13(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_13, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont13(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_13, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFont14(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_14, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont14(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_14, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFont16(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_16, TextFontParams.boldFontWeight);
  }

  static TextStyle normalFont16(Color color) {
    return TextFontParams.fontBase(
        color, TextFontParams.fontSize_16, TextFontParams.normalFontWeight);
  }

  static TextStyle normalFontRandom(Color color, double size) {
    return TextFontParams.fontBase(
        color, size, TextFontParams.normalFontWeight);
  }

  static TextStyle boldFontRandom(Color color, double size) {
    return TextFontParams.fontBase(color, size, TextFontParams.boldFontWeight);
  }
}

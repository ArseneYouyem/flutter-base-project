import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant_colors.dart';

//
//textStyle
//
TextStyle titleStyle(
    {double? size,
    Color? color,
    FontWeight? fontWeight,
    Color? decorationColor,
    bool underline = false}) {
  return titleBodyStyle(
      size: size ?? 17,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w700,
      decorationColor: decorationColor,
      underline: underline);
}

TextStyle titleBodyStyle(
    {double? size,
    Color? color,
    FontWeight? fontWeight,
    Color? decorationColor,
    double? interLine,
    bool underline = false}) {
  return GoogleFonts.inter(
    fontSize: size ?? 14,
    height: interLine,
    color: color ?? AppColor.black,
    fontWeight: fontWeight ?? FontWeight.w600,
    decoration: underline ? TextDecoration.underline : TextDecoration.none,
    // decorationColor: decorationColor ?? AppColor.primary,
    decorationThickness: 2,
  );
}

TextStyle textBodyStyle(
    {double? size,
    Color? color,
    FontWeight? fontWeight,
    double? interLine,
    Color? decorationColor,
    bool underline = false}) {
  return titleBodyStyle(
      size: size ?? 12,
      color: color,
      interLine: interLine,
      fontWeight: fontWeight ?? FontWeight.w400,
      decorationColor: decorationColor,
      underline: underline);
}

BoxDecoration get deco => BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: AppColor.primary,
    );

BoxDecoration get deco2 => BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: AppColor.lightMedium.withValues(alpha: 0.3),
    ));

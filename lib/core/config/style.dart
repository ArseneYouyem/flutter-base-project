import 'package:flutter/material.dart';
import 'package:flutterbasestructure/core/config/constant_colors.dart';

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
      fontWeight: fontWeight ?? FontWeight.w900,
      decorationColor: decorationColor,
      underline: underline);
}

TextStyle titleStyle2(
    {double? size,
    Color? color,
    FontWeight? fontWeight,
    Color? decorationColor,
    double? height,
    bool underline = false}) {
  return TextStyle(
    fontSize: size ?? 24,
    height: height,
    color: color ?? AppColor.black,
    fontWeight: fontWeight ?? FontWeight.w900,
    decoration: underline ? TextDecoration.underline : TextDecoration.none,
    decorationColor: decorationColor ?? AppColor.primary,
    decorationThickness: 2,
    fontFamily: "Satoshi",
  );
}

TextStyle titleBodyStyle(
    {double? size,
    Color? color,
    FontWeight? fontWeight,
    Color? decorationColor,
    double? interLine,
    bool underline = false}) {
  return TextStyle(
    fontSize: size ?? 16,
    height: interLine,
    color: color ?? AppColor.black,
    fontWeight: fontWeight ?? FontWeight.w500,
    decoration: underline ? TextDecoration.underline : TextDecoration.none,
    decorationColor: decorationColor ?? AppColor.primary,
    decorationThickness: 2,
    fontFamily: "Satoshi",
  );
}

TextStyle titleBodyStyle2(
    {double? size,
    Color? color,
    FontWeight? fontWeight,
    Color? decorationColor,
    double? interLine,
    bool underline = false}) {
  return TextStyle(
    fontSize: size ?? 12,
    height: interLine,
    color: color ?? AppColor.black,
    fontWeight: fontWeight ?? FontWeight.w600,
    decoration: underline ? TextDecoration.underline : TextDecoration.none,
    decorationColor: decorationColor ?? AppColor.primary,
    decorationThickness: 2,
    fontFamily: "Satoshi",
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
    size: size ?? 14,
    color: color,
    interLine: interLine,
    fontWeight: fontWeight ?? FontWeight.w500,
    decorationColor: decorationColor,
    underline: underline,
  );
}

LinearGradient blueGradient() => const LinearGradient(colors: [
      Color.fromRGBO(24, 49, 105, 1),
      Color.fromRGBO(61, 109, 214, 1),
      Color.fromRGBO(24, 49, 105, 1),
    ], stops: [
      0.07,
      0.51,
      0.97
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

BoxDecoration deco = BoxDecoration(
  border: Border.all(color: AppColor.borderColor),
  borderRadius: BorderRadius.circular(16),
);

BoxDecoration decoStatus = BoxDecoration(
  color: AppColor.red,
  shape: BoxShape.circle,
);

BoxDecoration decoGradientBlue = BoxDecoration(
    borderRadius: BorderRadius.circular(12), gradient: gradientBlue);

BoxDecoration decoGradientBlueReverse = BoxDecoration(
    borderRadius: BorderRadius.circular(12), gradient: gradientBlueReverse);

BoxDecoration decoGradientDarkBlue = BoxDecoration(
    borderRadius: BorderRadius.circular(12), gradient: gradientDarkBlue);

final gradientBlue2 = LinearGradient(
  colors: [
    Color.fromRGBO(43, 127, 255, 1),
    Color.fromRGBO(0, 184, 219, 1),
  ],
  // stops: [0.0, 0.8, 1.0],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
final gradientBlue = LinearGradient(
  colors: [
    Color(0xFF01BDFB),
    Color(0xFF1F5ED3),
    Color(0xFF2746C9),
  ],
  // stops: [0.0, 0.8, 1.0],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

final gradientDarkBlue = LinearGradient(
  colors: [
    Color.fromRGBO(0, 33, 97, 1),
    Color.fromRGBO(4, 34, 93, 1),
    Color.fromRGBO(15, 35, 75, 1),
  ],
  // stops: [0.0, 0.8, 1.0],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

final gradientBlueReverse = LinearGradient(
  colors: [
    Color.fromRGBO(39, 70, 201, 1),
    Color.fromRGBO(1, 189, 251, 1),
  ],
  // stops: [0.0, 0.8, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

BoxDecoration decoGradientBlueGreen = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    gradient: const LinearGradient(
      colors: [
        Color.fromRGBO(1, 189, 251, 1),
        Color.fromRGBO(111, 255, 186, 1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ));

BoxDecoration decoGradientRed = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    gradient: const LinearGradient(colors: [
      Color.fromRGBO(88, 13, 17, 1),
      Color.fromRGBO(229, 29, 19, 1),
      Color.fromRGBO(88, 13, 17, 1),
    ], begin: Alignment.bottomLeft, end: Alignment.topRight));

BoxDecoration decoGradientOrange = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    gradient: const LinearGradient(colors: [
      Color.fromRGBO(232, 153, 0, 1),
      Color.fromRGBO(255, 212, 128, 1),
      Color.fromRGBO(255, 153, 0, 1),
    ], begin: Alignment.topLeft, end: Alignment.bottomRight));

BoxDecoration decoBlue50 = BoxDecoration(
  color: AppColor.blue50,
  borderRadius: BorderRadius.circular(18),
);

BoxDecoration decoShadow = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: const Color.fromRGBO(245, 245, 245, 1),
    ),
    boxShadow: const [
      BoxShadow(
          color: Color.fromRGBO(75, 85, 104, 0.07),
          offset: Offset(0, 3),
          spreadRadius: 0,
          blurRadius: 8)
    ]);

import 'dart:math';

import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color.fromRGBO(0, 153, 64, 1);
  static const Color darkGreen = Color.fromRGBO(41, 130, 103, 1);
  static const Color lightGreen = Color.fromRGBO(223, 242, 233, 1);
  static const Color transparent = Colors.transparent;
  static const Color grey = Color.fromRGBO(143, 144, 152, 1);
  static const Color greyText = Color.fromRGBO(113, 114, 122, 1);
  static const Color greyBorder = Color.fromRGBO(197, 198, 204, 1);
  static const Color backGround = Color.fromRGBO(248, 248, 254, 1);
  static const Color lightMedium = Color.fromRGBO(232, 233, 241, 1);
  static const Color warning = Color.fromRGBO(232, 99, 57, 1);
  //
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color red = Colors.red;

  static int nameToNumber(String name) {
    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = 31 * hash + name.codeUnitAt(i);
    }
    return hash;
  }

  static Color nameToColor(String name) {
    int hash = nameToNumber(name);
    Random random = Random(hash);
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    return Color.fromRGBO(r, g, b, 1);
  }
}

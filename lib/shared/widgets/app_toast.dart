import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/config/constant_colors.dart';

class AppToast {
  static showToast(String txt,
      {Color? backgroud, Color? textColor, bool? error = false}) {
    Fluttertoast.showToast(
        msg: txt,
        textColor: textColor ?? AppColor.white,
        gravity: ToastGravity.CENTER,
        backgroundColor:
            backgroud ?? (error! ? AppColor.red : AppColor.primary));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/config/constant_colors.dart';

class AppSnackbar {
  static showSnackBar(String title, String message,
      {Color? backgroud,
      Color? textColor,
      bool error = false,
      IconData? icon,
      Color? iconColor,
      int? duration = 8}) {
    Get.snackbar(title, message,
        colorText: textColor ?? AppColor.white,
        duration: Duration(seconds: duration!),
        icon: Icon(
          icon ??
              (error
                  ? Icons.error_outline
                  : Icons.check_circle_outline_rounded),
          color: iconColor ?? (error ? AppColor.red : AppColor.white),
        ),
        backgroundColor: backgroud ??
            (error
                ? AppColor.grey
                : AppColor.darkGreen.withValues(alpha: 0.8)));
  }
}

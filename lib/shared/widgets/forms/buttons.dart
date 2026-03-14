import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/constant_colors.dart';
import '../../../core/config/style.dart';

Widget actionButton({required Widget child, VoidCallback? onTap}) {
  return InkWell(
    hoverColor: AppColor.transparent,
    highlightColor: AppColor.transparent,
    splashColor: AppColor.transparent,
    onTap: onTap,
    child: child,
  );
}

Widget customActionButton2(
    {required Widget child, VoidCallback? onTap, double radius = 12}) {
  return InkWell(
    borderRadius: BorderRadius.circular(radius),
    onTap: onTap,
    child: child,
  );
}

Widget primaryButton({
  Widget? child,
  String? text,
  VoidCallback? onTap,
  Color? color,
  Color? borderColor,
  Color? textColor,
  double? width,
  double? height,
  double? textSize,
  bool primary = true,
  bool autoSized = false,
  double? radius,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      side: primary ? null : BorderSide(color: borderColor ?? AppColor.primary),
      backgroundColor: color ?? (primary ? AppColor.primary : AppColor.white),
      // surfaceTintColor: AppColor.primary,
      foregroundColor: primary ? null : AppColor.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 12),
      ),
    ),
    onPressed: () {
      onTap?.call();
    },
    child: Container(
        alignment: Alignment.center,
        width: autoSized ? null : width ?? Get.width,
        child: autoSized
            ? text == null
                ? child
                : Text(
                    text,
                    style: titleBodyStyle(
                      size: textSize ?? 12,
                      color: textColor ??
                          (!primary ? AppColor.primary : AppColor.white),
                    ),
                  )
            : Center(
                child: text == null
                    ? child
                    : Text(
                        text,
                        style: titleBodyStyle(
                          size: textSize ?? 12,
                          color: textColor ??
                              (!primary ? AppColor.primary : AppColor.white),
                        ),
                      ))),
  );
}

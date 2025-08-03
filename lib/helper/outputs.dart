import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../navigation/navigation.dart';
import '../widget_components/forms/buttons.dart';
import '../config/constant_colors.dart';
import '../config/style.dart';
import '../widget_components/core_widget_const.dart';
import 'util.dart';

showToast(String txt,
    {Color? backgroud, Color? textColor, bool? error = false}) {
  Fluttertoast.showToast(
      msg: txt,
      textColor: textColor ?? AppColor.white,
      gravity: ToastGravity.CENTER,
      backgroundColor: backgroud ?? (error! ? AppColor.red : AppColor.primary));
}

showSnackBar(String title, String message,
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
            (error ? Icons.error_outline : Icons.check_circle_outline_rounded),
        color: iconColor ?? (error ? AppColor.red : AppColor.white),
      ),
      backgroundColor: backgroud ?? (error ? AppColor.grey : AppColor.primary));
}

showLoadingDialog({String? title}) {
  Get.dialog(
    Stack(
      children: [
        Material(
          color: AppColor.black.withOpacity(.6),
          child: Center(
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.white),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: 25,
                      height: 25,
                      child: custumLoader(
                        size: 30.0,
                      )),
                  Expanded(
                      child: Text(
                    title ?? 'En cours...',
                    style: textBodyStyle(
                        fontWeight: FontWeight.w700, color: AppColor.black),
                  ))
                ],
              ),
            ),
          ),
        ),
        const Positioned(
            top: 10,
            right: 20,
            child: IconButton(
                onPressed: closeDialog,
                icon: Icon(Icons.close, color: AppColor.white)))
      ],
    ),
    barrierDismissible: false,
  );
}

void closeDialog<T>() {
  if (Get.isDialogOpen!) Get.close(0);
  removeKeyboardFocus();
}

printIfDebug(value) {
  if (kDebugMode) {
    print('$value');
  }
}

logIfDebug(value) {
  if (kDebugMode) {
    log('$value');
  }
}

showCustumBottomSheet({
  String title = "Filter par :",
  Color? titleColor,
  bool centerTitle = false,
  double? height,
  bool showValidateButton = true,
  String buttonText = "Valider",
  required Widget child,
  VoidCallback? callback,
}) {
  Get.bottomSheet(
      Material(
        color: AppColor.transparent,
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Expanded(
                  child: actionButton(
                onTap: back,
                child: Container(
                  width: Get.width,
                  color: AppColor.transparent,
                ),
              )),
              Container(
                padding: horizontalPagePadding,
                height: height,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    space(5),
                    actionButton(
                      onTap: back,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),
                    space(5),
                    if (title.isNotEmpty)
                      Row(
                        mainAxisAlignment: centerTitle
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          Text(title,
                              style: titleStyle(
                                  color: titleColor,
                                  size: 14,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    if (title.isNotEmpty) space(24),
                    child,
                    space(10),
                    if (showValidateButton)
                      primaryButton(
                          text: buttonText,
                          onTap: () {
                            removeKeyboardFocus();
                            callback?.call();
                          }),
                    space(25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true);
}

showCustumDialog({
  required Widget child,
  String title = "Alerte",
  String description = "description",
  VoidCallback? validateCalback,
  VoidCallback? cancelCallback,
  bool showCancelButton = true,
  String? icon,
  bool errorDialog = false,
  Color? errorColor = AppColor.red,
  String cancelText = "Annuler",
  String validateText = "Confirmer",
}) {
  Get.dialog(
    GestureDetector(
      onTap: cancelCallback ?? back,
      child: Material(
        color: const Color.fromRGBO(239, 239, 239, 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: pagePading),
                  padding: EdgeInsets.all(30),
                  width: Get.width,
                  decoration: deco.copyWith(color: AppColor.white),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: titleBodyStyle(
                              color: errorDialog ? errorColor : null),
                        ),
                        space(20),
                        if (icon != null)
                          Container(
                              margin: EdgeInsets.only(bottom: 30),
                              height: 100,
                              width: 100,
                              child: Image.asset(icon)),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: textBodyStyle(),
                        ),
                        if (description.isNotEmpty) space(40),
                        child,
                        Row(
                          children: [
                            if (showCancelButton)
                              Expanded(
                                  child: primaryButton(
                                      text: cancelText,
                                      primary: errorDialog,
                                      onTap: cancelCallback ?? back)),
                            if (showCancelButton) space(0, w: 10),
                            Expanded(
                                child: primaryButton(
                                    primary: !errorDialog,
                                    borderColor:
                                        errorDialog ? errorColor : null,
                                    text: validateText,
                                    textColor: errorDialog ? errorColor : null,
                                    onTap: validateCalback)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 35,
                    child: Container(
                        decoration: deco.copyWith(
                            color: AppColor.primary.withOpacity(.1)),
                        child: IconButton(
                            onPressed: cancelCallback ?? closeDialog,
                            icon: Icon(
                              Icons.close,
                              color: AppColor.primary,
                            ))))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

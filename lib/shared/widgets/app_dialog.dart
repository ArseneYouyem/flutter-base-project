import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/config/constant_colors.dart';
import '../../core/config/style.dart';
import '../../core/helper/util.dart';
import '../../core/navigation/navigation.dart';
import 'core_widget_const.dart';
import 'forms/buttons.dart';

class AppDialog {
  static void closeDialog<T>() {
    if (Get.isDialogOpen!) Get.close(0);
    removeKeyboardFocus();
  }

  static showCustumDialog({
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
                                      textColor:
                                          errorDialog ? errorColor : null,
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

  static showLoadingDialog({String? title}) {
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

  showBackgroundBlurDialog({
    String? title,
    Widget? warningIcon,
    String? description,
    Widget? child,
    bool dismissible = true,
    bool showButons = false,
    bool warning = false,
    String validateText = "Confirmer",
    String cancelText = "Annuler",
    VoidCallback? validateCallback,
    VoidCallback? cancelCallback,
  }) {
    Get.dialog(
      Material(
        color: AppColor.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Column(
            children: [
              Expanded(
                  child: actionButton(
                onTap: dismissible ? back : null,
                child: Container(
                  width: Get.width,
                ),
              )),
              Container(
                width: Get.width,
                margin: horizontalPagePadding,
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(32)),
                child: Column(
                  children: [
                    space(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            decoration:
                                decoStatus.copyWith(color: AppColor.blue50),
                            child: IconButton(
                                onPressed: back, icon: Icon(Icons.close)))
                      ],
                    ),
                    if (title != null)
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: titleStyle(size: 24, color: AppColor.grey31),
                      ),
                    if (title != null) space(15),
                    if (warningIcon != null) warningIcon,
                    if (warningIcon != null) space(15),
                    if (description != null)
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: textBodyStyle(
                          size: 16,
                          color: AppColor.greyText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    if (description != null) space(15),
                    child ?? Container(),
                    if (showButons)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            if (cancelCallback != null)
                              Expanded(
                                  child: primaryButton(
                                text: cancelText,
                                onTap: () {
                                  back();
                                  cancelCallback.call();
                                },
                                primary: warning,
                                color: warning ? null : AppColor.grey249,
                                borderColor:
                                    warning ? null : AppColor.greyBorder,
                                textColor: warning ? null : AppColor.black,
                              )),
                            if (cancelCallback != null &&
                                validateCallback != null)
                              space(0, w: 10),
                            if (validateCallback != null)
                              Expanded(
                                  child: primaryButton(
                                text: validateText,
                                onTap: validateCallback,
                                primary: !warning,
                              )),
                          ],
                        ),
                      ),
                    space(32),
                  ],
                ),
              ),
              Expanded(
                  child: actionButton(
                onTap: dismissible ? back : null,
                child: Container(
                  width: Get.width,
                ),
              )),
            ],
          ),
        ),
      ),
      useSafeArea: false,
      barrierColor: Colors.black26,
      barrierDismissible: dismissible,
    );
  }
}

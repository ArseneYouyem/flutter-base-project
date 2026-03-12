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
}

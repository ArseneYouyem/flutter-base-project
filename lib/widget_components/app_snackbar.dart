import 'package:flutter/material.dart';
import '../config/constant_colors.dart';
import '../config/style.dart';
import '../navigation/navigation.dart';
import '../status_bottom_sheet.dart';
import 'core_widget_const.dart';
import 'custum_bottom_sheet.dart';
import 'forms/buttons.dart';

class AppSnackBar {
  static Future showSuccess({
    String title = "Confirmation",
    required String message,
    required BuildContext context,
    duration = const Duration(seconds: 6),
    VoidCallback? callback,
    String? buttonText,
  }) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatusBottomSheet(
        type: StatusType.success,
        title: title,
        message: message.replaceFirst('Exception: ', ''),
        buttonText: buttonText ?? 'Ok',
        onPressed: () {
          Navigator.of(context).pop();
          callback?.call();
          // Ajoutez d'autres actions ici si nécessaire
        },
      ),
    );
    // return AppSnackBar.showMessage(
    //   message: message,
    //   context: context,
    //   duration: duration,
    //   onClose: onClose,
    //   mode: ContentType.success,
    // );
  }

  static showBottomSheet({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => CustumBottomSheet(
        child: Container(
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }

  static showConfirmationBottomSheet({
    required BuildContext context,
    required String title,
    required String message,
    String? validateText,
    String? cancelText,
    VoidCallback? validateCallBack,
    bool error = false,
  }) {
    showBottomSheet(
        context: context,
        child: Column(
          children: [
            Text(
              title,
              style:
                  titleBodyStyle(size: 22, color: error ? AppColor.red : null),
            ),
            space(30),
            Text(message),
            space(30),
            Row(
              children: [
                Expanded(
                  child: primaryButton(
                    text: cancelText ?? "Non Annuler",
                    primary: false,
                    onTap: () {
                      back();
                    },
                  ),
                ),
                space(0, w: 10),
                Expanded(
                  child: primaryButton(
                    text: validateText ?? "Oui, Confirmer",
                    onTap: validateCallBack,
                    color: error ? AppColor.red : null,
                  ),
                ),
              ],
            )
          ],
        ));
  }

  static Future showError({
    String title = "Erreur",
    required String message,
    required BuildContext context,
    duration = const Duration(seconds: 6),
    VoidCallback? onClose,
    String? buttonText,
    VoidCallback? callBack,
  }) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatusBottomSheet(
        type: StatusType.error,
        title: title,
        message: message.replaceFirst('Exception: ', ''),
        buttonText: buttonText ?? 'Ok',
        onPressed: () {
          Navigator.of(context).pop();
          callBack?.call();
          // Ajoutez d'autres actions ici si nécessaire
        },
      ),
    );
  }
}

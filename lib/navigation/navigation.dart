import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/type.dart';

void back<T>() {
  // Get.back();
  Get.close(0);
}

void backWithValue<T>(value) {
  Get.back(result: value);
}

Future<T?>? goTo<T>(dynamic page,
    {arguments, Transition? transition = Transition.rightToLeft}) {
  return Get.to(page, arguments: arguments, transition: transition);
}

Future<T?>? goOffTo<T>(dynamic page, {arguments}) {
  return Get.off(page, arguments: arguments);
}

Future<T?>? goOffAllTo<T>(dynamic page, {arguments}) {
  return Get.offAll(page, arguments: arguments);
}

Future<T?>? goToNamed<T>(String page, {JsonStringType? parameters, arguments}) {
  try {
    return Get.toNamed(
      page,
      arguments: arguments,
      parameters: parameters,
    );
  } on Exception catch (e) {
    Get.defaultDialog(title: e.toString());
  }
  return null;
}

Future<T?>? goOffNamed<T>(String page,
    {JsonStringType? parameters, arguments}) {
  return Get.offNamed(page, arguments: arguments, parameters: parameters);
}

Future<T?>? goOffAllNamed<T>(String newRouteName,
    {JsonStringType? parameters, arguments}) {
  return Get.offAllNamed(newRouteName,
      arguments: arguments, parameters: parameters);
}

navitateUpCurrentPage(Widget child) {
  Navigator.of(Get.context!).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (ct, _, __) {
        return child;
      }));
}

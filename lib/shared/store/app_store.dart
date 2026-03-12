import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

mixin AppStore {
  //
  bool get isIos => defaultTargetPlatform == TargetPlatform.iOS;
  bool get deviceIsTablette => Get.width > 600;

  VoidCallback? restartApp;
}

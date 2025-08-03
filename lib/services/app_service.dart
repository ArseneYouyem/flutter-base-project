import 'dart:io';
import 'package:get/get.dart';
import 'storage_services.dart';
import '../store/state_controller.dart';
import '../store/user_controller.dart';

class AppService {
  static _initService() async {
    HttpOverrides.global = MyHttpOverrides();
    await Get.putAsync(() => StorageService().init());
  }

  static _initController() async {
    Get.put(StateController(), permanent: true);
    Get.put(UserController(), permanent: true);
  }

  static initServices() async {
    await _initService();
    await _initController();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

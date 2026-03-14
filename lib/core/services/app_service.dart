import 'dart:io';
import 'package:flutterbasestructure/core/services/secure_storage_service.dart';
import 'package:flutterbasestructure/shared/network/dio/cache_loger_interceptor_controller.dart';
import 'package:get/get.dart';
import 'storage_services.dart';
import '../../shared/store/state_controller.dart';
import '../../features/application/controllers/user_controller.dart';

class AppService {
  static _initService() async {
    HttpOverrides.global = MyHttpOverrides();
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync(() => SecureStorageService().init());
  }

  static _initController() async {
    Get.put(StateController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(CacheLogerInterceptorController(), permanent: true);
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

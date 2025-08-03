import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import '../../config/storage_key.dart';
import '../../services/storage_services.dart';
import '../all_routes.dart';

class FirstInitRouteMiddleware extends GetMiddleware {
  StorageService storage = Get.find();
  FirstInitRouteMiddleware({int? priority}) : super(priority: priority);

  @override
  RouteSettings? redirect(String? route) {
    final appIsInit = storage.find(StorageKey.appIsInit) ?? false;
    if (!appIsInit) {
      return RouteSettings(name: Routes.started.splash);
    }
    return null;
  }
}

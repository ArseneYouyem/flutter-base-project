import 'package:get/get.dart';
import '../../../core/config/storage_key.dart';
import '../../../core/helper/parser.dart';
import '../../../core/services/storage_services.dart';
import 'cache_loger_interceptor.dart';

class CacheLogerInterceptorController extends GetxController {
  static CacheLogerInterceptorController get instance => Get.find();

  final httpLogs = <HttpLog>[].obs;
  final enableLogin = false.obs;

  StorageService storage = Get.find();
  bool get debugEnable => true;

  updateLogs(List<HttpLog> logs) {
    httpLogs.assignAll(logs);
  }

  clearHttpLogs() {
    httpLogs.clear();
    storage.remove(StorageKey.debugLog);
  }

  String lowerCaseData(dynamic data) => "$data".toLowerCase();

  searchHttpLog(String key) {
    final currentData = storage.find(StorageKey.debugLog);
    final currentList = currentData == null
        ? <HttpLog>[]
        : fromJsonList(parseMap(currentData), HttpLog.fromJson);
    httpLogs.assignAll(currentList.where((log) =>
            lowerCaseData(log.url).contains(lowerCaseData(key)) ||
            lowerCaseData(log.method).contains(lowerCaseData(key)) ||
            lowerCaseData(log.requestBody).contains(lowerCaseData(key)) ||
            lowerCaseData(log.responseBody).contains(lowerCaseData(key))
        // lowerCaseData(log.headers).contains(lowerCaseData(key)) ||
        // lowerCaseData(log.statusCode).contains(lowerCaseData(key)),
        ));
    httpLogs.sort((a, b) => b.date.compareTo(a.date));
  }
}

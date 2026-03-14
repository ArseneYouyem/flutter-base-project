import 'package:dio/dio.dart';
import 'package:flutterbasestructure/shared/network/api_path.dart';
import 'package:get/get.dart';
import 'cache_interceptor.dart';
import 'cache_loger_interceptor.dart';
import 'http_logger_interceptor.dart';
import 'token_interceptor.dart';

enum ExtraKey {
  cache,
  skipToken,
}

void setupLocator() {
  Get.lazyPut<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiPaths.baseUrl,
        connectTimeout:
            const Duration(seconds: 180), // Timeout pour établir la connexion
        receiveTimeout:
            const Duration(seconds: 90), // Timeout pour recevoir la réponse
        sendTimeout: const Duration(seconds: 90),
        extra: {ExtraKey.cache.name: false},
      ),
    )..interceptors.addAll([
        TokenInterceptor(),
        CacheInterceptor(),
        HttpLoggerInterceptor(),
        CacheLogerInterceptor(),
      ]),
  );
}

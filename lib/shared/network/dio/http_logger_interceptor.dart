import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var applogger = Logger(
  printer: PrettyPrinter(colors: true),
);

class HttpLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      try {
        applogger.d({
          "base_url": options.baseUrl,
          "url": options.path,
          "method": options.method,
          "params": options.queryParameters,
          "body": options.data,
          'headers': options.headers.toString(),
        });
      } catch (e) {}
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, handler) {
    if (kDebugMode) {
      try {
        applogger.e({
          "base_url": err.requestOptions.baseUrl,
          "path": err.requestOptions.path,
          "method": err.requestOptions.method,
          "data": err.requestOptions.data,
          "params": err.requestOptions.queryParameters,
          //  "message": extractMessage(err),
          "original": err.message,
          'headers': err.requestOptions.headers.toString(),
        });
      } catch (e) {}
    }
    return handler.next(err);
  }
}

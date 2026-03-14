import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutterbasestructure/core/helper/outputs.dart';
import 'package:get/get.dart' as get_x;
import '../../../core/config/storage_key.dart';
import '../../../core/helper/parser.dart';
import '../../../core/services/storage_services.dart';
import 'cache_loger_interceptor_controller.dart';

class CacheLogerInterceptor extends Interceptor {
  StorageService storage = get_x.Get.find();
  bool get debugEnable => true;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logIfDebug("............Saving.........");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, handler) {
    logIfDebug("............Saving.........");
    saveRequestResult(
      response: response,
      replace: true,
    );
    return handler.next(response);
  }

  // @override
  // void onError(DioException err, handler) {
  //   if (kDebugMode) {
  //     try {
  //       saveRequestResult(
  //         response: response,
  //         replace: true,
  //       );
  //     } catch (e) {}
  //   }
  //   return handler.next(err);
  // }

  Future<void> saveRequestResult(
      {Response? response, HttpLog? httpLog, bool replace = false}) async {
    if (debugEnable &&
        CacheLogerInterceptorController.instance.enableLogin.value &&
        (response?.requestOptions.uri.path ?? httpLog?.url ?? "").isNotEmpty) {
      logIfDebug("............Saving.........");

      final currentData = storage.find(StorageKey.debugLog);
      final currentList = currentData == null
          ? <HttpLog>[]
          : fromJsonList(parseMap(currentData), HttpLog.fromJson);
      if (replace) {
        currentList.removeWhere((e) =>
            e.url ==
            (httpLog?.url ?? response?.requestOptions.uri.toString() ?? ""));
      }

      currentList.add(httpLog ??
          HttpLog(
            date: DateTime.now().toIso8601String(),
            url: response?.requestOptions.uri.toString() ?? "",
            method: response?.requestOptions.method,
            requestBody: response?.requestOptions.data,
            headers: response?.requestOptions.headers,
            statusCode: response?.statusCode,
            responseBody: response?.data,
          ));
// HttpLog
      currentList.sort((a, b) => b.date.compareTo(a.date));
      storage.save(StorageKey.debugLog,
          toJsonList(currentList, (data) => data.toJson()));
      CacheLogerInterceptorController.instance.updateLogs(currentList);
    }
  }
}

class HttpLog {
  String date;
  String url;
  String? method;
  dynamic requestBody;
  Map<String, dynamic>? headers;
  dynamic statusCode;
  dynamic responseBody;

  bool get isOk => "$statusCode".startsWith("2");

  List<Map<String, dynamic>> getResponse() {
    // Si responseBody est null, retourner une liste vide
    if (responseBody == null) {
      return [];
    }

    // Si responseBody est un String, essayer de le parser en JSON
    if (responseBody is String) {
      try {
        // Essayer de parser le JSON
        final parsedData = jsonDecode(responseBody as String);
        return _processParsedData(parsedData);
      } catch (e) {
        // Si le parsing échoue, traiter comme une string simple
        return [
          {"data": responseBody}
        ];
      }
    }

    // Traiter les autres types de données
    return _processParsedData(responseBody);
  }

  List<Map<String, dynamic>> _processParsedData(dynamic data) {
    // Si data est déjà une liste, la retourner directement
    if (data is List) {
      return List<Map<String, dynamic>>.from(data);
    }

    // Si data est un Map
    if (data is Map<String, dynamic>) {
      final responseMap = data;

      // Vérifier si c'est une réponse paginée avec ["data"]["data"]
      if (responseMap.containsKey("data") &&
          responseMap["data"] is Map<String, dynamic> &&
          (responseMap["data"] as Map<String, dynamic>).containsKey("data") &&
          (responseMap["data"] as Map<String, dynamic>)["data"] is List) {
        final paginatedDataList =
            (responseMap["data"] as Map<String, dynamic>)["data"] as List;

        // Si la liste paginée contient des strings, les convertir en Maps avec la clé "data"
        if (paginatedDataList.isNotEmpty && paginatedDataList.first is String) {
          return paginatedDataList
              .map((item) => {"data": item})
              .toList()
              .cast<Map<String, dynamic>>();
        }

        // Sinon, retourner la liste directement (elle contient déjà des Maps)
        return List<Map<String, dynamic>>.from(paginatedDataList);
      }

      // Vérifier si la clé "data" contient une liste
      if (responseMap.containsKey("data") && responseMap["data"] is List) {
        final dataList = responseMap["data"] as List;

        // Si la liste contient des strings, les convertir en Maps avec la clé "data"
        if (dataList.isNotEmpty && dataList.first is String) {
          return dataList
              .map((item) => {"data": item})
              .toList()
              .cast<Map<String, dynamic>>();
        }

        // Sinon, retourner la liste directement (elle contient déjà des Maps)
        return List<Map<String, dynamic>>.from(dataList);
      }

      // Sinon, retourner l'objet dans une liste
      return [responseMap];
    }

    // Pour tout autre type, retourner une liste vide
    return [];
  }

  HttpLog({
    this.date = "",
    this.url = "",
    this.method,
    this.requestBody,
    this.headers,
    this.statusCode,
    this.responseBody,
  });

  factory HttpLog.fromJson(Map<String, dynamic> json) => HttpLog(
        date: json["date"],
        url: json["url"],
        method: json["method"],
        requestBody: json["requestBody"],
        headers: json["headers"] == null
            ? null
            : Map<String, String>.from(json["headers"]),
        statusCode: json["statusCode"],
        responseBody: json["responseBody"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "url": url,
        "method": method,
        "requestBody": requestBody,
        "headers": headers,
        "statusCode": statusCode,
        "responseBody": responseBody,
      };
}

// core/network/cache_interceptor.dart
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutterbasestructure/core/helper/parser.dart';
import 'package:get/get.dart' as getx;
import '../../../core/config/storage_key.dart';
import '../../../core/config/type.dart';
import '../../../core/services/storage_services.dart';

class CacheInterceptor extends Interceptor {
  final StorageService _storage = getx.Get.find();
  final Duration defaultTtl;

  CacheInterceptor({this.defaultTtl = const Duration(minutes: 5)});

  String _cacheKey(RequestOptions options) => 'cache_GET_${options.uri}';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // // Ne cache que les GET
    // if (options.method != 'GET') return handler.next(options);

    // // Permet de forcer le refresh via un extra
    // if (options.extra['forceRefresh'] == true) return handler.next(options);

    // final key = _cacheKey(options);
    // final cached = _storage.find(key);

    // if (cached != null) {
    //   final cachedAt = DateTime.parse(cached['cachedAt'] as String);
    //   final ttl = Duration(seconds: cached['ttlSeconds'] as int);

    //   if (DateTime.now().difference(cachedAt) < ttl) {
    //     // Cache valide → retourne sans appel réseau
    //     return handler.resolve(
    //       Response(
    //         requestOptions: options,
    //         data: jsonDecode(cached['data'] as String),
    //         statusCode: 200,
    //         extra: {'fromCache': true},
    //       ),
    //       true,
    //     );
    //   }
    // }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method != 'GET') return handler.next(response);
    if (response.requestOptions.extra['cache'] == true) {
      final key = _cacheKey(response.requestOptions);
      final ttl =
          response.requestOptions.extra['cacheTtl'] as Duration? ?? defaultTtl;

      // Stocke la réponse
      _storage.save(key, {
        'data': jsonEncode(response.data),
        'cachedAt': DateTime.now().toIso8601String(),
        'ttlSeconds': ttl.inSeconds,
      });
    }
    handler.next(response);
  }

  /// Invalider le cache d'une URL précise
  void invalidate(String method, Uri uri) {
    final fakeOptions = RequestOptions(path: uri.toString(), method: method);
    _storage.remove(_cacheKey(fakeOptions));
  }

  /// Vider tout le cache
  void clearAll() {
    _storage.ressetDirectory();
  }

  static handleCachedData<T>(
    String url,
    StreamController<T> controller,
    ParamsCallback<T, JsonType> fromJson,
  ) {
    final StorageService storage = getx.Get.find();
    final cached = storage.find(StorageKey.cacheKey(Uri.parse(url)));
    if (cached != null) {
      controller.add(fromJson(jsonDecode(cached['data'] as String)));
    }
  }
}

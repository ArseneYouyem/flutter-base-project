import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterbasestructure/core/config/storage_key.dart';
import 'package:flutterbasestructure/core/services/secure_storage_service.dart';
import 'package:flutterbasestructure/shared/network/repositories/auth/auth_repository.dart';
import 'package:get/get.dart' as get_x;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../core/helper/outputs.dart';
import 'service_locator.dart';

class TokenInterceptor extends QueuedInterceptor {
  final SecureStorageService _storage = get_x.Get.find();

  bool _refreshingToken = false;

  jwtIsexpire(String token) {
    DateTime expirationDate = JwtDecoder.getExpirationDate(token)
        .subtract(const Duration(seconds: 20));
    logIfDebug(
        "=====================>check expiration token $expirationDate <==================");
    return DateTime.now().isAfter(expirationDate);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Accept"] = 'application/json';
    var authToken = await _storage.find(StorageKey.token);

    if (authToken != null && options.extra[ExtraKey.skipToken.name] == null) {
      await handleAuth(options, authToken);
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      FlutterSecureStorage secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      );
      await secureStorage.delete(key: StorageKey.user);
      await secureStorage.delete(key: StorageKey.token);
      logIfDebug("Ton token a expiré mon bro");
    }
    return handler.next(err);
  }

  handleAuth(RequestOptions options, String authToken) async {
    if (!jwtIsexpire(authToken)) {
      options.headers["Authorization"] = 'Bearer $authToken';
    } else if (_refreshingToken) {
      logIfDebug(".........Awaiting regresh token : ${options.uri}.........");
      await Future.delayed(Duration(seconds: 1));
      return handleAuth(options, authToken);
    } else {
      _refreshingToken = true;
      //try to refresh token
      var refreshToken = await _storage.find(StorageKey.refreshToken);
      if (refreshToken != null) {
        final repo = get_x.Get.put(AuthRepository());
        try {
          final result = await repo.refreshToken(refreshToken);
          final newToken = result["token"];
          final newRefreshToken = result["newRefreshToken"];
          _storage.save(StorageKey.token, newToken);
          _storage.save(StorageKey.refreshToken, newRefreshToken);
          options.headers["Authorization"] = 'Bearer $newToken';
        } on Exception catch (e) {
          logIfDebug("$e");
          // TODO annalyse du type d'exeption et déconnexion de l'utilisateur si le refreshToken a expiré
        }
      }
    }
  }
}

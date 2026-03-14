import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutterbasestructure/features/application/models/user_model.dart';
import 'package:flutterbasestructure/shared/network/api_path.dart';
import 'package:flutterbasestructure/shared/network/dio/error_interceptor.dart';
import 'package:get/get.dart';
import '../../dio/cache_interceptor.dart';

class UserRepository {
  final http = Get.find<Dio>();

  Future<User> getUserData() async {
    try {
      final response = await http.get(ApiPaths.userData);
      return User.fromJson(response.data['data']);
    } catch (e) {
      throw Exception(ErrorInterceptor.parseExecption(e as Exception));
    }
  }
  /// Stream pour a mise en cache
  Stream<User> getUserStream() {
    final controller = StreamController<User>();
    try {
      final url = ApiPaths.userData;
      CacheInterceptor.handleCachedData(url, controller, User.fromJson);
      http
          .get(ApiPaths.userData, options: Options(extra: {"cache": true}))
          .then((response) {
        User.fromJson(response.data['data']);
        final updatedUser = User.fromJson(response.data['data']);
        controller.add(updatedUser);
      });
    } catch (e) {
      controller
          .addError(Exception(ErrorInterceptor.parseExecption(e as Exception)));
    }
    return controller.stream;
  }
}

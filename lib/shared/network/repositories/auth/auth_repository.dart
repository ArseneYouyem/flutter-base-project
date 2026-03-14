import 'package:dio/dio.dart';
import 'package:flutterbasestructure/shared/network/api_path.dart';
import 'package:flutterbasestructure/shared/network/dio/error_interceptor.dart';
import 'package:get/get.dart';
import '../../../../features/application/models/user_model.dart';
import '../../dio/service_locator.dart';

class AuthRepository {
  final http = Get.find<Dio>();

  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        ApiPaths.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return User.fromJson(response.data);
    } on Exception catch (e) {
      throw Exception(ErrorInterceptor.parseExecption(e));
    }
  }

  Future<dynamic> refreshToken(refreshToken) async {
    try {
      final response = await http.post(ApiPaths.refreshToken,
          data: {
            'refreshToken': "refreshToken",
          },
          options: Options(
            extra: {ExtraKey.skipToken.name: true},
          ));
      return response.data['data'];
    } catch (e) {
      throw Exception(ErrorInterceptor.parseExecption(e as Exception));
    }
  }
}

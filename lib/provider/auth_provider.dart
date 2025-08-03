import 'package:get/get.dart';
import '../config/api_key.dart';
import '../helper/outputs.dart';
import '../store/user_controller.dart';
import '_config/status_code.dart';

class AuthProvider extends GetConnect {
  final userCtrl = UserController.instance;

  ///////register

  Future<dynamic> refreshToken({required String refresh}) async {
    final userCtrl = UserController.instance;
    printIfDebug('refresh_token processing... $refresh');
    final result =
        await post(ApiPaths.refreshToken, {"refresh_token": refresh});
    logIfDebug('refresh_token response  ${result.body}');
    bool succes =
        result.statusCode == 200 && result.body["code"] == StatusCode.SUCCESS;
    if (succes) {
      userCtrl.token = result.body["data"]["token"];
      userCtrl.refreshToken = result.body["data"]["refresh_token"];
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return succes
        ? result.body
        : result.statusCode == 200 &&
                (result.body["code"] == StatusCode.NOT_AUTHORIZED ||
                    result.body["code"] == StatusCode.NOT_FOUND)
            ? "expiredRefreshToken"
            : null;
  }
}

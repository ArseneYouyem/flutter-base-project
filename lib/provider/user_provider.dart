import 'package:get/get.dart';

import '../config/api_key.dart';
import '../store/state_controller.dart';
import '../store/user_controller.dart';
import '_config/core_provider.dart';
import '_config/get_connect.dart';

class UserProvider extends ApiProvider with CoreProvider {
  final userCtrl = UserController.instance;
  final store = StateController.instance;

  @override
  bool onDecoder = true;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> logOut(refreshToken) async {
    final response =
        await post(ApiPaths.logOut, {"refresh_token": "$refreshToken"});
    print(refreshToken);
    // print(userCtrl.headerAuth);
    bool status = await handleResponse(response);
    return status;
  }

//exemple d'utilisation de la fonction getData  avec prise en compte du cache
  Future<dynamic> useExemple({
    Function(dynamic)? onDataUpdated,
  }) async {
    enebleCach = true;
    final response = await getData("path/to/api",
        onDataUpdated: (Response<dynamic> newResponse) {
      if (onDataUpdated != null) {
        onDataUpdated(newResponse.body);
      }
    });
    bool status = await handleResponse(response);
    if (status) {
      return response.body;
    }
    return null;
  }
}

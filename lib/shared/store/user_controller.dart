import 'package:get/get.dart';
import '../../core/helper/outputs.dart';
import '../../features/application/models/location_model.dart';
import 'state_controller.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final store = StateController.instance;

  LocationModel? currentLocation;

  String token = "";
  String refreshToken = "";

  bool get isAuth => token.isNotEmpty;

  // final currentUser = User().obs;

  logIdentifiers() {
    logIfDebug("--------------------------------------");
    printIfDebug("token : $token");
    printIfDebug("--------------------------------------");
  }

  @override
  void onInit() {
    super.onInit();
  }

  logOut() {
    logIfDebug("-----------------LOGOUT---------------------");
    token = "";
    refreshToken = "";
  }
}

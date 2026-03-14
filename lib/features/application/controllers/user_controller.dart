import 'package:flutterbasestructure/shared/network/repositories/auth/user_repository.dart';
import 'package:get/get.dart';
import '../../../core/helper/outputs.dart';
import '../models/user_model.dart';
import '../models/location_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final currentUser = User().obs;

  LocationModel? currentLocation;

  @override
  void onInit() {
    super.onInit();
  }

  getUserStream() {
    final repo = Get.put(UserRepository());
    currentUser.bindStream(repo.getUserStream().handleError((e) {
      logIfDebug("$e");
    }).map((data) {
      // loading.value = false;
      return data;
    }));
  }
}

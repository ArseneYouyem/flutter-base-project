import 'package:get/get.dart';
import 'app_store.dart';

class StateController extends GetxController with AppStore {
  static StateController get instance => Get.find();
}

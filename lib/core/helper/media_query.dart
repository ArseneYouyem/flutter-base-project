import 'package:get/get.dart';

class MediaSize {
  static final yLarge = Get.height >= 800;
  static final yMedium = Get.height > 700 && Get.height < 800;
  static final ySmall = Get.height < 700;

  static final xLarge = Get.width >= 425;
  static final xMedium = Get.width < 425 && Get.width >= 400;
  static final xSmall = Get.width < 400;

  static final getMediaSize =
      "${yLarge ? "yLarge" : yMedium ? "yMedium" : "ySmall"} - ${xLarge ? "xLarge" : xMedium ? "xMedium" : "xSmall"}";
}

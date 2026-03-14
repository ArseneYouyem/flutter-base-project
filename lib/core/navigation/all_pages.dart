import 'package:get/get.dart';
import 'all_routes.dart';
import 'pages/started_pages.dart';
import 'pages/vitrine_pages.dart';

class AppPages {
  static var initial = Routes.started.splash;

  static final List<GetPage> pages = [
    ...startedPages,
    ...vitrinePages,
  ];
}

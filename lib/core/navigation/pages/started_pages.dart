import 'package:flutterbasestructure/core/navigation/all_routes.dart';
import 'package:flutterbasestructure/features/onboarding/views/started_view.dart';
import 'package:get/get.dart';

List<GetPage> startedPages = [
  // GetPage(
  //   name: Routes.started.login,
  //   page: () => LoginView(),
  // ),
  GetPage(
    name: Routes.started.splash,
    page: () => StartedView(),
  ),
];

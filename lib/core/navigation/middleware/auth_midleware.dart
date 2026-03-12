// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/routes/route_middleware.dart';
// import '../../store/user_controller.dart';
// import '../all_routes.dart';

// class AuthMiddleware extends GetMiddleware {
//   final userCtrl = UserController.instance;
//   AuthMiddleware({int? priority}) : super(priority: priority);

//   @override
//   RouteSettings? redirect(String? route) {
//     if (!userCtrl.isAuth) {
//       return RouteSettings(name: Routes.started.login);
//     }
//     return null;
//   }
// }

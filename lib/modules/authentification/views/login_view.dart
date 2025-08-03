import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../authentification/controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final ctrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(
          top: kToolbarHeight,
          left: 24,
          bottom: 24,
          right: 24,
        ),
        child: Column(
          children: [
            Text('Login'),
          ],
        ),
      ),
    );
  }
}

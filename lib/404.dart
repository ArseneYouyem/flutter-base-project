import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/constant_colors.dart';
import 'widget_components/core_widget_const.dart';

class UnknownRoutePage extends StatelessWidget {
  final argument = Get.arguments;
  UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Ce lien n'est pas valide!",
              textAlign: TextAlign.center,
              // textScaleFactor: 3.0,
            ),
            space(50),
          ],
        ),
      ),
    );
  }
}

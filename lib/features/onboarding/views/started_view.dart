import 'package:flutter/material.dart';
import 'package:flutterbasestructure/shared/widgets/forms/buttons.dart';
import 'package:get/get.dart';
import '../../../core/helper/util.dart';
import '../../../core/navigation/navigation.dart';
import '../../../shared/widgets/core_widget_const.dart';
import 'login_view.dart';

class StartedView extends StatefulWidget {
  const StartedView({super.key});

  @override
  State<StartedView> createState() => _StartedViewState();
}

class _StartedViewState extends State<StartedView> {
  @override
  void initState() {
    super.initState();
    initBinding(() {
      checkAuth();
    });
  }

  checkAuth() async {
    // await Future.delayed(Duration(seconds: 2));
    // goOffTo(() => LoginView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: horizontalPagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            space(0, w: Get.width),
            FlutterLogo(size: 150),
            space(30),
            Text("Arsene YOUYEM flutter base project"),
            space(30),
            // custumLoader(),
            primaryButton(
              text: "Login",
              onTap: () {
                goTo(() => LoginView());
              },
            ),
          ],
        ),
      ),
    );
  }
}

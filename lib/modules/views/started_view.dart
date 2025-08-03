import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/util.dart';
import '../../widget_components/core_widget_const.dart';

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
    // await userCtrl.getUserData();
    // if (userCtrl.isAuth &&
    //     (!userCtrl.userInfo().isPatient ||
    //         (userCtrl.userInfo().isPatient && userCtrl.patient().id != null))) {
    //   goOffTo(() => HomePage());
    // } else if (userCtrl.isAuth && userCtrl.patient().id == null) {
    //   await Future.delayed(const Duration(seconds: 1));
    //   checkAuth();
    // } else {
    //   goOffTo(() => LoginView());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [space(0, w: Get.width), custumLoader()],
      ),
    );
  }
}

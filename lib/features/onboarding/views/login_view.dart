import 'package:flutter/material.dart';
import 'package:flutterbasestructure/core/helper/regex.dart';
import 'package:flutterbasestructure/core/navigation/navigation.dart';
import 'package:flutterbasestructure/shared/widgets/app_toast.dart';
import 'package:flutterbasestructure/shared/widgets/core_widget_const.dart';
import 'package:flutterbasestructure/shared/widgets/forms/buttons.dart';
import 'package:flutterbasestructure/shared/widgets/forms/input.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final ctrl = Get.put(AuthController());

  final editEmail = TextEditingController();
  final editPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: horizontalPagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 150,
            ),
            space(30),
            inputForm(
              hintText: "Adresse email",
              controller: editEmail,
            ),
            space(16),
            inputForm(
              hintText: "Mot de passe",
              controller: editPassword,
            ),
            space(30),
            primaryButton(
                text: "Se connecter",
                primary: false,
                onTap: () {
                  ctrl.login(editEmail.text, editPassword.text);
                  // if (!RegexValidator.isEmail(editEmail.text)) {
                  //   AppToast.showToast(
                  //       "Veuillez saisir une adresse email valide");
                  // } else if (editPassword.text.isEmpty) {
                  //   AppToast.showToast("Veuillez saisir votre mot de passe");
                  // } else {
                  //   ctrl.login(editEmail.text, editPassword.text);
                  // }
                }),
            space(100),
          ],
        ),
      ),
    );
  }
}

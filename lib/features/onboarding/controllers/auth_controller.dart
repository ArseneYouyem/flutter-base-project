import 'package:flutter/widgets.dart';
import 'package:flutterbasestructure/core/helper/outputs.dart';
import 'package:flutterbasestructure/shared/network/repositories/auth/auth_repository.dart';
import 'package:flutterbasestructure/shared/widgets/app_dialog.dart';
import 'package:flutterbasestructure/shared/widgets/app_snackbar.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  login(String email, String password) async {
    // logIfDebug("value");
    try {
      final repo = Get.put(AuthRepository());
      AppDialog.showLoadingDialog(title: "Connexion");
      final result = await repo.login(email: email, password: password);
      AppDialog.closeDialog();
      AppSnackbar.showSnackBar("Connexion réuissi", "à Toi de jouer");
      logIfDebug(result.toJson());
    } on Exception catch (e) {
      AppDialog.closeDialog();
      AppSnackbar.showSnackBar("Oups!", "$e".split(": ").last, error: true);
      logIfDebug("$e");
    }
  }
}

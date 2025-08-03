// import 'package:firebase_analytics/firebase_analytics.dart';
import '../../helper/outputs.dart';
import '../../store/user_controller.dart';

enum fbEvent {
  navigation,

  //auth
  startLogin,
  loginVerifyOtpSucces,
  loginVerifyOtpFailed,
  loginFailed,
  loginWithBiometrie,
  loginWithBiometrieFailed,

  startRegister,
  registerVerifyOtpSucces,
  registerVerifyOtpFailed,
  registerFailed,

  ressentOtpSucces,
  ressentOtpFailed,

  startForgotPassword,
  forgotPasswordVerifyOtpSucces,
  forgotPasswordVerifyOtpFailed,
  passwordRessetFailed,
  passwordResset,

  contactCustumerServiceAtLoginScreen,
  logout,
  logoutFailed,

  deleteAccountFailed,
  deleteAccountSucces,

  ressetAccountFailed,
  ressetAccountSucces,

  //app
  startCreateVtcDriver,
  endCreateVtcDriver,

  startImportYangoAccount,
  endImportYangoAccount,

  startLinkYangoAccount,
  endLinkYangoAccount,

  startCreateVehicle,
  endCreateVehicle,

  serverError,

  contactCustumerServiceAtForSubscription,
}

class AnalyticsService {
  // static FirebaseAnalytics? analytics;
  static String? appInstanceId;
  static init() async {
    try {
      // analytics = FirebaseAnalytics.instance;
      // appInstanceId = await analytics?.appInstanceId;
      // logIfDebug("init firebase_analytics : ${appInstanceId}");
      // FirebaseAnalytics.instance.logEvent(
      //   name: "initFirebase",
      //   parameters: {
      //     "appInstanceId": appInstanceId ?? "-",
      //   },
      // );
    } on Exception catch (e) {
      // TODO
    }
  }

  // static logAuthStart({bool register = true}) {
  //   FirebaseAnalytics.instance.logEvent(
  //     name: register ? "start_register" : "start_login",
  //   );
  // }

  static logLogin() {
    try {
      // FirebaseAnalytics.instance.logLogin(loginMethod: "Phone");
    } on Exception catch (e) {
      // TODO
    }
  }

  static logRegister() {
    try {
      // FirebaseAnalytics.instance
      //     .logSignUp(signUpMethod: "Email_phone_password", parameters: {});
    } on Exception catch (e) {
      // TODO
    }
  }

  static navigation(String page) {
    logEvent(fbEvent.navigation, parameters: {
      "page": page,
    });
  }

  static logEvent(fbEvent event, {Map<String, Object>? parameters}) async {
    try {
      final userCtrl = UserController.instance;
      // await FirebaseAnalytics.instance.logEvent(
      //   name: event.name,
      //   parameters: {
      //     if (userCtrl.isAuth) ...{
      //       //information user
      //     },
      //     ...parameters ?? {}
      //   },
      // );
    } on Exception catch (e) {
      // TODO
    }
  }
}

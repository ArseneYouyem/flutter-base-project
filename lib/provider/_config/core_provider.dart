import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../config/api_key.dart';
import '../../config/type.dart';
import '../../helper/outputs.dart';
import '../../services/analitics/analytics_service.dart';
import '../../store/user_controller.dart';
import '../auth_provider.dart';
import 'status_code.dart';

mixin CoreProvider on GetConnect {
  //
  bool enebleRefreshUser = true;
  bool onDecoder = false;
  final int delay = 10;

  static bool refrechUserIsLaunch = false;

  decoder(value) {}

  @override
  void onInit() {
    logIfDebug("----------init CoreProvider provider ------------");
    if (onDecoder) {
      // httpClient.defaultDecoder = (value) {
      //   return decoder(value.runtimeType == String ? jsonDecode(value) : value);
      // };
    }
    refrechUserIsLaunch = false;
    httpClient.addRequestModifier<dynamic>((dynamic request) async {
      return addAuth(request);
    });
    httpClient.timeout = const Duration(seconds: 120);
  }

  @override
  onClose() {
    refrechUserIsLaunch = false;
  }

  jwtIsexpire(String token) {
    final expirationDate = JwtDecoder.getExpirationDate(token);
    expirationDate.subtract(Duration(seconds: delay));
    return DateTime.now().isAfter(expirationDate);
  }

  FutureOr<Request<dynamic>> addAuth(dynamic request) async {
    final userCtrl = UserController.instance;
    // printIfDebug("Method : ${request.method}");
    if (request.method == 'patch') {
      request.headers['Content-Type'] = "application/merge-patch+json";
    } else {
      request.headers['Content-Type'] = "application/json";
    }
    request.headers['Accept'] = "application/json";

    if (userCtrl.token.isNotEmpty && enebleRefreshUser) {
      // printIfDebug("-----user token ${userCtrl.currentUser().token}");
      if (jwtIsexpire(userCtrl.token)) {
        printIfDebug("-----token has expired----------");
        refrechUserIsLaunch = true;
        final provider = Get.put(AuthProvider());
        final result = await provider.refreshToken(
          refresh: userCtrl.refreshToken,
        );
        if (result == "expiredRefreshToken") {
          // refrechUserIsLaunch = false;
          UserController.instance.logOut();
        } else if (result != null) {
          refrechUserIsLaunch = false;
          request.headers['Authorization'] = userCtrl.token;
          // if (userCtrl.currentProfile().id != null) {
          //   request.headers['profile_id'] = "${userCtrl.currentProfile().id}";
          // }
        } else {
          await Future.delayed(const Duration(seconds: 1));
          addAuth(request);
        }
      } else {
        request.headers['Authorization'] = userCtrl.token;
        // if (userCtrl.currentProfile().id != null) {
        //   request.headers['profile_id'] = "${userCtrl.currentProfile().id}";
        // }
      }
    } else {
      logIfDebug("-----user token not set---------");
    }
    logIfDebug("-----refrechUserIsLaunch $refrechUserIsLaunch---------");
    while (refrechUserIsLaunch) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    return request;
  }
}

String queryStringParam(query, value) => value == null ? "" : "&$query=$value";
JsonType queryParam(query, value) => value == null ? {} : {query: value};

Future<bool> handleResponse(Response response,
    {VoidCallback? onSucces,
    VoidCallback? onError,
    bool showLog = true,
    bool disconnectIfNotAutorise = false,
    bool showSnackStatus = false}) async {
  bool isPostRequest = response.request?.method.toUpperCase() == "POST" ||
      response.request?.method.toUpperCase() == "PUT";
  if (showLog) {
    printIfDebug(
        "${response.request?.url} - ${response.statusCode}  - ${response.statusText}");
  }
  if (isPostRequest) {
    await Future.delayed(const Duration(milliseconds: 500));
  }
  // printIfDebug(response.body);
  if (response.statusCode == null) {
    if (showSnackStatus || isPostRequest) {
      showSnackBar(
          "Oups!!!", parseErrorMessageInFrench(response.statusText ?? ""),
          error: true);
    }
    return false;
  } else if ("${response.statusCode}".startsWith("2")) {
    if (response.body["code"] != StatusCode.SUCCESS &&
        (showSnackStatus || isPostRequest)) {
      String message = response.body["code"] == -1000
          ? "Une erreur interne est survenu, veuillez réessayer plustard"
          : response.body["data"] != null &&
                  response.body["data"]["message"] != null
              ? response.body["data"]["message"]
              : response.body["message"];
      showSnackBar("Oups!!!", parseErrorMessageInFrench(message), error: true);
      if (showLog) printIfDebug("succes : ${jsonEncode(response.body)}");
      onSucces?.call();
    }
    return response.body["code"] == StatusCode.SUCCESS;
  } else if ("${response.statusCode}".startsWith("5")) {
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();
    if ((showSnackStatus || isPostRequest)) {
      showSnackBar("Oups!!!",
          "Une erreur interne s'est produite, veuillez ré-essayer plustard",
          error: true);
      if (showLog) printIfDebug(response.body);
    }
    AnalyticsService.logEvent(fbEvent.serverError, parameters: {
      "path": response.request?.url ?? "",
      "error": response.body,
    });
  } else {
    if (response.statusCode == 401 &&
        UserController.instance.token.isNotEmpty) {
      // if (disconnectIfNotAutorise) {
      //   if (showLog) printIfDebug("invalid credential");
      //   final userCtrl = UserController.instance;
      //   userCtrl.logOut(local: true);
      // }
      if ((showSnackStatus || isPostRequest)) {
        // showSnackBar("Acces limité ",
        //     "Vous n'avez pas l'autorisation nécessaire \n ${response.request?.url.path.split("/").last}",
        //     error: true);
      }
      UserController.instance.logOut();
      // logIfDebug(
      //     "Vous n'avez pas l'autorisation nécessaire \n ${response.request?.url.path.split("/").last}");
    } else if (response.body.runtimeType == String &&
        !response.body.toString().contains('{')) {
      if (showLog) printIfDebug("Error String: ${response.body}");
    } else {
      if (showLog) {
        printIfDebug("Error : ${response.statusCode}");
        printIfDebug("Error : ${response.statusText}");
        printIfDebug("Error body: ${response.body}");
      }

      final data = response.body.runtimeType == String
          ? jsonDecode(response.body)
          : response.body;
      final message = data["data"] != null && data["data"]["message"] != null
          ? data["data"]["message"]
          : data["message"];
      String erreur = message != null
          ? parseErrorMessageInFrench(message)
          : parseErrorMessageInFrench(response.statusText ?? "");
      if (Get.isSnackbarOpen) Get.closeAllSnackbars();
      if ((showSnackStatus || isPostRequest)) {
        showSnackBar("Oups!!! ",
            "$erreur${ApiPaths.prod ? "" : "\n${(response.request?.url ?? "").toString().split("/").last}"}",
            error: true);
        AnalyticsService.logEvent(fbEvent.serverError, parameters: {
          "path": response.request?.url.path ?? "-no path",
          "error": erreur,
        });
      }
    }
  }
  return false;
}

String parseErrorMessageInFrench(String message) {
  String value = message.toLowerCase();
  if (value.contains("access denied")) {
    value =
        "Vous n'avez pas l'autorisation necessaire pour effectuer cette opération";
  } else if (value.contains("wrong password")) {
    value = "Mot de passe incorect";
  } else if (value.contains("invalid credentials")) {
    value = "Identifiant ou mot de passe incorect";
  } else if (value.contains("this otp is expired")) {
    value = "Ce code de validation a expiré, veuillez demander un nouveau code";
  } else if (value.contains("user already exist")) {
    value = "Numéro de téléphone ou adresse email déjà utilisé";
  }

  if (value.contains("receive account not found")) {
    value = "Aucun compte ne correspond à ce numéro de téléphone";
  }
  if (value.contains("account not found")) {
    value = "Aucun compte trouvé";
  } else if (value.replaceAll(" ", "-").toLowerCase().contains(RegExp(
      r'(failed-host-lookup|connection-failed|timed-out|timeout-exception)'))) {
    value = "Veuillez vérifier votre connexion internet";
  }
  return value;
}

Future<dynamic> handleStreamResponse(http.StreamedResponse response,
    {VoidCallback? onSucces,
    VoidCallback? onError,
    bool showSnackStatus = false}) async {
  try {
    bool isPostRequest = response.request?.method.toUpperCase() == "POST" ||
        response.request?.method.toUpperCase() == "PUT";
    printIfDebug(
        "${response.request?.url} - ${response.statusCode}  - ${response.reasonPhrase}");
    // printIfDebug(response.body);
    var result = '';
    response.stream.transform(utf8.decoder).listen((data) {
      result = '$result$data';
    });
    await Future.delayed(const Duration(milliseconds: 2000));
    final body = result.isEmpty ? null : jsonDecode(result);

    if ("${response.statusCode}".startsWith("2")) {
      // log(result);
      // return result.isEmpty ? null : jsonDecode(result);
      if (body != null) {
        if (body["code"] != StatusCode.SUCCESS &&
            (showSnackStatus || isPostRequest)) {
          showSnackBar(
              "Oups!",
              body["code"] == -1000
                  ? "Une erreur interne est survenu, veuillez réessayer plustard"
                  : (body["data"] == null || body["data"]["message"] == null)
                      ? body["message"]
                      : body["data"]["message"],
              error: true);
          printIfDebug("succes : $body}");
          onSucces?.call();
        }
        if (body["code"] != StatusCode.SUCCESS) closeDialog();
      }
    } else if ("${response.statusCode}".startsWith("5")) {
      if (Get.isSnackbarOpen) Get.closeAllSnackbars();
      if ((showSnackStatus || isPostRequest)) {
        showSnackBar("Oups!!!",
            "Une erreur interne s'est produite, veuillez ré-essayer plustard",
            error: true);
      }
      closeDialog();
      AnalyticsService.logEvent(fbEvent.serverError, parameters: {
        "path": response.request?.url ?? "",
        "error": response.reasonPhrase ?? "-",
      });
    } else {
      if (response.statusCode == 401 &&
          UserController.instance.token.isNotEmpty) {
        if ((showSnackStatus || isPostRequest)) {
          // showSnackBar("Acces limité ",
          //     "Vous n'avez pas l'autorisation nécessaire \n ${response.request?.url.path.split("/").last}",
          //     error: true);
        }
        // logIfDebug(
        //     "Vous n'avez pas l'autorisation nécessaire \n ${response.request?.url.path.split("/").last}");
        UserController.instance.logOut();
      } else if (body.runtimeType == String && !body.toString().contains('{')) {
        printIfDebug("Error String: ${body}");
      } else if (body != null) {
        printIfDebug("Error : ${response.statusCode}");
        printIfDebug("Error : ${response.reasonPhrase}");
        printIfDebug("Error body: ${body}");
        String erreur = '';
        if ("${response.reasonPhrase}"
                .toLowerCase()
                .contains("connection failed") ||
            "${response.reasonPhrase}"
                .toLowerCase()
                .contains("connection timed out")) {
          erreur = 'Veuillez vérifier votre connexion internet';
        } else if (body["message"] != null) {
          erreur = body["message"];
        }

        if (Get.isSnackbarOpen) Get.closeAllSnackbars();
        if ((showSnackStatus || isPostRequest)) {
          showSnackBar("Oups!!! ",
              "${parseErrorMessageInFrench(erreur)}${ApiPaths.prod ? "" : "\n${(response.request?.url ?? "").toString().split("/").last}"}",
              error: true);
        }
        AnalyticsService.logEvent(fbEvent.serverError, parameters: {
          "path": response.request?.url ?? "",
          "error": erreur,
        });
      }
      closeDialog();
    }
    return body;
  } on Exception catch (e) {
    return null;
  }
}

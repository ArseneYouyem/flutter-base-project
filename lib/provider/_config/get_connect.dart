import 'dart:convert';
import 'package:get/get.dart';
import '../../helper/outputs.dart';
import '../../services/storage_services.dart';
import 'core_provider.dart';

class ApiProvider extends GetConnect {
  ApiProvider({this.enebleCach = true, this.cashAndNetwork = true});

  bool enebleCach;
  bool cashAndNetwork;
  StorageService storage = Get.find();

  decoder(value) {}

  @override
  void onInit() {}

  Future<Response<dynamic>> getData(url,
      {Map<String, dynamic>? query,
      Function(Response<dynamic>)? onDataUpdated}) async {
    String formatedQuey = "";
    if (query != null) {
      query.forEach((key, value) {
        if (value != null && "$value" != "null") {
          printIfDebug("==> $key : $value");
          formatedQuey = key == query.keys.first
              ? "?$key=$value"
              : "$formatedQuey&$key=$value";
        }
      });
    }
    final urlF = "$url$formatedQuey";
    if (enebleCach) {
      final cashValue = checkValueToStorage(urlF, null);
      if (cashValue != null) {
        get(urlF).then((value) async {
          saveValueToStorage(urlF, null, value);
          if (onDataUpdated != null &&
              await handleResponse(value,
                  showSnackStatus: false, showLog: false)) {
            onDataUpdated(value);
          }
        }).catchError((error) {
          printIfDebug("Erreur lors de la mise à jour en arrière-plan: $error");
        });
        return cashValue;
      } else {
        final result = await get(urlF);
        saveValueToStorage(urlF, null, result);
        return result;
      }
    }
    return await get(urlF);
  }

  Future<Response<dynamic>> postData(url, param) async {
    if (enebleCach) {
      final cashValue = checkValueToStorage(url, null);
      if (cashValue != null) {
        if (cashAndNetwork) {
          post(url, param).then((value) {
            saveValueToStorage(url, param, value);
          });
        }
        return cashValue;
      } else {
        final result = await post(url, param);
        saveValueToStorage(url, param, result);
        return result;
      }
    }
    return await post(url, param);
  }

  ///cash configurations

  String cashKey(url, param) {
    return "cash_${url}_${param == null ? "" : jsonEncode(param)}";
  }

  saveValueToStorage(url, param, Response<dynamic> response) async {
    if (await handleResponse(response,
        showSnackStatus: false,
        onError: () {},
        onSucces: () {},
        showLog: false)) {
      storage.save(cashKey(url, param),
          [response.statusCode, jsonEncode(response.body)]);
    }
  }

  Response<dynamic>? checkValueToStorage(url, param) {
    final data = storage.find(cashKey(url, param));
    if (data != null) {
      logIfDebug(cashKey(url, param));
      logIfDebug(data[0].toString());
      // printIfDebug(data[1]);
      return Response(
          statusCode: int.parse("${data[0]}"), body: jsonDecode(data[1]));
    }
    return null;
  }
}

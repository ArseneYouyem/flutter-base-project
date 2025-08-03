// import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import '../../config/type.dart';
import '../../helper/outputs.dart';
import '../../store/user_controller.dart';
import '../auth_provider.dart';
import 'core_provider.dart';
import 'package:http_parser/http_parser.dart';

class UploadProvider {
  final userCtrl = UserController.instance;

  Future<bool> tokenHasExpired(String token) async {
    final expirationDate = JwtDecoder.getExpirationDate(token);
    expirationDate.subtract(const Duration(seconds: 10));
    if (DateTime.now().isAfter(expirationDate)) {
      printIfDebug("-----token has expired----------");
      final provider = Get.put(AuthProvider());
      final result = await provider.refreshToken(
          refresh: UserController.instance.refreshToken);
      if (result == "expiredRefreshToken") {
        UserController.instance.logOut();
      } else if (result != null) {
        return false;
      } else {
        await Future.delayed(const Duration(seconds: 1));
        await tokenHasExpired(token);
      }
    }
    return false;
  }

  String getMimeType(String path) {
    final lPath = path.toLowerCase();
    String mimeType = '';
    if (lPath.endsWith('.jpg') || lPath.endsWith('.jpeg')) {
      //format image
      mimeType = 'image/jpeg';
    } else if (lPath.endsWith('.png')) {
      mimeType = 'image/png';
    } else if (lPath.endsWith('.gif')) {
      mimeType = 'image/gif';
    } else if (lPath.endsWith('.mp4')) {
      //format video
      mimeType = 'video/mp4';
    } else if (lPath.endsWith('.mov')) {
      mimeType = 'video/quicktime';
    } else if (lPath.endsWith('.avi')) {
      mimeType = 'video/x-msvideo';
    } else if (lPath.endsWith('.mkv')) {
      mimeType = 'video/x-matroska';
    }
    return mimeType;
  }

  Future<dynamic> doUpload(String url,
      {JsonType? data,
      String? imageKey,
      JsonFileType? files,
      bool? update = false,
      bool addAuth = true}) async {
    var request = http.MultipartRequest(
      update! ? 'PUT' : 'POST',
      Uri.parse(url),
    );

    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
      // 'Content-Type': "application/json",
    };
    if (userCtrl.token.isNotEmpty && addAuth) {
      final expired = await tokenHasExpired(userCtrl.token);
      if (!expired) {
        headers = {
          ...headers,
          "Authorization": userCtrl.token,
          // if (userCtrl.currentProfile().id != null)
          //   "profile_id": "${userCtrl.currentProfile().id}",
        };
      }
    }

    if (files != null) {
      for (var key in files.keys) {
        // logIfDebug("$key : ${files[key]!.path}");
        var mimeType = getMimeType(files[key]!.path);
        logIfDebug("mimeType $mimeType");
        http.MultipartFile imageFile = await http.MultipartFile.fromPath(
          imageKey ?? key,
          files[key]!.path,
          contentType: MediaType.parse(mimeType),
        );
        request.files.add(imageFile);
      }
    }

    request.headers.addAll(headers);
    data != null ? request.fields.addAll(Map<String, String>.from(data)) : null;

    try {
      var value = await request.send();
      final result = await handleStreamResponse(value);
      return result;
    } on Exception catch (e) {
      // catchExeption(e, url);
      logIfDebug(e);
      return null;
    }
  }
}

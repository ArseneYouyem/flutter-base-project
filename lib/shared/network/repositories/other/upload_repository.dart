import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutterbasestructure/shared/network/dio/error_interceptor.dart';
import 'package:get/get.dart' as get_x;
import 'package:http_parser/http_parser.dart';
import '../../../../core/helper/util.dart';

class UploadRepository {
  final http = get_x.Get.find<Dio>();

  Future<dynamic> uploadData(String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          filePath,
          filename: "upload.jpg",
          contentType: MediaType.parse(getMimeType(filePath)),
        ),
      });

      final response = await http.post(
        "https://api.example.com/upload",
        data: formData,
      );
      return response.data['data'];
    } catch (e) {
      throw Exception(ErrorInterceptor.parseExecption(e as Exception));
    }
  }
}

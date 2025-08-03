import 'dart:io';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import '../config/type.dart';

// fromJson
DateTime? fromJsonDate(String? date) {
  return date == null ? null : DateTime.parse(date);
}

List<JsonType> parseMap(dynamic listItem) {
  List<JsonType> listResult = [];
  if (listItem != null) {
    for (var image in listItem) {
      listResult.add(JsonType.from(image));
    }
  }
  return listResult;
}

bool? fromJsonBool(dynamic value) {
  if (value == null) return false;
  if (value.runtimeType == String) {
    if (value == 'true') {
      return true;
    } else if (value == 'false') {
      return false;
    }
    return int.parse(value) == 1;
  }
  return value == 1;
}

List<T> fromJsonList<T>(
    List<JsonType>? value, ParamsCallback<T, JsonType> fromJson) {
  List<T> locations = [];
  if (value != null) {
    value.forEach((element) {
      // print(element);
      locations.add(fromJson(element));
    });
  }
  return locations;
}

T? fromJsonModel<T>(JsonType? value, ParamsCallback<T, JsonType> fromJson) {
  return value == null ? null : fromJson(value);
}

int? fromJsonInt(dynamic value) {
  if (value == null) return 0;
  if (value.runtimeType == String) return int.parse(value);
  return value;
}

double? fromJsonDouble(dynamic value) {
  if (value == null) return 0;
  if (value.runtimeType == String) return double.parse(value);
  return value;
}
// toJson

Map<String, dynamic> toJsonFile(
    {required File file, String fealdName = 'file'}) {
  return {fealdName: MultipartFile(file, filename: file.path.split("/").last)};
}

String? toJsonDate(DateTime? date) {
  return date == null ? null : date.toIso8601String();
}

JsonType? toJsonModel<T>(T? value, ParamsCallback<JsonType, T> toJson) {
  return value == null ? null : toJson(value);
}

List<JsonType> toJsonList<T>(
    List<T>? value, ParamsCallback<JsonType, T> toJson) {
  List<JsonType> locations = [];
  if (value != null) {
    value.forEach((element) {
      locations.add(toJson(element));
    });
  }
  return locations;
}

int countCharacterOccurrences(String text, String character) {
  int count = 0;
  for (int i = 0; i < text.length; i++) {
    if (text[i] == character) {
      count++;
    }
  }
  return count;
}

int valueToInt(value) {
  return int.parse("$value");
}

double valueToDouble(value) {
  return double.parse("$value");
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

Future<void> openUrl(String url) async {
  // logIfDebug(url);
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

removeKeyboardFocus() {
  final currentFocus = FocusScope.of(Get.context!);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

String truncatedName(firstName, lastName) {
  return "${"$lastName".split(" ").first} ${"$firstName".split(" ").first}";
}

String formatNameIn2Digit(String name) {
  final values = name.trim().split(" ");
  return values.length == 1
      ? values.first.characters.first
      : "${values.first.characters.first}${values.last.characters.first}"
          .toUpperCase();
}

String generateHexadecimalCode(String name) {
  return name.codeUnits
      .map((unit) => unit.toRadixString(16))
      .join("")
      .padLeft(6, '0');
}

String formatMoney(value, {String? symbol, int decimalDigits = 2}) {
  final formatter = NumberFormat.currency(
    symbol: symbol ?? "", // Currency symbol (optional)
    decimalDigits: decimalDigits, // Number of decimal digits (optional)
  );

  final formated = formatter.format(double.parse("$value"));
  // return formated;
  return double.parse("$value") == 0.0
      ? "0"
      : double.parse("$value") != 0.0 &&
              (double.parse("$value") / int.parse("$value".split(".").first)) ==
                  1
          ? formated.split(".").first
          : formated;
}

String pluralForm(int length) => length > 1 ? "s" : "";

initBinding(VoidCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    callback.call();
  });
}

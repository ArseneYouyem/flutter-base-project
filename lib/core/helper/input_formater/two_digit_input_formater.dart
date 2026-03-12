import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../outputs.dart';

class TwoDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedValue = _addSpaces(newValue.text);
    return newValue.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length));
  }

  String _addSpaces(String val) {
    String value = val.removeAllWhitespace;
    printIfDebug(value);
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      if ((i + 1) % 2 == 0 && i != value.length - 1) {
        buffer.write(' ');
      }
    }
    return buffer.toString();
  }
}

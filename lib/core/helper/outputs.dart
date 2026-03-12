import 'dart:developer';
import 'package:flutter/foundation.dart';

printIfDebug(value) {
  if (kDebugMode) {
    print('$value');
  }
}

logIfDebug(value) {
  if (kDebugMode) {
    log('$value');
  }
}

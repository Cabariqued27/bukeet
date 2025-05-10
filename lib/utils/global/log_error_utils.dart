import 'package:flutter/material.dart';

class LogError {
  static void capture(
    dynamic exception,
    dynamic stackTrace,
    String method,
  ) async {
    debugPrint('CATCH ERROR: $method: $exception');
  }
}

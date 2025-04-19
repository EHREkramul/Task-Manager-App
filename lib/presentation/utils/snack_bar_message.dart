import 'package:flutter/material.dart';

import '../../app/app.dart';

void showSnackBarMessage(String message, [bool isError = false]) {
  ScaffoldMessenger.of(
    TaskManagerApp.navigatorKey.currentContext!,
  ).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      duration: Duration(seconds: 1),
    ),
  );
}

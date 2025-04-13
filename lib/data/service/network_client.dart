import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:taskmanager/app/app.dart';
import 'package:taskmanager/presentation/controllers/auth_controller.dart';
import 'package:taskmanager/presentation/screens/login_screen.dart';

import 'network_response.dart';

class NetworkClient {
  static final Logger _logger = Logger();

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'token': AuthController.token ?? ''};
      _preRequestLog(url, headers);
      Response response = await get(uri, headers: headers);
      _postRequestLog(
        url,
        response.statusCode,
        headers: response.headers,
        body: response.body,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else if (response.statusCode == 401) {
        _moveToLoginScreen();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthorized Request',
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Something went wrong';

        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      _postRequestLog(url, -1, errorMessage: e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'token': AuthController.token ?? '',
      };
      _preRequestLog(url, headers);

      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      _postRequestLog(
        url,
        response.statusCode,
        headers: response.headers,
        body: response.body,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else if (response.statusCode == 401) {
        _moveToLoginScreen();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthorized Request',
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Something went wrong';

        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      _postRequestLog(url, -1, errorMessage: e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _preRequestLog(
    String url,
    Map<String, String> headers, {
    Map<String, dynamic>? body,
  }) {
    _logger.i(
      'URL => $url\n'
      'Headers => $headers\n'
      'Body => $body\n',
    );
  }

  static void _postRequestLog(
    String url,
    int statusCode, {
    Map<String, dynamic>? headers,
    dynamic body,
    dynamic errorMessage,
  }) {
    if (errorMessage == null) {
      _logger.i(
        'URL => $url\n'
        'Status Code => $statusCode\n'
        'Response => $body\n'
        'Headers => $headers\n',
      );
    } else {
      _logger.e(
        'URL => $url\n'
        'Status Code => $statusCode\n'
        'Error Message => $errorMessage\n',
      );
    }
  }

  static Future<void> _moveToLoginScreen() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }
}

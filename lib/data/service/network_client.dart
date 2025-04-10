import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'network_response.dart';

class NetworkClient {
  static final Logger _logger = Logger();

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _preRequestLog(url);
      Response response = await get(uri);
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
      _preRequestLog(url);

      Response response = await post(
        uri,
        headers: {'Content-type': 'application/json'},
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

  static void _preRequestLog(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'URL => $url\n'
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
}

import 'dart:async';
import 'dart:convert';

import 'package:equipro/utils/http/response_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  final String _baseUrl;

  HttpService(this._baseUrl);
  String get baseUrl => _baseUrl;

  Future<dynamic> get(String path) async {
    final String url = baseUrl + path;
    print('Request::URL: $url');
    final response = await http
        .get(
          Uri.parse(url),
          headers: await getHeaders(),
        )
        .timeout(
          const Duration(seconds: 40),
        );

    return handleResponse(response);
  }

  Future<dynamic> getRequest(String path) async {
    final String url = baseUrl + path;
    print('Request::URL: $url');
    return await http
        .get(
          Uri.parse(url),
          headers: await getHeaders(),
        )
        .timeout(
          const Duration(seconds: 40),
        );
  }

  Future<dynamic> postRequest(String path) async {
    final String url = baseUrl + path;
    print('Request::URL: $url');
    return await http
        .post(
          Uri.parse(url),
          headers: await getHeaders(),
        )
        .timeout(
          const Duration(seconds: 40),
        );
  }

  Future<dynamic> post(String path, Map<dynamic, dynamic> body) async {
    final String url = baseUrl + path;
    print('URL:: $url, body:: ${json.encode(body)}');

    final response = await http
        .post(Uri.parse(url),
            headers: await getHeaders(), body: json.encode(body))
        .timeout(const Duration(seconds: 30));

    return handleResponse(response);
  }

  Future<dynamic> patch(String path, Map<dynamic, dynamic> body) async {
    final String url = _baseUrl + path;
    print('URL:: $url, body:: ${json.encode(body)}');

    final response = await http
        .patch(Uri.parse(url),
            headers: await getHeaders(), body: json.encode(body))
        .timeout(const Duration(seconds: 30));

    return handleResponse(response);
  }

  Future<dynamic> put(String path, Map<dynamic, dynamic> body) async {
    final String url = _baseUrl + path;
    print('URL:: $url, body:: ${json.encode(body)}');

    final response = await http
        .put(Uri.parse(url),
            headers: await getHeaders(), body: json.encode(body))
        .timeout(const Duration(seconds: 30));

    return handleResponse(response);
  }

  Future<dynamic> delete(String path) async {
    final String url = _baseUrl + path;
    print('URL:: $url body:: $path');

    final response = await http
        .delete(
          Uri.parse(url),
          headers: await getHeaders(),
        )
        .timeout(const Duration(seconds: 30));

    return handleResponse(response);
  }

  getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? accessToken = prefs.get('token');
    // print('token $accessToken');
    return <String, String>{
      'X-APP-KEY': 'IFUKpFVCunCU0fK0tQQqTsX',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $accessToken"
    };
  }
}

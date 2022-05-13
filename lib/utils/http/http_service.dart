import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equipro/utils/http/response_handler.dart';

class HttpService {
  final String _baseUrl;

  HttpService(this._baseUrl);
  String get baseUrl => _baseUrl;

  Future<dynamic> get(String path) async {
    final String url = baseUrl + path;
    print('Request::URL: $url');
    final response =
        await http.get(Uri.parse(url), headers: await getHeaders(),).timeout(const Duration(seconds: 40),);

    return handleResponse(response);
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
   print('token $accessToken');
    return <String, String>{
      'X-APP-KEY': '37T8O89O445568u89WELrVl',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $accessToken"
    };
  }
}

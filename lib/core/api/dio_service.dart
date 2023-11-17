import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/http/paths.dart';
import 'api_constants.dart';

class ApiService {
  final _log = Logger();
  late Dio _dio;

  Dio get dio => _dio;

  String? deviceId;

  String? accessToken;

  static final ApiService _instance = ApiService._internal();

  factory ApiService({String? authToken}) {
    // Pass the authorization token to the constructor if provided
    // _instance._dio.options.headers = {
    //   'X-APP-KEY': 'IFUKpFVCunCU0fK0tQQqTsX',
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   "Authorization": "Bearer $authToken"
    // };
    return _instance;
  }

  // Future<dynamic> postRequest(Map<String, dynamic> data, String path) async {
  //   return _dio.post(Paths.baseUrl + path, data: data);
  // }

  ApiService._internal() {
    _dio = Dio();
    _dio.options.baseUrl = Paths.baseUrl;
    _dio.options.connectTimeout = Duration(seconds: 60);
    _dio.options.receiveTimeout = Duration(seconds: 60);
    _dio.options.headers = getHeaders();
    // _dio.interceptors.add(_authInterceptor());
    _dio.options.receiveDataWhenStatusError = true;
  }

  getHeaders() {
    // _log.i("Access Token from Headers: $accessToken");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // Object? accessToken = prefs.get('token');
    // print('token $accessToken');
    return <String, dynamic>{
      'X-APP-KEY': 'IFUKpFVCunCU0fK0tQQqTsX',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $accessToken"
    };
  }

  void setAccessToken(token) {
    accessToken = token;
    _log.i(accessToken);
  }

  void setDeviceIdHeader(deviceId) {
    _log.i(deviceId);
    _dio.options.headers["deviceId"] = deviceId;
  }

  void setAuthorizationHeader(String accessToken) {
    _dio.options.headers["authorization"] = "Bearer $accessToken";
  }

  Future<dynamic> postRequest(dynamic data, String path) async {
    _log.i("Path: ${Paths.baseUrl + path}");
    _log.i("Payload: ${data.toString()}");
    Response res = await _dio.post(path,
        data: data, options: Options(headers: getHeaders()));
    _log.i("Response: ${res.data}");
    return res;
  }

  Future<Response> getRequest(dynamic data, String path) async {
    _log.i("Path: ${path}");
    _log.i("Payload: ${data.toString()}");
    Response res = await _dio.get(path,
        queryParameters: data, options: Options(headers: getHeaders()));
    _log.i("Response: ${res.data}");
    return res;
  }
}

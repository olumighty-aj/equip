import 'dart:convert';

import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/tiny_db.dart';
import 'package:http/http.dart' as http;

handleResponse(http.Response response) {
  final NavService navigationService = locator<NavService>();
  try {
    print(
        'ResponseCode:: ${response.statusCode},   ResponseBody:: ${response.body}');

    final int code = response.statusCode;
    final dynamic body = json.decode(response.body);
    // if(code == 200 || code == 201) {
    if (body["status"] == true) {
      return SuccessModel(body);
    } else if (body["status"] == false) {
      TinyDb.remove("profile");
      showErrorToast("Session Expired");
      navigationService.pushAndRemoveUntil(loginRoute);
    } else {
      return ErrorModel(body['message']);
    }
  } catch (ex) {
    print(ex.toString());
    return ErrorModel('Request failed');
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equipro/core/api/dio_service.dart';
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/core/model/SignInResponse.dart';
import 'package:equipro/core/model/auth_model.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/http/paths.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as htp;

import '../../app/app_setup.locator.dart';
import '../../app/app_setup.logger.dart';
import '../../utils/base_model.dart';

class Authentication {
  final _log = getLogger("Authentication");
  final NavService _navigationService = locator<NavService>();
  final _apiService = locator<ApiService>();

  late Details _currentUser;
  Details get currentUser => _currentUser;

  // WalletBalance? _walletBalance;
  // WalletBalance? get walletBalance => _walletBalance;

  late String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  late String _userId;
  String get userId => _userId;

  late AuthModel _token;
  AuthModel get token => _token;

  void setToken(token) {
    _token = token;
  }

  saveRegPhone(String phone) async {
    _phoneNumber = phone;
  }

  login(Map<dynamic, dynamic> payload) async {
    try {
      final result = await http.post(Paths.login, payload);
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      final AuthModel auth =
          AuthModel.fromJson(result.data['payload']['token']);
      _token = auth;
      Details user = Details.fromJson(result.data['payload']["details"]);
      showToast(result.data['message']);
      _currentUser = user;
      SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', auth.token);
      await prefs.setString("profile", json.encode(user));

      return SuccessModel(user);
    } catch (e) {
      return ErrorModel('Login failed, try again.');
    }
  }

  Future<BaseDataModel?> newSwitchRole(role) async {
    try {
      Response res = await _apiService.postRequest(
          {"hirers_id": currentUser.id, "toggle": role}, Paths.switchOwner);
      if (res.statusCode == 200) {
        _apiService.setAccessToken(res.data["payload"]["token"]);
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response.toString());
      return BaseDataModel.fromJson(e.response?.data);
    }
  }

  void setCurrentUser(user) {
    _log.i("Set current User: $user");
    _currentUser = Details.fromJson(user);
  }

  switchRole(String role) async {
    try {
      var url = Paths.switchOwner;
      var result =
          await http.post(url, {"hirers_id": currentUser.id, "toggle": role});
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        return ErrorModel(result.error);
      }
      final AuthModel auth =
          AuthModel.fromJson(result.data['payload']['token']);
      _token = auth;
      Details user = Details.fromJson(result.data['payload']["details"]);
      // showToast(result.data['message']);
      _currentUser = user;
      _log.i("SavedUser: ${_currentUser.toJson()}");
      // _userId = user.id!;
      SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', auth.token);
      //  await prefs.setString('userId', user.id.toString());
      await prefs.setString("profile", json.encode(user));
      // showToast(result.data['message']);
      _log.i("Here: ${result.data["payload"]}");
      _apiService.setAccessToken(result.data["payload"]["token"]);
      return SuccessModel(result.data["payload"]);
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel?> newLogin(Map<String, dynamic> data) async {
    try {
      Response res = await _apiService.postRequest(data, Paths.login);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response);
      return BaseDataModel.fromJson(e.response?.data);
    }
  }

  Future<BaseDataModel?> newRegister(Map<String, dynamic> data) async {
    try {
      Response res = await _apiService.postRequest(data, Paths.signUp);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.e(e.message);
      _log.e(e.response);
      return BaseDataModel.fromJson(e.response?.data);
    } catch (e) {
      _log.e(e.toString());
    }
  }

  //
  alreadyLoggedIn() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    var d = prefs.getString('currentUser');
    Details user = Details.fromJson(json.decode(d!));
    _currentUser = user;
    print(_currentUser.id.toString());
    var t = prefs.getString('token');
    final AuthModel auth = AuthModel.fromJson(t!);
    //   print("TOKEN AGBA::::::::: ${auth.token}");
    _token = auth;
    // "is_owner": true,
    user.userType == "hirers"
        ? _navigationService.navigateReplacementTo(homeRoute)
        : _navigationService.navigateReplacementTo(HomeOwnerRoute);
    return SuccessModel(user);
  }

  signUp(Map<dynamic, dynamic> payload) async {
    try {
      final result = await http.post(Paths.signUp, payload);
      if (result is ErrorModel) {
        print(result.error);
        return ErrorModel(result.error);
      }

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  //
  // editProfile(Map<dynamic, dynamic> payload) async {
  //   try {
  //     final result = await http.post(Paths.signUp, payload);
  //     if (result is ErrorModel) {
  //       return ErrorModel(result.error);
  //     }
  //
  //     SignInResponse user = SignInResponse.fromJson(result.data['result']);
  //     showToast(result.data['message']);
  //     _currentUser = user;
  //     SharedPreferences prefs;
  //     prefs = await SharedPreferences.getInstance();
  //     //  await prefs.setString('token', auth.token);
  //     await prefs.setString('userId', user.id.toString());
  //     await prefs.setString("userDetails", json.encode(user));
  //     _navigationService.navigateTo(bookDeliveryRoute);
  //     return SuccessModel(result.data);
  //   } catch (e) {
  //     return ErrorModel('$e');
  //   }
  // }
  //
  // changePassword(Map<dynamic, dynamic> payload) async {
  //   try {
  //     final result = await http.post(Paths.changePassword, payload);
  //     if (result is ErrorModel) {
  //       return ErrorModel(result.error);
  //     }
  //     showToast(result.data['message']);
  //     return SuccessModel(result.data);
  //   } catch (e) {
  //     return ErrorModel('$e');
  //   }
  // }
  //
  // verifyOtp(Map<dynamic, dynamic> payload) async {
  //   try {
  //     final result = await http.post(Paths.verifyCode, payload);
  //     if (result is ErrorModel) {
  //       return ErrorModel(result.error);
  //     }
  //
  //     // VerifyOtpResponse verifyOtpResponse =
  //     //     VerifyOtpResponse.fromJson(result.data);
  //
  //     return SuccessModel(result.data);
  //   } catch (e) {
  //     return ErrorModel('$e');
  //   }
  // }
  //
  forgotPassword(Map<dynamic, dynamic> payload) async {
    try {
      final result = await http.post(Paths.forgotPassword, payload);
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      showToast(result.data['message']);

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel> newForgotPassword(Map<String, dynamic> payload) async {
    Response res = await _apiService.postRequest(payload, Paths.forgotPassword);
    return BaseDataModel.fromJson(res.data);
  }

  Future<BaseDataModel> newVerifyForgotPassword(
      Map<dynamic, dynamic> payload) async {
    Response res =
        await _apiService.postRequest(payload, Paths.forgotPasswordVerify);
    return BaseDataModel.fromJson(res.data);
  }

  //
  verifyForgotPassword(Map<dynamic, dynamic> payload) async {
    try {
      final result = await http.post(Paths.forgotPasswordVerify, payload);
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }

      showToast(result.data['message']);

      return SuccessModel(result.data);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  updateAddress(String address, String lat, String lng) async {
    var header = {
      'X-APP-KEY': 'IFUKpFVCunCU0fK0tQQqTsX',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${token.token}"
    };
    var file;
    int count = 0;
    dynamic catalogueFile;
    final imageUploadRequest =
        htp.MultipartRequest('POST', Uri.parse(baseUrl + Paths.ownersProfile));
    imageUploadRequest.headers.addAll(header);
    //  imageUploadRequest.fields['UserType'] = currentUser.userInformation.roleId;

    imageUploadRequest.fields['longitude'] = lng;
    imageUploadRequest.fields['latitude'] = lat;
    imageUploadRequest.fields['location'] = address;

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await htp.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        print(response.body);
        print(response.statusCode);
        return null;
      }
      print(response.statusCode);
      final Map<String, dynamic> result = json.decode(response.body);
      print(result);
      Details user = Details.fromJson(result['payload']);
      showToast(result['message']);
      _currentUser = user;
      // _userId = user.id!;
      SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();
      await prefs.setString("profile", json.encode(user));
      return result;
    } catch (e) {
      print("from code");
      print(e);
      return null;
    }
  }

  void updateUser(user) {
    _currentUser = user;
  }

  editProfile({
    String? displayPicture,
    String? address,
    String? gender,
    String? lat,
    String? lng,
    String? kyc_name,
    String? kyc_document_path,
  }) async {
    var header = {
      'X-APP-KEY': 'IFUKpFVCunCU0fK0tQQqTsX',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${token.token}"
    };

    dynamic catalogueFile;
    dynamic meansOfId;
    final imageUploadRequest;
    if (currentUser.userType! == "hirers") {
      imageUploadRequest =
          htp.MultipartRequest('POST', Uri.parse(baseUrl + Paths.profile));
      imageUploadRequest.headers.addAll(header);
    } else {
      imageUploadRequest = htp.MultipartRequest(
          'POST', Uri.parse(baseUrl + Paths.ownersProfile));
      imageUploadRequest.headers.addAll(header);
    }

    //  imageUploadRequest.fields['UserType'] = currentUser.userInformation.roleId;

    // Attach the file in the request
    if (displayPicture != null && displayPicture != "") {
      catalogueFile =
          await htp.MultipartFile.fromPath('hirers_path', displayPicture);
      //print(catalogueFile);
      imageUploadRequest.files.add(catalogueFile);
    }

    if (kyc_document_path != null && kyc_document_path != "") {
      meansOfId = await htp.MultipartFile.fromPath(
          'kyc_document_path[]', kyc_document_path);
      //print(catalogueFile);
      imageUploadRequest.files.add(meansOfId);
    }

    if (kyc_name == "") {
      imageUploadRequest.fields['address'] = address;
      imageUploadRequest.fields['gender'] = gender;
      imageUploadRequest.fields['latitude'] = lat;
      imageUploadRequest.fields['longitude'] = lng;
    } else {
      imageUploadRequest.fields['address'] = address;
      imageUploadRequest.fields['kyc_name'] = kyc_name;
      imageUploadRequest.fields['gender'] = gender;
      imageUploadRequest.fields['latitude'] = lat;
      imageUploadRequest.fields['longitude'] = lng;
    }

    try {
      print(imageUploadRequest.files);
      print(imageUploadRequest.fields);
      final streamedResponse = await imageUploadRequest.send();
      final response = await htp.Response.fromStream(streamedResponse);
      if (jsonDecode(response.body)["status"] != true) {
        showErrorToast(json.decode(response.body)['message']);
        print(response.body);
        print(response.statusCode);
        return null;
      }
      print(response.statusCode);
      final Map<String, dynamic> result = json.decode(response.body);
      print(result);
      Details user = Details.fromJson(result['payload']);
      showToast(result['message']);
      _currentUser = user;
      // _userId = user.id!;
      SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();
      await prefs.setString("profile", json.encode(user));
      return result;
    } catch (e) {
      print("from code");
      print(e);
      return null;
    }
  }

  Future<BaseDataModel> getUserProfile() async {
    Response res = await _apiService.getRequest(null, Paths.profile);
    return BaseDataModel.fromJson(res.data);
  }

  Future<BaseDataModel?> editNewProfile(data) async {
    try {
      Response res = await _apiService.postRequest(
          data,
          currentUser.userType == "hirers"
              ? Paths.profile
              : Paths.ownersProfile);
      if (res.statusCode == 200) {
        return BaseDataModel.fromJson(res.data);
      }
    } on DioException catch (e) {
      _log.i(e.message);
      _log.i(e.response);
      return BaseDataModel.fromJson(e.response?.data);
    }
  }

  Future<BaseDataModel> getKYC() async {
    Response res =
        await _apiService.getRequest(null, Paths.verifyKYC + currentUser.id!);
    _log.i("STATUS code: ${res.statusCode}");
    _log.i("Here: ${res.data}");
    return BaseDataModel.fromJson(res.data);
  }

  Future<dynamic> logout({BuildContext? context}) async {
    Response res = await _apiService.postRequest(null, Paths.logout);
    if (res.statusCode == 200) {
      showToast(res.data["message"] ?? "", context: context);
      return true;
    } else {
      return false;
    }
  }

  getReviews() async {
    try {
      var url = Paths.reviews + currentUser.id.toString();

      final result = await http.get(
        url,
      );
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        var data = result.error;
        List<ReviewsModel> packageList = List<ReviewsModel>.from(
            data.map((item) => ReviewsModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      var data = result.data["payload"]['content'];
      List<ReviewsModel> packageList = List<ReviewsModel>.from(
          data.map((item) => ReviewsModel.fromJson(item)));
      print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  getHirerReviews(String id) async {
    try {
      var url = Paths.reviews + id;

      final result = await http.get(
        url,
      );
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
        var data = result.error;
        List<ReviewsModel> packageList = List<ReviewsModel>.from(
            data.map((item) => ReviewsModel.fromJson(item)));
        return ErrorModel(packageList);
      }
      var data = result.data["payload"]['content'];
      List<ReviewsModel> packageList = List<ReviewsModel>.from(
          data.map((item) => ReviewsModel.fromJson(item)));
      print(packageList);
      return packageList;
    } catch (e) {
      print(e.toString());
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }
}

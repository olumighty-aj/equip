import 'dart:convert';

import 'package:equipro/core/model/SignInResponse.dart';
import 'package:equipro/core/model/auth_model.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/http/paths.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as htp;

class Authentication {
  final NavigationService _navigationService = locator<NavigationService>();

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
      // _userId = user.id!;
      SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', auth.token);
      //  await prefs.setString('userId', user.id.toString());
      await prefs.setString("profile", json.encode(user));
      //print('firstname' + user.firstName!);
      // return SuccessModel({'auth': auth, 'user': user});

      return SuccessModel(user);
    } catch (e) {
      return ErrorModel('Login failed, try again.');
    }
  }

  //
  alreadyLoggedIn() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    var d = prefs.getString('profile');
    Details user = Details.fromJson(json.decode(d!));
    _currentUser = user;
    print(_currentUser.id.toString());
    // _userId = user.id!;
    var t = prefs.getString('token');
    final AuthModel auth = AuthModel.fromJson(t!);
    //   print("TOKEN AGBA::::::::: ${auth.token}");
    _token = auth;
    _navigationService.navigateReplacementTo(homeRoute);
    return SuccessModel(user);
  }

  signUp(Map<dynamic, dynamic> payload) async {
    try {
      final result = await http.post(Paths.signUp, payload);
      if (result is ErrorModel) {
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

  updateAddress(
    String address,
  ) async {
    var header = {
      'X-APP-KEY': '37T8O89O445568u89WELrVl',
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

    imageUploadRequest.fields['address'] = address;

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

  editProfile(
    String displayPicture,
    String address,
    String fullName,
    String phone,
    String lat,
    String lng,
  ) async {
    var header = {
      'X-APP-KEY': '37T8O89O445568u89WELrVl',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${token.token}"
    };

    dynamic catalogueFile;
    final imageUploadRequest =
        htp.MultipartRequest('POST', Uri.parse(baseUrl + Paths.ownersProfile));
    imageUploadRequest.headers.addAll(header);
    //  imageUploadRequest.fields['UserType'] = currentUser.userInformation.roleId;

    // Attach the file in the request
    if (displayPicture != "") {
      catalogueFile =
          await htp.MultipartFile.fromPath('hirers_path', displayPicture);
      //print(catalogueFile);
      imageUploadRequest.files.add(catalogueFile);
    }

    imageUploadRequest.fields['address'] = address;
    imageUploadRequest.fields['fullname'] = fullName;
    imageUploadRequest.fields['phone_number'] = phone;
    imageUploadRequest.fields['avail_from'] = lat;
    imageUploadRequest.fields['avail_to'] = lng;

    try {
      print(imageUploadRequest.files);
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
}

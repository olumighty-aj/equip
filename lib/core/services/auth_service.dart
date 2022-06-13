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

  switchRole(String role) async {
    try {
      var url = Paths.switchOwner;
      final result = await http
          .post(url, {"hirers_id": currentUser.id,"toggle":role});
      if (result is ErrorModel) {
        print("ERROR");
        print(result.error);
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
      showToast(result.data['message']);
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
  //
  alreadyLoggedIn() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    var d = prefs.getString('profile');
    Details user = Details.fromJson(json.decode(d!));
    _currentUser = user;
    print(_currentUser.id.toString());
    var t = prefs.getString('token');
    final AuthModel auth = AuthModel.fromJson(t!);
    //   print("TOKEN AGBA::::::::: ${auth.token}");
    _token = auth;
   // "is_owner": true,

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
    String address, String lat ,String lng
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

  editProfile(
    String displayPicture,
    String address,
    String gender,
    String lat,
    String lng,
      String kyc_name,
      String kyc_document_path,
  ) async {
    var header = {
      'X-APP-KEY': '37T8O89O445568u89WELrVl',
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${token.token}"
    };

    dynamic catalogueFile;
    dynamic meansOfId;
    final imageUploadRequest;
    if(currentUser.userType! =="hirers"){
      imageUploadRequest = htp.MultipartRequest('POST', Uri.parse(baseUrl +   Paths.profile));
      imageUploadRequest.headers.addAll(header);
    }else{
       imageUploadRequest =
      htp.MultipartRequest('POST', Uri.parse(baseUrl +  Paths.ownersProfile));
      imageUploadRequest.headers.addAll(header);
    }

    //  imageUploadRequest.fields['UserType'] = currentUser.userInformation.roleId;

    // Attach the file in the request
    if (displayPicture != "") {
      catalogueFile =
          await htp.MultipartFile.fromPath('hirers_path', displayPicture);
      //print(catalogueFile);
      imageUploadRequest.files.add(catalogueFile);
    }

    if (kyc_document_path != "") {
      meansOfId =
      await htp.MultipartFile.fromPath('kyc_document_path', kyc_document_path);
      //print(catalogueFile);
      imageUploadRequest.files.add(meansOfId);
    }

if(kyc_name == ""){
  imageUploadRequest.fields['address'] = address;
  imageUploadRequest.fields['gender'] = gender;
  imageUploadRequest.fields['latitude'] = lat;
  imageUploadRequest.fields['longitude'] = lng;
}else{
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

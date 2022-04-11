
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';

class Authentication {
  final NavigationService _navigationService = locator<NavigationService>();

  // late SignInResponse _currentUser;
  // SignInResponse get currentUser => _currentUser;
  //
  // WalletBalance? _walletBalance;
  // WalletBalance? get walletBalance => _walletBalance;
  //
  // late String _phoneNumber;
  // String get phoneNumber => _phoneNumber;
  //
  // late String _userId;
  // String get userId => _userId;
  //
  // late AuthModel _token;
  // AuthModel get token => _token;
  //
  // saveRegPhone(String phone) async {
  //   _phoneNumber = phone;
  // }
  //
  // login(Map<dynamic, dynamic> payload) async {
  //   try {
  //     final result = await http.post(Paths.login, payload);
  //     if (result is ErrorModel) {
  //       return ErrorModel(result.error);
  //     }
  //
  //     final AuthModel auth = AuthModel.fromJson(result.data['result']['token']);
  //     _token = auth;
  //     SignInResponse user =
  //         SignInResponse.fromJson(result.data['result']['userInformation']);
  //     showToast(result.data['message']);
  //     _currentUser = user;
  //     _userId = user.id!;
  //     SharedPreferences prefs;
  //     prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('token', auth.token);
  //     await prefs.setString('userId', user.id.toString());
  //     await prefs.setString("profile", json.encode(user));
  //     //print('firstname' + user.firstName!);
  //     // return SuccessModel({'auth': auth, 'user': user});
  //     walletBalanceCall();
  //     return SuccessModel(user);
  //   } catch (e) {
  //     return ErrorModel('Login failed, try again.');
  //   }
  // }
  //
  // alreadyLoggedIn() async {
  //   SharedPreferences prefs;
  //   prefs = await SharedPreferences.getInstance();
  //   var d = prefs.getString('profile');
  //   SignInResponse user = SignInResponse.fromJson(json.decode(d!));
  //   _currentUser = user;
  //   _userId = user.id!;
  //   var t = prefs.getString('token');
  //   final AuthModel auth = AuthModel.fromJson(t!);
  //   //   print("TOKEN AGBA::::::::: ${auth.token}");
  //   _token = auth;
  //   walletBalanceCall();
  //   _navigationService.navigateReplacementTo(bookDeliveryRoute);
  //   return SuccessModel(user);
  // }
  //
  // resendOtp(String userName) async {
  //   try {
  //     final result = await http.get(Paths.resendVerifyCode + userName);
  //     if (result is ErrorModel) {
  //       return ErrorModel(result.error);
  //     }
  //
  //     return SuccessModel(result.data);
  //   } catch (e) {
  //     return ErrorModel('$e');
  //   }
  // }
  //
  // signUp(Map<dynamic, dynamic> payload) async {
  //   try {
  //     final result = await http.post(Paths.signUp, payload);
  //     if (result is ErrorModel) {
  //       return ErrorModel(result.error);
  //     }
  //
  //     _userId = result.data["result"]["id"];
  //     _navigationService.navigateTo(verificationViewRoute,
  //         arguments: result.data["result"]["email"]);
  //     // SignInResponse user = SignInResponse.fromJson(result.data['data']);
  //     // showToast(result.data['message']);
  //     // _currentUser = user;
  //     // SharedPreferences prefs;
  //     // prefs = await SharedPreferences.getInstance();
  //     // //  await prefs.setString('token', auth.token);
  //     // await prefs.setString('userId', user.id.toString());
  //     // await prefs.setString("userDetails", json.encode(user));
  //     // print('firstname' + user.firstName);
  //     // // return SuccessModel({'auth': auth, 'user': user});
  //     return SuccessModel(result.data);
  //   } catch (e) {
  //     return ErrorModel('$e');
  //   }
  // }
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
  // forgotPassword(Map<dynamic, dynamic> payload) async {
  //   try {
  //     final result = await http.post(Paths.forgotPassword, payload);
  //     if (result is ErrorModel) {
  //       return ErrorModel(result.error);
  //     }
  //     _userId = result.data["result"]["id"];
  //
  //     showToast(result.data['message']);
  //
  //     return SuccessModel(result.data);
  //   } catch (e) {
  //     return ErrorModel('$e');
  //   }
  // }
  //
  // verifyForgotPassword(Map<dynamic, dynamic> payload) async {
  //   try {
  //     final result = await http.post(Paths.forgotPasswordVerify, payload);
  //     if (result is ErrorModel) {
  //       return ErrorModel(result.error);
  //     }
  //
  //     showToast(result.data['message']);
  //
  //     return SuccessModel(result.data);
  //   } catch (e) {
  //     return ErrorModel('$e');
  //   }
  // }
  //
  // packageList() async {
  //   try {
  //     final result = await http.get(Paths.packageType);
  //     if (result is ErrorModel) {
  //       print("ERROR");
  //       print(result.error);
  //       return ErrorModel(result.error);
  //     }
  //     //  print("RESULT");
  //     // print(result.data['result1']);
  //     return SuccessModel(result.data['result1']);
  //   } catch (e) {
  //     print(e.toString());
  //     return ErrorModel('$e');
  //   }
  // }
  //
  // getRideModes() async {
  //   try {
  //     final result = await http.get(Paths.vehicles);
  //     if (result is ErrorModel) {
  //       print("ERROR");
  //       var data = result.error;
  //       print(result.error);
  //       List<VehicleLists> packageList = List<VehicleLists>.from(
  //           data.map((item) => VehicleLists.fromJson(item)));
  //       return ErrorModel(packageList);
  //     }
  //     var data = result.data["result"];
  //     List<VehicleLists> packageList = List<VehicleLists>.from(
  //         data.map((item) => VehicleLists.fromJson(item)));
  //     // print(packageList);
  //     return packageList;
  //   } catch (e) {
  //     print(e.toString());
  //     return ErrorModel('$e');
  //   }
  // }
  //
  // fetchChat(String carrierId, String deliveryId) async {
  //   try {
  //     final result = await http.get(Paths.fetchChat + "${currentUser.id}&CarrierId=$carrierId&DeliveryId=$deliveryId");
  //     if (result is ErrorModel) {
  //       print("ERROR");
  //       var data = result.error;
  //       print(result.error);
  //       List<ChatMessages> packageList = List<ChatMessages>.from(
  //           data.map((item) => ChatMessages.fromJson(item)));
  //       return ErrorModel(packageList);
  //     }
  //     var data = result.data["result1"];
  //     List<ChatMessages> packageList = List<ChatMessages>.from(
  //         data.map((item) => ChatMessages.fromJson(item)));
  //     // print(packageList);
  //     return packageList;
  //   } catch (e) {
  //     print(e.toString());
  //     return ErrorModel('$e');
  //   }
  // }
  //
  // walletBalanceCall() async {
  //   try {
  //     final result = await http.post(Paths.walletBalance + currentUser.id!, {});
  //     if (result is ErrorModel) {
  //       print("ERROR");
  //       print(result.error);
  //
  //       return ErrorModel(result.error);
  //     }
  //     //  print("RESULT");
  //     print(result.data);
  //     //  return   _walletBalance
  //     // VerifyOtpResponse verifyOtpResponse =
  //     //     VerifyOtpResponse.fromJson(result.data);
  //     WalletBalance walletBalance =
  //         WalletBalance.fromJson(result.data['result']);
  //     _walletBalance = walletBalance;
  //     return SuccessModel(result.data);
  //   } catch (e) {
  //     print(e.toString());
  //     return ErrorModel('$e');
  //   }
  // }
  //
  // requestCarrier(Map<dynamic, dynamic> payload) async {
  //   try {
  //     final result = await http.post(Paths.requestCarrier, payload);
  //     if (result is ErrorModel) {
  //       return ErrorModel(result.error);
  //     }
  //
  //     showToast(result.data['message']);
  //
  //     return SuccessModel(result.data);
  //   } catch (e) {
  //     return ErrorModel('$e');
  //   }
  // }
}

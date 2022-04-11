import 'package:equipro/utils/http/api_keys.dart';

class Paths {

  //  API ENDPOINTS

  static const String signUp = 'Account/UserEditCreate/UserEditCreate';
  static const String verifyCode = 'Utility/VerifyCode/VerifyCode';
  static const String resendVerifyCode = 'Utility/SendVerifyCode/SendVerifyCode?Username=';
  static const String login = 'Account/Login/Login';
  static const String forgotPassword = 'Account/ForgetPassword/ForgetPassword';
  static const String forgotPasswordVerify = 'Account/ForgetPassword2/ForgetPassword2';
  static const String changePassword = 'Account/ChangePassword/ChangePassword';
  static const String verifyForgot = 'Account/Login/Login';
  static const String vehicles = 'VehicleType/GetAllVehicleTypes/GetAllVehicleTypes';
  static const String packageType = 'Utility/PackageType/PackageType';
  static const String walletBalance = 'Payment/WalletBalance/WalletBalance?UserId=';
  static const String walletHistory = 'Payment/WalletHistory/WalletHistory?UserId=';
  static const String requestCarrier = 'CarriageRequest/LogUpdateCarriageRequest/Log-Update-CarriageRequest';
  static const String fetchChat = 'Message/Chat/UserCarrierChat?UserId=';


}

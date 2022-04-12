import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class ProfileViewModel extends BaseModel {
  final Authentication _authentication = locator<Authentication>();
  final NavigationService _navigationService = locator<NavigationService>();
  // signUp(SignUpModel signUpModel) async {
  //   setBusy(true);
  //   var result = await _authentication.signUp(signUpModel.toJson());
  //
  //   if (result is ErrorModel) {
  //     setBusy(false);
  //     showErrorToast(result.error);
  //     notifyListeners();
  //     return ErrorModel(result.error);
  //   }
  //   if (result is SuccessModel) {
  //     setBusy(false);
  //
  //     notifyListeners();
  //     return SuccessModel(result.data);
  //   }
  // }
  //
  // verifyOTP(VerifyPayload verifyPayload) async {
  //   setBusy(true);
  //   var result = await _authentication.verifyOtp(verifyPayload.toJson());
  //
  //   if (result is ErrorModel) {
  //     setBusy(false);
  //     showErrorToast(result.error);
  //     notifyListeners();
  //     return ErrorModel(result.error);
  //   }
  //   if (result is SuccessModel) {
  //     setBusy(false);
  //     _navigationService.navigateTo(loginRoute);
  //     notifyListeners();
  //     return SuccessModel(result.data);
  //   }
  // }
  //
  // resendVerifyOTP(String userName) async {
  //   setBusy(true);
  //   var result = await _authentication.resendOtp(userName);
  //
  //   if (result is ErrorModel) {
  //     setBusy(false);
  //     showErrorToast(result.error);
  //     notifyListeners();
  //     return ErrorModel(result.error);
  //   }
  //   if (result is SuccessModel) {
  //     setBusy(false);
  //     //_navigationService.navigateTo(verificationViewRoute);
  //     notifyListeners();
  //     return SuccessModel(result.data);
  //   }
  // }
  String? phoneNumber;
  Future setPhoneNumber({
    required String? phoneNumber,
  }) async {
    print("Called!!!");
    this.phoneNumber = phoneNumber;

    //setBusy(true);

    //_authenticationService.currentUser.phone = phoneNumber;
    //  final SharedPreferences prefs = await SharedPreferences.getInstance();
    //  await prefs.setString('phoneNumber', phoneNumber);
    notifyListeners();

    // setBusy(false);
  }
  String sanitizePhoneNumberInput(String phoneNumberInput) {
    if (phoneNumberInput.startsWith('0')) {
      phoneNumberInput = phoneNumberInput.toString().substring(1);
    }

    return phoneNumberInput;
  }
}

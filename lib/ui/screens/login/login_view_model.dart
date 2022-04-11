import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class LoginViewModel extends BaseModel {
  final Authentication _authentication = locator<Authentication>();
  final NavigationService _navigationService = locator<NavigationService>();

  // signIn(LoginPayload signInBody) async {
  //   // print('dhdhd');
  //   setBusy(true);
  //   var result = await _authentication.login(signInBody.toJson());
  //
  //   if (result is ErrorModel) {
  //     setBusy(false);
  //     showErrorToast(result.error);
  //     notifyListeners();
  //     return ErrorModel(result.error);
  //   }
  //   if (result is SuccessModel) {
  //     setBusy(false);
  //     _navigationService.navigateTo(bookDeliveryRoute);
  //     notifyListeners();
  //     return SuccessModel(result.data);
  //   }
  // }
  //
  // forgotPassword(ForgotPassword forgotPassword) async {
  //   // print('dhdhd');
  //   setBusy(true);
  //   var result = await _authentication.forgotPassword(forgotPassword.toJson());
  //
  //   if (result is ErrorModel) {
  //     setBusy(false);
  //     showErrorToast(result.error);
  //     notifyListeners();
  //     return ErrorModel(result.error);
  //   }
  //   if (result is SuccessModel) {
  //     setBusy(false);
  //     _navigationService.navigateTo(verifyForgotPasswordRoute);
  //     notifyListeners();
  //     return SuccessModel(result.data);
  //   }
  // }
  //
  // verifyForgotPassword(VerifyForgotPassword verifyForgotPassword) async {
  //   // print('dhdhd');
  //   setBusy(true);
  //   var result = await _authentication.forgotPassword(verifyForgotPassword.toJson());
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
}

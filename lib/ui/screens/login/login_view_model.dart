import 'package:equipro/app/app_setup.router.dart';
import 'package:equipro/core/model/LoginPayload.dart';
import 'package:equipro/core/model/VerifyForgotPassword.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
// import 'package:equipro/utils/locator.dart';
// import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';

class LoginViewModel extends BaseViewModel with BusyMixin {
  final Authentication _authentication = locator<Authentication>();
  final _navigationService = locator<NavigationService>();

  signIn(LoginPayload signInBody, context) async {
    // print('dhdhd');
    setBusy(true);
    var result = await _authentication.login(signInBody.toJson());

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error, context: context);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.clearStackAndShow(Routes.home);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  void newForgotPassword(String email, context) async {}

  forgotPassword(String email, context) async {
    // print('dhdhd');
    setBusy(true);
    var result = await _authentication.forgotPassword({"email": email});

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error, context: context);
      notifyListeners();
      return ErrorModel(
        result.error,
      );
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.navigateTo(VerifyForgotPasswordPageRoute,
          arguments: email);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  verifyForgotPassword(
      VerifyForgotPassword verifyForgotPassword, context) async {
    // print('dhdhd');
    setBusy(true);
    var result = await _authentication
        .verifyForgotPassword(verifyForgotPassword.toJson());

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error, context: context);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.clearStackAndShow(Routes.login);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }
}

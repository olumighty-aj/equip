import 'package:equipro/core/api/api_constants.dart';
import 'package:equipro/core/api/dio_service.dart';
import 'package:equipro/core/model/LoginPayload.dart';
import 'package:equipro/core/model/VerifyForgotPassword.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/core/services/shared_prefs.dart';
import 'package:equipro/ui/screens/login/login_view.dart';
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.logger.dart';
import '../../../app/app_setup.router.dart';
import '../../../utils/notification_helper.dart';

class NewLoginViewModel extends BaseViewModel {
  final _log = getLogger("NewLoginViewModel");
  final Authentication _authentication = locator<Authentication>();
  final _navigationService = locator<NavigationService>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  void togglePassword() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  String? fcmToken;

  init() {
    getFCMToken();
  }

  getFCMToken() async {
    fcmToken = await NotificationHelper.getFcmToken();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      // _navigationService
      //     .pushAndRemoveUntil(homeRoute);
      signIn(LoginPayload(
          email: emailController.text,
          password: passwordController.text,
          fcmToken: fcmToken));
    }
  }

  signIn(LoginPayload signInBody) async {
    // print('dhdhd');
    _log.i(signInBody.toJson());
    setBusy(true);
    var result = await _authentication.login(signInBody.toJson());

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.pushNamedAndRemoveUntil(homeRoute);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  void newSignIn(context) async {
    if (formKey.currentState!.validate()) {
      LoginPayload data = LoginPayload(
          email: emailController.text,
          password: passwordController.text,
          fcmToken: fcmToken);
      var res = await runBusyFuture(_authentication.newLogin(data.toJson()),
          busyObject: "Login");
      _log.i(res?.toJson());
      if (res != null) {
        if (res.status == true) {
          _log.i(res.payload.toString());
          locator<ApiService>().setAccessToken(res.payload["token"]);
          _authentication.setCurrentUser(res.payload["details"]);
          SharedPrefsClient.saveData("token", res.payload["token"]);
          ApiConstants.token = res.payload["token"];
          _navigationService.clearStackAndShow(Routes.home);
        } else {
          showErrorToast(
              res.message?.toUpperCase() ?? "Failed, please try again",
              context: context);
        }
      }
    }
  }

  forgotPassword(String email) async {
    // print('dhdhd');
    setBusy(true);
    var result = await _authentication.forgotPassword({"email": email});

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.navigateTo(VerifyForgotPasswordPageRoute,
          arguments: email);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  verifyForgotPassword(VerifyForgotPassword verifyForgotPassword) async {
    // print('dhdhd');
    setBusy(true);
    var result = await _authentication
        .verifyForgotPassword(verifyForgotPassword.toJson());

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      _navigationService.pushNamedAndRemoveUntil(loginRoute);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }
}

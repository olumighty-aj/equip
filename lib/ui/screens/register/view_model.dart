import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../app/app_setup.logger.dart';
import '../../../app/app_setup.router.dart';
import '../../../core/model/SignUpModel.dart';
import '../../../core/model/base_model/base_model.dart';
import '../../../core/model/error_model.dart';
import '../../../core/model/success_model.dart';
import '../../../core/services/auth_service.dart';
import '../../../utils/helpers.dart';
import '../../../utils/router/route_names.dart';

class NewRegisterViewModel extends BaseViewModel {
  final _log = getLogger("NewRegisterViewModel");
  final _authentication = locator<Authentication>();
  final _navigationService = locator<NavigationService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool passwordVisible;
  String countryCode = "234";
  TextEditingController controller = TextEditingController();
  int maxLength = 10;
  String initialSelection = '+234';

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  signUp(SignUpModel signUpModel) async {
    setBusy(true);
    var result = await _authentication.signUp(signUpModel.toJson());

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
      showToast(result.data['message']);
      _navigationService.replaceWith(loginRoute);
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  void newSignUp(context) async {
    SignUpModel data = SignUpModel(
        fullname: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        password: passwordController.text);
    BaseDataModel? res = await runBusyFuture(
        _authentication.newRegister(data.toJson()),
        busyObject: "Register");
    _log.i(res?.toJson());
    if (res != null) {
      if (res.status == true) {
        _log.i(res.payload.toString());
        showToast(res.message!, context: context);
        _navigationService.clearStackAndShow(Routes.login);
      } else {
        showErrorToast(res.message?.toUpperCase() ?? "Failed, please try again",
            context: context);
      }
    }
  }

  // bool isStrongPassword(String password) {
  // Define a regular expression for a strong password
  // RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}|;:\'",.<>?/\\~-]).{8,}$',);

  // Test if the password matches the regex
  // return regex.hasMatch(password);
  // }

  bool validatePassword(String password) {
    // Reset error message
    _errorMessage = '';
    // Password length greater than 6
    if (password.length < 6) {
      _errorMessage += 'Password must be longer than 6 characters.\n';
    }
    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _errorMessage += '• Uppercase letter is missing.\n';
    }
    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      _errorMessage += '• Lowercase letter is missing.\n';
    }
    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      _errorMessage += '• Digit is missing.\n';
    }
    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      _errorMessage += '• Special character is missing.\n';
    }
    // If there are no error messages, the password is valid
    return _errorMessage.isEmpty;
  }

  String? phoneNumber;
  setPhoneNumber({
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

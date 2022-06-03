import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class EarningsViewModel extends BaseModel {
  final Authentication _authentication = locator<Authentication>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Activities _activities = locator<Activities>();





  withdraw(String amount,) async {
    setBusy(true);
    var result = await _activities.withdraw( amount);

    if (result is ErrorModel) {
      setBusy(false);
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      setBusy(false);
_navigationService.pop();
      notifyListeners();
      return SuccessModel(result.data);
    }
  }
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
}

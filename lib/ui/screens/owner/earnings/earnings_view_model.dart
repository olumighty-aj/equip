import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/core/services/payment_services.dart';
import 'package:equipro/utils/base_model.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class EarningsViewModel extends BaseModel {
  final Authentication _authentication = locator<Authentication>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Activities _activities = locator<Activities>();
  final PaymentService _paymentService = locator<PaymentService>();





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

  getWalletBalance() async {
    var result = await _paymentService.getWalletBalance();

    if (result is ErrorModel) {
      showErrorToast(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      notifyListeners();
      return SuccessModel(result.data);
    }
  }
}

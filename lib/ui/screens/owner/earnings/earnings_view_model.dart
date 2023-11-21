import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/model/base_model.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../../../../core/model/TransactionModel.dart';

class EarningsViewModel extends BaseModel {
  final Authentication _authentication = locator<Authentication>();
  final NavService _navigationService = locator<NavService>();
  final Activities _activities = locator<Activities>();
  final PaymentService _paymentService = locator<PaymentService>();

  TransactionModel? wallet;

  withdraw(
    String amount,
  ) async {
    setBusy(true);
    var result = await _activities.withdraw(amount);

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

  getWalletBalance(context) async {
    var result = await _paymentService.getWalletBalance();

    if (result is ErrorModel) {
      showErrorToast(result.error, context: context);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      notifyListeners();
      return SuccessModel(result.data);
    }
  }

  void newGetWalletBalance(context) async {
    BaseDataModel res = await _paymentService.newGetWalletBalance();
    if (res.status == true) {
      wallet = TransactionModel.fromJson(res.payload);
      notifyListeners();
    } else {
      showErrorToast(res.message ?? "", context: context);
    }
  }

  initializePlugin() {
    _paymentService.plugin.initialize(
        publicKey: "pk_test_fd910a18fdbd3179caf61247de74df500b290b0e");
  }

  getContext(BuildContext context) {
    _paymentService.contextB = context;
    notifyListeners();
  }

  fundWallet(
      GlobalKey<FormState> formkey, CheckoutMethod method, int amount) async {
    formkey.currentState?.save();
    //setBusy(true);

    var result = await _paymentService.handleCheckout(method, amount);
    if (result is ErrorModel) {
      //setBusy(false);
      showErrorToast(result.error);
      print(result.error);
      notifyListeners();
      return ErrorModel(result.error);
    }
    if (result is SuccessModel) {
      //setBusy(false);
      // showToast('Payment Successfully');
      notifyListeners();
    }
  }
}

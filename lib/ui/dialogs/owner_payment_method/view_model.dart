import 'package:equipro/app/app_setup.locator.dart';
import 'package:equipro/core/model/base_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class PaymentMethodViewModel extends BaseViewModel {
  final _activities = locator<Activities>();
  final user = locator<Authentication>();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  addPaymentMethod(context) async {
    BaseDataModel? model = await runBusyFuture(
        _activities.addPaymentMethod({
          "account_name": accountNameController.text,
          "account_number": accountNumberController.text,
          "bank_name": bankNameController.text,
          "owners_id": user.currentUser.id,
          "status": "1"
        }),
        busyObject: "paymentMethod");
    if (model?.status == true) {
      showToast(model?.message ?? "Account successfully added",
          context: context);
      return true;
    } else {
      showErrorToast(model?.message ?? "", context: context);
      return false;
    }
  }
}

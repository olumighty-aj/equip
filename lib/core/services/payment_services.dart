import 'package:dio/dio.dart';
import 'package:equipro/core/api/dio_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/utils/http/paths.dart';
import 'package:equipro/utils/locator.dart';
import 'package:uuid/uuid.dart';

import '../model/base_model.dart';

class PaymentService {
  // PaystackPlugin plugin = PaystackPlugin();
  final _api = locator<ApiService>();
  late BuildContext contextB;
  BuildContext get context => contextB;
  final Authentication authentication = locator<Authentication>();
  var uuid = Uuid();

  //response after payment
  // late CheckoutResponse _response;
  // CheckoutResponse get response => _response;

  //process payment
  // handleCheckout(CheckoutMethod method, int amount) async {
  //   Charge charge = Charge()
  //     ..amount = amount * 100
  //     ..email = authentication.currentUser.email
  //     ..reference = uuid.v4();
  //
  //   if (method == CheckoutMethod.bank) {
  //     charge.accessCode = uuid.v4();
  //   } // In base currency
  //
  //   try {
  //     _response = await plugin.checkout(
  //       context,
  //       method: method,
  //       charge: charge,
  //       fullscreen: false,
  //       logo: MyLogo(),
  //     );
  //     print('Response = $_response');
  //     if (_response.message == "Success") {
  //       final reference = _response.reference;
  //       updateStatus(reference!, _response.message);
  //       return SuccessModel(_response.message);
  //     } else {
  //       ErrorModel('Payment Failed');
  //     }
  //   } catch (e) {
  //     showMessage("Check console for error");
  //     ErrorModel('failed');
  //     rethrow;
  //   }
  // }

  getWalletBalance() async {
    try {
      final result = await http.get(Paths.earnings);
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }
      return SuccessModel(result.data[""]);
    } catch (e) {
      return ErrorModel(e.toString() ==
              "SocketException: Failed host lookup: '$baseUrlError' (OS Error: nodename nor servname provided, or not known, errno = 8)"
          ? "Your internet is not stable kindly reconnect and try again"
          : e.toString() ==
                  "TimeoutException after 0:00:40.000000: Future not completed"
              ? "Your internet is not stable kindly reconnect and try again"
              : e.toString());
    }
  }

  Future<BaseDataModel> newGetWalletBalance() async {
    Response res = await _api.getRequest(null, Paths.earnings);
    return BaseDataModel.fromJson(res.data);
  }
}

//update status
updateStatus(String reference, String message) {
  showMessage('Reference: $reference \n\ Response: $message',
      const Duration(seconds: 7));
}

showMessage(String message, [Duration duration = const Duration(seconds: 4)]) {
  // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
  //   content: new Text(message),
  //   duration: duration,
  //   action: new SnackBarAction(
  //       label: 'CLOSE',
  //       onPressed: () =>
  //           ScaffoldMessenger.of(context).removeCurrentSnackBar()),
  // ));
  print(message);
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        'assets/images/logo.png',
      ),
    );
  }
}

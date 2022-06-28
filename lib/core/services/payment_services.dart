import 'package:flutter/material.dart';
import 'package:place_picker/uuid.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/utils/http/paths.dart';
import 'package:equipro/utils/locator.dart';

class PaymentService {
  // PaystackPlugin plugin = PaystackPlugin();
  // late BuildContext contextB;
  // BuildContext get context => contextB;
  // final Authentication authentication = locator<Authentication>();
  // var uuid = Uuid();
  //
  // //response after payment
  // late CheckoutResponse _response;
  // CheckoutResponse get response => _response;

  // bool get isLocal => referenceNo.isEmpty;
  // walletHistory() async {
  //   try {
  //     final result =
  //         await http.post(Paths.walletHistory + authentication.currentUser.id!, {});
  //     if (result is ErrorModel) {
  //       var data = result.error;
  //       print(result.error);
  //       List<WalletHistoryModel> packageList = List<WalletHistoryModel>.from(
  //           data.map((item) => WalletHistoryModel.fromJson(item)));
  //       return ErrorModel(packageList);
  //     }
  //     var data = result.data['result1'];
  //     List<WalletHistoryModel> packageList = List<WalletHistoryModel>.from(
  //         data.map((item) => WalletHistoryModel.fromJson(item)));
  //     return packageList;
  //   } catch (e) {
  //     print(e.toString());
  //     return ErrorModel('$e');
  //   }
  // }

  //process payment
//   handleCheckout(CheckoutMethod method, int amount) async {
//     Charge charge = Charge()
//       ..amount = amount * 100
//       ..email = authentication.currentUser.email
//       ..reference = uuid.generateV4();
//
//
//     if (method == CheckoutMethod.bank) {
//       charge.accessCode = uuid.generateV4();
//     } // In base currency
//
//     try {
//       _response = await plugin.checkout(
//         context,
//         method: method,
//         charge: charge,
//         fullscreen: false,
//         logo: MyLogo(),
//       );
//       print('Response = $_response');
//       if( _response.message =="Success"){
//         final reference = _response.reference;
//         _updateStatus(reference!, _response.message);
//         authentication.walletBalanceCall();
//         return SuccessModel(_response.message);
//       }else{
//         ErrorModel('Payment Failed');
//       }
//     } catch (e) {
//       _showMessage("Check console for error");
//       ErrorModel('failed');
//       rethrow;
//     }
//   }
// }
//
// //update status
// _updateStatus(String reference, String message) {
//   _showMessage('Reference: $reference \n\ Response: $message',
//       const Duration(seconds: 7));
// }
//
// _showMessage(String message, [Duration duration = const Duration(seconds: 4)]) {
//   // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
//   //   content: new Text(message),
//   //   duration: duration,
//   //   action: new SnackBarAction(
//   //       label: 'CLOSE',
//   //       onPressed: () =>
//   //           ScaffoldMessenger.of(context).removeCurrentSnackBar()),
//   // ));
//   print(message);
// }

// _verifyOnServer(String reference) async {
//   _updateStatus(reference, 'Verifying...');
//   String url = 'https://api.paystack.co/transaction/verify/$reference';
//   try {
//     final response = await http
//         .get(url, {'Authorization': 'Bearer $paystackPublicKey'});
//     if (response.data is ErrorModel) {
//       print("ERROR");
//       print(response.error);
//       return ErrorModel(response.error);
//     }
//     var body = response.data;
//     print(body);
//     _updateStatus(reference, body);
//   } catch (e) {
//     _updateStatus(
//         reference,
//         'There was a problem verifying %s on the backend: '
//         '$reference $e');
//     return ErrorModel('Transaction error');
//   }
// }


// class MyLogo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: 60,
//       padding: const EdgeInsets.all(10),
//       child: Image.asset(
//         'assets/images/logo.png',
//       ),
//     );
//   }

  getWalletBalance() async {
    try {
      final result = await http.get(Paths.earnings);
      if (result is ErrorModel) {
        return ErrorModel(result.error);
      }
      return SuccessModel(result.data["payload"]["content"]);
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
}

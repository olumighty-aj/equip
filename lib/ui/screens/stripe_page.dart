import 'dart:convert';
import 'package:equipro/ui/screens/hirer/home/home_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stacked/stacked.dart';
import '../../../utils/locator.dart';

class StripePage extends StatefulWidget {
  const StripePage({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StripePage> {
  Map<String, dynamic>? paymentIntentData;
  TextEditingController payController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  HomeViewModel model = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        onModelReady: (v) async {

        },
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              body: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                size: 30,
                              ),
                            ),
                            Text(

                                "Add Funds",

                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Container(),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                  "Amount",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: payController,
                                    // maxLength: 11,
                                    validator: Validators().isEmpty,
                                    decoration: InputDecoration(
                                      hintText: '\$100',
                                      hintStyle: TextStyle(
                                        color: Colors.black45,
                                      ),
                                      labelStyle: TextStyle(
                                          color: AppColors.lowGrey),
                                      focusColor: AppColors.lowGrey,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(5.0),
                                          borderSide:
                                          BorderSide(color: AppColors.grey)),
                                    ),
                                    onChanged: (v) {
                                      setState(() {});
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                  ),
                                ])),
                        SizedBox(
                          height: 40,
                        ),
                        loading ?
                        Center(
                            child:
                            CircularProgressIndicator(
                              color: AppColors.primaryColor,)) :
                        GeneralButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await makePayment();
                            }
                          },
                          buttonText:
                            "Pay",

                        ),
                      ])));
        });
  }
  final billingDetails = BillingDetails(
    email: 'mayomidedaniel@gmail.com',
    phone: '+2348169545791',
    name: 'Makdan',
    address: Address(
      city: 'Lekki',
      country: 'NGN',
      line1: 'Ajah',
      line2: '',
      state: 'Lagos',
      postalCode: '77063',
    ),
  );

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent(
          payController.text, 'USD'); //json.decode(response.body);
      print('Response body==>$paymentIntentData');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData!['client_secret'],
                  // applePay: false,
                  // googlePay: false,
                  // testEnv: true,
                  style: ThemeMode.dark,
                 billingDetails:billingDetails,
                 // BillingDetails(
                 //   email: "mayomidedaniel@gmail.com",
                 //       phone: "0811111111"
                 // ),
                  // Customer keys
//           customerEphemeralKeySecret: data['ephemeralKey'],
//           customerId: data['customer'],
                  //merchantCountryCode: 'US',
                  merchantDisplayName: 'EQUIPRO'))
          .then((value) {
        setState(() {
          loading = false;
        });
        displayPaymentSheet();
      });

      ///now finally display payment sheeet
      if (paymentIntentData != null) {}
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print('payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
      //  model.sendPay(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Top up successful",style: TextStyle(color: Colors.black),),backgroundColor: AppColors.backgroundColor,));
        //Navigator.pop(context);
        _navigationService.navigateReplacementTo(homeRoute);
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    setState(() {
      loading = true;
    });
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(payController.text),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            //'Bearer sk_test_51HHcsiHPcurTn6FWu5mUguRfzFHQZnuzJVsoKATWbukdrUkTWX3kweZx5etJcuT2uaUXDcHI6nUSQg8gbtIqNElB006OsipEVH',
            'Bearer sk_test_51L0jt8G94I07zh2uaEV1jI5rWguvw4xtmQ1RfaLpWKfc0P8IsvAb4QpNqtb08R2Bv2KEq3XbbIsfX9Vco9h0jYF400jxx3EZTA',
           // 'Bearer sk_test_51KUCzbGXwaK1yW2oABr1bTyBbzHmbx3kTamKx9t8lE0lHsn2UMzuONZArqgdug6uClg78LVg2SpBEnmesjKDZJIq00d7qIviHS',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      //model.sendPay(json.decode(response.body)["id"]);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

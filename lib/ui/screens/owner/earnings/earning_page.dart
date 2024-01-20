import 'package:dotted_border/dotted_border.dart';
import 'package:equipro/core/model/TransactionModel.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/hirer/book/details_view_model.dart';
import 'package:equipro/ui/screens/owner/earnings/earnings_view_model.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/extensions.dart';
import 'package:equipro/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../../utils/app_svgs.dart';
import '../../../widget/base_button.dart';

class EarningPage extends StatefulWidget {
  const EarningPage({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EarningPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectedQuantity;
  String? pickupTime = DateTime.now().toString();
  String? selectedDate;
  String? selectedWeek;
  TextEditingController emailController = TextEditingController();
  AnimationController? _navController;
  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _navController!.dispose();
    super.dispose();
  }

  TransactionModel? wallet;
  // getWalletBalance(EarningsViewModel model) async {
  //   var result = await model.getWalletBalance(context);
  //   if (result is SuccessModel) {
  //     setState(() {
  //       print(result.data);
  //       wallet = TransactionModel.fromJson(result.data);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EarningsViewModel>.reactive(
        onViewModelReady: (v) {
          v.init();
        },
        viewModelBuilder: () => EarningsViewModel(),
        builder: (context, model, child) {
          // if (wallet == null) {
          //   return Scaffold(
          //       backgroundColor: AppColors.grey,
          //       body: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [LoaderWidget(), LoaderWidget(), LoaderWidget()],
          //       ));
          // }
          return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                leading: CustomBackButton(),
              ),
              body: Builder(builder: (context) {
                if (!model.busy("Earnings") && model.earningsWallet != null) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Earnings",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 25, fontWeight: FontWeight.w800),
                          ),
                          Gap(29),
                          if (model.earningsWallet != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Your balance: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 15)),
                                  TextSpan(
                                      text:
                                          "${getCurrency(locator<Authentication>().currentUser.country)}${model.earningsWallet!["content"]["balance_amount"].toString().withCommas}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: 18,
                                              color: AppColors.primaryColor))
                                ])),
                                Gap(29),
                                Row(
                                  children: [
                                    Expanded(
                                      child: BaseButton(
                                        isBusy: model.busy("withdraw"),
                                        label: "Withdraw",
                                        hasBorder: true,
                                        onPressed: () =>
                                            model.newWithdraw(context),
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                  ],
                                ),
                                Gap(12),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Gap(32),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Payment Method",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    Visibility(
                                      visible: model.banks.isEmpty,
                                      child: GestureDetector(
                                        onTap: model.addPaymentMethod,
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      replacement: GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (model.banks["content"] != null &&
                                    model.banks["content"].isNotEmpty)
                                  Column(
                                    children: [
                                      Gap(20),
                                      PaymentMethodBox(
                                          bankDetails: model.banks["content"]
                                              [0]),
                                    ],
                                  ),
                                Gap(12),
                                Divider(color: Colors.grey),
                                Gap(32),
                                Text(
                                  "Transaction History",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                ),
                                Gap(24),
                                if (model
                                    .earningsWallet!["content"]
                                        ["transaction_history"]
                                    .isNotEmpty)
                                  Column(
                                    children: List.generate(
                                      model
                                          .earningsWallet!["content"]
                                              ["transaction_history"]
                                          .length,
                                      (index) => TransactionHistoryTile(
                                          transactions: model
                                                  .earningsWallet!["content"]
                                              ["transaction_history"][index],
                                          country: model.country!),
                                    ),
                                  ),
                                if (model
                                    .earningsWallet!["content"]
                                        ["transaction_history"]
                                    .isEmpty)
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AppSvgs.emptyChat),
                                      Gap(5),
                                      Text("No transactions have been made"),
                                    ],
                                  ),
                              ],
                            ),
                          // if (model.wallet == null)
                        ],
                      ),
                    ),
                  );
                } else if (model.busy("Earnings")) {
                  return Center(
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(200),
                      SvgPicture.asset(AppSvgs.emptyRental),
                      Gap(20),
                      Text("No information available")
                    ],
                  );
                }
              }));
        });
  }
}

class PaymentMethodBox extends StatelessWidget {
  final Map<String, dynamic> bankDetails;
  const PaymentMethodBox({
    required this.bankDetails,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [4, 4, 4],
      color: Colors.grey.shade400,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 29),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 37,
                color: Colors.white,
              ),
              Gap(10),
              Text(
                bankDetails["bank_name"],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 15),
              ),
            ],
          ),
          // SvgPicture.asset(AppSvgs.more)
        ],
      ),
    );
  }
}

class TransactionHistoryTile extends StatelessWidget {
  final Map<String, dynamic> transactions;
  final String country;
  const TransactionHistoryTile(
      {Key? key, required this.transactions, required this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              DateTime.parse(transactions["date_created"]).toDate(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.grey, fontSize: 10),
            ),
          ),
          Text(
            "${getCurrency(country)} ${transactions["amount"].toString().withCommas}",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.grey, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}

import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:equipro/core/model/TransactionModel.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/owner/earnings/earnings_view_model.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/widget/bank_tiles.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/booking_request.dart';
import 'package:equipro/ui/widget/dash_painter.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/ui/widget/loader_widget.dart';
import 'package:equipro/ui/widget/transaction_tile.dart';
import 'package:equipro/utils/extensions.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';

import '../../../../utils/app_svgs.dart';

class EarningPage extends StatefulWidget {
  const EarningPage({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EarningPage> with TickerProviderStateMixin {
  final NavService _navigationService = locator<NavService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectedQuantity;
  String? pickupTime = DateTime.now().toString();
  String? selectedDate;
  String? selectedWeek;
  TextEditingController emailController = TextEditingController();
  AnimationController? _navController;
  Animation<Offset>? _navAnimation;
  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    _navAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.99),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _navController!,
      curve: Curves.easeIn,
    ));
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
          v.getEarnings();
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
                                          "${getCurrency(locator<Authentication>().currentUser.country)}${model.earningsWallet!["content"]["balance_amount"].toString()}",
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
                                        label: "Withdraw",
                                        hasBorder: true,
                                        onPressed: null,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                  ],
                                ),
                                Gap(32),
                                Divider(
                                  color: Colors.grey,
                                ),
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
                                  Text("No transactions have been made"),
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
  const PaymentMethodBox({
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
                "Access Bank",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 15),
              ),
            ],
          ),
          SvgPicture.asset(AppSvgs.more)
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
            "${getCurrency(country)} ${transactions["amount"]}",
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

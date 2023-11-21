import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:equipro/core/model/TransactionModel.dart';
import 'package:equipro/core/model/success_model.dart';
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
  getWalletBalance(EarningsViewModel model) async {
    var result = await model.getWalletBalance(context);
    if (result is SuccessModel) {
      setState(() {
        print(result.data);
        wallet = TransactionModel.fromJson(result.data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EarningsViewModel>.reactive(
        onViewModelReady: (v) {
          v.newGetWalletBalance(context);
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
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Earnings",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                      Gap(29),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Your balance: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 15)),
                        TextSpan(
                            text: "5000",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 15,
                                    color: AppColors.primaryColor))
                      ])),
                      Gap(29),
                      Row(
                        children: [
                          Expanded(
                            child: BaseButton(
                              label: "Withdraw",
                              hasBorder: true,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                      Gap(32),
                      Divider(
                        color: Colors.grey,
                      ),
                      Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Methods",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                              child: Icon(
                            Icons.add,
                            color: AppColors.primaryColor,
                          ))
                        ],
                      ),
                      Gap(18),
                      Text(
                        "Preferred Method",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey, fontSize: 15),
                      ),
                      Gap(20),
                      PaymentMethodBox(),
                      Gap(45),
                      Divider(
                        color: Colors.grey,
                      ),
                      Gap(32),
                      Text(
                        "Transaction History",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Gap(24),
                      Column(
                        children: List.generate(
                            3, (index) => TransactionHistoryTile()),
                      )
                    ],
                  ),
                ),
              ));
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
  const TransactionHistoryTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "30 Oct 2021",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey, fontSize: 10),
                ),
                Gap(6),
                Text(
                  "Receipt: #27384595",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Gap(7),
                Text(
                  "Withdrawal",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.primaryColor, fontSize: 10),
                ),
              ],
            ),
          ),
          Text(
            "N2000",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

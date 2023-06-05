import 'package:badges/badges.dart';
import 'package:equipro/core/model/TransactionModel.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/owner/earnings/earnings_view_model.dart';
import 'package:equipro/ui/widget/bank_tiles.dart';
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
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';

class EarningPage extends StatefulWidget {
  const EarningPage({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EarningPage> with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
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
    var result = await model.getWalletBalance();
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
        onModelReady: (v) {
          getWalletBalance(v);
        },
        viewModelBuilder: () => EarningsViewModel(),
        builder: (context, model, child) {
          if (wallet == null) {
            return Scaffold(
              backgroundColor: AppColors.grey,
              body:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoaderWidget(),
                      LoaderWidget(),
                      LoaderWidget()
                    ],
                  )
             );
          }
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: AnimationLimiter(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 200),
                                childAnimationBuilder: (widget) =>
                                    SlideAnimation(
                                      horizontalOffset:
                                          -MediaQuery.of(context).size.width /
                                              4,
                                      child: FadeInAnimation(
                                          curve: Curves.fastOutSlowIn,
                                          child: widget),
                                    ),
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          //  margin: EdgeInsets.all(20),
                                          padding: EdgeInsets.only(left: 8),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: AppColors.white,
                                          ),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Icon(
                                                Icons.arrow_back_ios,
                                                color: AppColors.primaryColor,
                                              )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Earnings",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(children: [
                                    Text(
                                      "Your balance :",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      wallet!.balanceAmount.toString(),
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 150,
                                    child: GeneralButton(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      splashColor: Colors.white,
                                      buttonTextColor: AppColors.primaryColor,
                                      borderColor: AppColors.primaryColor,
                                      onPressed: () {
                                        _navigationService
                                            .navigateTo(WithdrawRoute);
                                      },
                                      buttonText: "Withdraw",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Divider(
                                  //   thickness: 1,
                                  // ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Payment Methods:",
                                  //       style: TextStyle(
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 15),
                                  //     ),
                                  //     IconButton(
                                  //         onPressed: () {},
                                  //         icon: Icon(
                                  //           Icons.add,
                                  //           size: 40,
                                  //           color: AppColors.primaryColor,
                                  //         ))
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Text(
                                  //   "Preferred Method",
                                  //   style: TextStyle(
                                  //       color: Colors.grey, fontSize: 15),
                                  // ),
                                  // SizedBox(
                                  //   height: 30,
                                  // ),
                                  // BankTile(),
                                  // SizedBox(
                                  //   height: 30,
                                  // ),
                                  // CustomPaint(painter: LineDashedPainter()),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Text(
                                    "Transaction History",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  wallet!.transactionHistory!.isNotEmpty
                                      ? Container(
                                          height:
                                              Responsive.height(context) / 2,
                                          child: ListView.builder(
                                              itemCount: wallet!
                                                  .transactionHistory!.length,
                                              itemBuilder: (context, i) {
                                                return TransactionTile(
                                                  model: wallet!
                                                      .transactionHistory![i],
                                                );
                                              }),
                                        )
                                      : Container(
                                          child: Text(
                                            "Not available",
                                          ),
                                        ),
                                ]))))),
          );
        });
  }
}

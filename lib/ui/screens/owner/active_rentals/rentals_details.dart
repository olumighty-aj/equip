import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/ui/screens/profile/profile_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/utils/colors.dart';

class RentalDetails extends StatefulWidget {
  final ActiveRentalsModel feed;
  const RentalDetails({Key? key, required this.feed}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<RentalDetails> with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, model, child) {
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
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.feed.equipments!
                                              .equipName!,
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        Container(
                                          width: 90,
                                          height: 30,
                                          child: GeneralButton(
                                            onPressed: () {},
                                            buttonText:
                                                toBeginningOfSentenceCase(widget
                                                    .feed.requestStatus!)!,
                                            buttonTextColor: AppColors.white,
                                            splashColor: widget
                                                        .feed.requestStatus! ==
                                                    "pending"
                                                ? Colors.blue
                                                : widget.feed.requestStatus! ==
                                                        "rejected"
                                                    ? AppColors.red
                                                    : widget.feed
                                                                .requestStatus! ==
                                                            "returned"
                                                        ? AppColors.green
                                                        : widget.feed
                                                                    .requestStatus! ==
                                                                "received"
                                                            ? AppColors.blue
                                                            : AppColors
                                                                .primaryColor,
                                          ),
                                        )
                                      ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    thickness: 4,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "View rental agreement",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Amount Paid:",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        widget.feed.equipOrder!.totalAmount!,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "QTY Hired:",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        widget.feed.equipOrder!.quantity!,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Rental Start Date:",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        widget.feed.rentalFrom != null
                                            ? DateFormat(
                                                "dd MMM, yyyy",
                                              )
                                                .format(DateTime.parse(
                                                    widget.feed.rentalFrom!))
                                                .toString()
                                            : "Unknown",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Rental End Date",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        widget.feed.rentalTo != null
                                            ? DateFormat(
                                                "dd MMM, yyyy",
                                              )
                                                .format(DateTime.parse(
                                                    widget.feed.rentalTo!))
                                                .toString()
                                            : "Unknown",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Return Location:",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "No 15, Yaba Surulere Lagos",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  // Text(
                                  //   "Equipment Delivery Status",
                                  //   style: TextStyle(
                                  //       color: Colors.grey,
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 18),
                                  // ),
                                  // Divider(
                                  //   thickness: 2,
                                  // ),
                                  // SizedBox(
                                  //   height: 30,
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Row(children: [
                                  //           Column(
                                  //             children: [
                                  //               CircleAvatar(
                                  //                 radius: 4,
                                  //                 backgroundColor:
                                  //                     AppColors.primaryColor,
                                  //               ),
                                  //               Container(
                                  //                 height: 20,
                                  //                 width: 2,
                                  //                 color: AppColors.primaryColor,
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             width: 15,
                                  //           ),
                                  //           Text(
                                  //             "Pending",
                                  //             style: TextStyle(
                                  //                 color: Colors.black,
                                  //                 fontWeight: FontWeight.w500,
                                  //                 fontSize: 18),
                                  //           ),
                                  //         ]),
                                  //         Text(
                                  //           "28 Aug, 2022",
                                  //           style: TextStyle(
                                  //               color: Colors.grey,
                                  //               fontWeight: FontWeight.w500,
                                  //               fontSize: 18),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Row(children: [
                                  //           Column(
                                  //             children: [
                                  //               CircleAvatar(
                                  //                 radius: 4,
                                  //                 backgroundColor:
                                  //                     AppColors.primaryColor,
                                  //               ),
                                  //               Container(
                                  //                 height: 20,
                                  //                 width: 2,
                                  //                 color: AppColors.primaryColor,
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             width: 15,
                                  //           ),
                                  //           Text(
                                  //             "Picked up from owner",
                                  //             style: TextStyle(
                                  //                 color: Colors.black,
                                  //                 fontWeight: FontWeight.w500,
                                  //                 fontSize: 18),
                                  //           ),
                                  //         ]),
                                  //         Text(
                                  //           "01 Sept, 2022",
                                  //           style: TextStyle(
                                  //               color: Colors.grey,
                                  //               fontWeight: FontWeight.w500,
                                  //               fontSize: 18),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  widget.feed.requestStatus! == "returned"
                                      ? GeneralButton(
                                          onPressed: () {
                                            _navigationService
                                                .navigateTo(RatingRoute,arguments: widget.feed.id);
                                          },
                                          buttonText: "Give Feedback")
                                      : Container()
                                ]))))),
          );
        });
  }
}

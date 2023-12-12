import 'package:equipro/app/app_setup.logger.dart';
import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/ui/screens/chat/chat.dart';
import 'package:equipro/ui/screens/chat/chats_widget/chat_details.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rentals_view_model.dart';
import 'package:equipro/ui/screens/hirer/book/details_view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/utils/colors.dart';

import '../../../../core/model/ChatListModel.dart';
import '../../../widget/equip_tiles.dart';
import '../../profile/edit_profile.dart';

class RentalDetails extends StatefulWidget {
  final ActiveRentalsModel feed;
  const RentalDetails({Key? key, required this.feed}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<RentalDetails> with TickerProviderStateMixin {
  final NavService _navigationService = locator<NavService>();
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
    return ViewModelBuilder<RentalsViewModel>.reactive(
        viewModelBuilder: () => RentalsViewModel(),
        builder: (context, model, child) {
          getLogger("className").i(widget.feed.toJson());
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: CustomBackButton(),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: AnimationLimiter(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  // const SizedBox(
                                  //   height: 40,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //         //  margin: EdgeInsets.all(20),
                                  //         padding: EdgeInsets.only(left: 8),
                                  //         height: 40,
                                  //         width: 40,
                                  //         decoration: BoxDecoration(
                                  //           borderRadius:
                                  //               BorderRadius.circular(12),
                                  //           color: AppColors.white,
                                  //         ),
                                  //         child: InkWell(
                                  //             onTap: () {
                                  //               Navigator.pop(context);
                                  //             },
                                  //             child: const Icon(
                                  //               Icons.arrow_back_ios,
                                  //               color: AppColors.primaryColor,
                                  //             )))
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 30,
                                  // ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(widget.feed.equipments!.equipName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: Color(0x1400DEB9),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              widget.feed.requestStatus! ==
                                                          "pending" ||
                                                      widget.feed
                                                              .requestStatus! ==
                                                          "accepted"
                                                  ? "Booked"
                                                  : "Received",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Color(0xFF00E0A8)),
                                            )),
                                      ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    thickness: 4,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      widget.feed.requestStatus! == "pending"
                                          ? "Booking approval pending"
                                          : widget.feed.requestStatus! ==
                                                  "accepted"
                                              ? "Your booking has been approved"
                                              : "null",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color:
                                                  widget.feed.requestStatus! ==
                                                          "pending"
                                                      ? Colors.red
                                                      : Colors.green)),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Booking",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  Divider(),
                                  Gap(10),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text("Amount Paid:",
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .bodyMedium
                                  //             ?.copyWith(
                                  //                 color: Colors.grey,
                                  //                 fontSize: 15,
                                  //                 fontWeight: FontWeight.w700)),
                                  //     SizedBox(
                                  //       width: 60,
                                  //     ),
                                  //     Expanded(
                                  //       child: Text(
                                  //           widget.feed.equipOrder!.totalAmount!
                                  //               .withCommas,
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .bodyMedium
                                  //               ?.copyWith(fontSize: 15)),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 30,
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("QTY Hired:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey,
                                                  fontSize: 15)),
                                      SizedBox(
                                        width: 80,
                                      ),
                                      Expanded(
                                        child: Text(
                                            widget.feed.equipOrder!.quantity!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontSize: 15,
                                                )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Rental Start Date:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Expanded(
                                        child: Text(
                                            widget.feed.rentalFrom != null
                                                ? DateFormat(
                                                    "dd MMM, yyyy",
                                                  )
                                                    .format(DateTime.parse(
                                                        widget
                                                            .feed.rentalFrom!))
                                                    .toString()
                                                : "Unknown",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(fontSize: 15)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Rental End Date",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Expanded(
                                        child: Text(
                                            widget.feed.rentalTo != null
                                                ? DateFormat(
                                                    "dd MMM, yyyy",
                                                  )
                                                    .format(DateTime.parse(
                                                        widget.feed.rentalTo!))
                                                    .toString()
                                                : "Unknown",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(fontSize: 15)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Return Location:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Expanded(
                                        child: Text(
                                            widget.feed.deliveryLocation!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(fontSize: 15)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  if (widget.feed.equipOrder != null)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Charges",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                        ),
                                        Gap(6),
                                        Divider(),
                                        Gap(26),
                                        Row(
                                          children: [
                                            Text(
                                              "Delivery Charges:",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            Gap(20),
                                            Expanded(
                                              child: Text(
                                                "${getCurrency(widget.feed.equipments!.address!.contains("Nigeria") ? "NGN" : "GBP")}${widget.feed.equipOrder!.deliveryCharge ?? "0"}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(27),
                                        Row(
                                          children: [
                                            Text(
                                              "Discount:",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            Gap(80),
                                            Expanded(
                                              child: Text(
                                                "${getCurrency(widget.feed.equipments!.address!.contains("Nigeria") ? "NGN" : "GBP")}${widget.feed.equipOrder!.discount ?? "0"}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(27),
                                        Row(
                                          children: [
                                            Text(
                                              "Total Charges:",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            Gap(45),
                                            Expanded(
                                              child: Text(
                                                "${getCurrency(widget.feed.equipments!.address!.contains("Nigeria") ? "NGN" : "GBP")}${widget.feed.equipOrder!.totalAmount!.withCommas ?? "0"}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .primaryColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  Gap(30),
                                  if (widget.feed.equipDeliveryStatus!
                                          .deliveryStatus !=
                                      null)
                                    Column(
                                      children: [
                                        Gap(10),
                                        Text(
                                          "Equipment Delivery Status",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  Gap(10),
                                  Divider(),
                                  Gap(10),
                                  widget.feed.equipDeliveryStatus!
                                              .deliveryStatus !=
                                          null
                                      ? Container(
                                          // height:
                                          //     Responsive.height(context) / 2.8,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: widget
                                                  .feed
                                                  .equipDeliveryStatus!
                                                  .deliveryStatusLists!
                                                  .length,
                                              itemBuilder: (context, i) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      Column(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 4,
                                                            backgroundColor:
                                                                AppColors
                                                                    .primaryColor,
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            width: 2,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                          widget
                                                                      .feed
                                                                      .equipDeliveryStatus!
                                                                      .deliveryStatusLists![
                                                                          i]
                                                                      .deliveryStatus! ==
                                                                  "pending"
                                                              ? "Pending"
                                                              : widget
                                                                          .feed
                                                                          .equipDeliveryStatus!
                                                                          .deliveryStatusLists![
                                                                              i]
                                                                          .deliveryStatus! ==
                                                                      "picked_from_owner"
                                                                  ? "Equipment Picked Up"
                                                                  : widget.feed.equipDeliveryStatus!.deliveryStatusLists![i].deliveryStatus! ==
                                                                          "delivered_hirer"
                                                                      ? "Owner confirmed Pick-Up"
                                                                      : widget.feed.equipDeliveryStatus!.deliveryStatusLists![i].deliveryStatus! ==
                                                                              "picked_from_hirer"
                                                                          ? "Equipment Returned"
                                                                          : "Confirmed Returned",
                                                          //   "Pending",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          15)),
                                                    ]),
                                                    Text(
                                                      DateFormat(
                                                        "dd MMM, yyyy, hh:mm aa",
                                                      ).format(DateTime.parse(widget
                                                          .feed
                                                          .equipDeliveryStatus!
                                                          .deliveryStatusLists![
                                                              i]
                                                          .dateCreated!
                                                          .toString())),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              fontSize: 15),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        )
                                      : Container(
                                          child: Text(
                                            "Process pending",
                                          ),
                                        ),
                                  Gap(30),
                                  if (widget.feed.requestStatus == "accepted")
                                    BaseButton(
                                      label: "Make Payment",
                                      onPressed: () {},
                                    ),
                                  Gap(10),
                                  // GestureDetector(
                                  //   onTap: () => Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               ChatDetailsPage(
                                  //                   feed: ChatListModel(
                                  //                       id: widget
                                  //                           .feed
                                  //                           .equipments!
                                  //                           .ownersId,
                                  //                       userId: "",
                                  //                       chatWithId: "",
                                  //                       messageCount: "",
                                  //                       lastMessage: "",
                                  //                       dateCreated: "",
                                  //                       dateModified: "",
                                  //                       chatWith: ChatWith(
                                  //                         id: widget
                                  //                             .feed
                                  //                             .equipments!
                                  //                             .ownersId,
                                  //                         fullname: widget
                                  //                             .feed
                                  //                             .equipments!
                                  //                             .ownersId,
                                  //                         email: "",
                                  //                         phoneNumber: "",
                                  //                         gender: "",
                                  //                         address: "",
                                  //                         addressOpt: "",
                                  //                         localState: "",
                                  //                         country: "",
                                  //                         latitude: "",
                                  //                         longitude: "",
                                  //                         hirersPath: widget
                                  //                                     .feed
                                  //                                     .hirers!
                                  //                                     .hirersPath !=
                                  //                                 null
                                  //                             ? widget
                                  //                                 .feed
                                  //                                 .hirers!
                                  //                                 .hirersPath!
                                  //                             : "",
                                  //                         status: "",
                                  //                         dateModified: "",
                                  //                         dateCreated: "",
                                  //                       ))))),
                                  //   child: Text(
                                  //     "Chat Owner",
                                  //     textAlign: TextAlign.center,
                                  //     style: Theme.of(context)
                                  //         .textTheme
                                  //         .bodyLarge
                                  //         ?.copyWith(
                                  //             color: AppColors.primaryColor,
                                  //             fontSize: 16,
                                  //             fontWeight: FontWeight.w600,
                                  //             decoration:
                                  //                 TextDecoration.underline),
                                  //   ),
                                  // )

                                  // widget.feed.requestStatus! == "returned"
                                  //     ? GeneralButton(
                                  //         onPressed: () {
                                  //           _navigationService.navigateTo(
                                  //               RatingRoute,
                                  //               arguments: widget.feed.id);
                                  //         },
                                  //         buttonText: "Give Feedback")
                                  //     : Container()
                                ]))))),
          );
        });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/screens/profile/profile_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/utils/colors.dart';

class BookingDetails extends StatefulWidget {
  final EquipRequest feed;
  const BookingDetails({Key? key, required this.feed}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<BookingDetails> with TickerProviderStateMixin {
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
    return ViewModelBuilder<HomeOwnerViewModel>.reactive(
        viewModelBuilder: () => HomeOwnerViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(10),
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
                                    height: 20,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        _navigationService.navigateTo(
                                            HirerProfileRoute,
                                            arguments: widget.feed.hirers);
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            child: CachedNetworkImage(
                                              imageUrl: widget.feed.hirers!
                                                          .hirersPath !=
                                                      null
                                                  ? widget
                                                      .feed.hirers!.hirersPath!
                                                  : "",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 120.0,
                                                height: 120.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.contain),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                radius: 40,
                                                backgroundColor: AppColors.grey,
                                                child: Image.asset(
                                                  "assets/images/logo.png",
                                                  scale: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            widget.feed.hirers!.fullname!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Booking",
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              _navigationService.navigateTo(
                                                  chatDetailsPageRoute,
                                                  arguments: ChatListModel(
                                                      id: widget.feed.id,
                                                      userId: "",
                                                      chatWithId: "",
                                                      messageCount: "",
                                                      lastMessage: "",
                                                      dateCreated: "",
                                                      dateModified: "",
                                                      chatWith: ChatWith(
                                                        id: widget
                                                            .feed.hirers!.id!,
                                                        fullname: widget.feed
                                                            .hirers!.fullname!,
                                                        email: "",
                                                        phoneNumber: "",
                                                        gender: "",
                                                        address: "",
                                                        addressOpt: "",
                                                        localState: "",
                                                        country: "",
                                                        latitude: "",
                                                        longitude: "",
                                                        hirersPath: widget
                                                                    .feed
                                                                    .hirers!
                                                                    .hirersPath !=
                                                                null
                                                            ? widget
                                                                .feed
                                                                .hirers!
                                                                .hirersPath!
                                                            : "",
                                                        status: "",
                                                        dateModified: "",
                                                        dateCreated: "",
                                                      )));
                                            },
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/chat.svg"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Chat hirer",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ))
                                      ]),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 70,
                                              child: Text(
                                                "QTY Hired: ",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                          Container(
                                              height: 70,
                                              child: Text(
                                                "Rental Start Date: ",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                          Container(
                                              height: 70,
                                              child: Text(
                                                "Duration: ",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                          Container(
                                              height: 100,
                                              child: Text(
                                                "Delivery Location: ",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 200,
                                            child: Text(
                                              widget.feed.quantity!,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            height: 70,
                                            width: 200,
                                            child: Text(
                                              DateFormat(
                                                "dd MMM, yyyy",
                                              )
                                                  .format(DateTime.parse(
                                                    widget.feed.rentalFrom!,
                                                  ))
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            height: 70,
                                            width: 200,
                                            child: Text(
                                              DateTime.parse(
                                                          widget.feed.rentalTo!)
                                                      .difference(
                                                          DateTime.parse(widget
                                                              .feed
                                                              .rentalFrom!))
                                                      .inDays
                                                      .toString() +
                                                  " day(s)",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            width: 200,
                                            child: Text(
                                                widget.feed.deliveryLocation!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  // Text(
                                  //   "Charges",
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
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "Equipment charges:",
                                  //       style: TextStyle(
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.w600,
                                  //           fontSize: 18),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     Text(
                                  //       widget.feed.rentalFrom!,
                                  //       style: TextStyle(
                                  //           color: AppColors.primaryColor,
                                  //           fontWeight: FontWeight.w500,
                                  //           fontSize: 18),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  widget.feed.equipOrder!.orderStatus ==
                                          "pending"
                                      ? Column(
                                          children: [
                                            GeneralButton(
                                                onPressed: () {
                                                  model.equipApproval(
                                                      widget.feed.equipOrderId
                                                          .toString(),
                                                      "accepted");
                                                },
                                                buttonText: "Accept Booking"),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  model.equipApproval(
                                                      widget.feed.equipOrderId
                                                          .toString(),
                                                      "rejected");
                                                },
                                                child: Center(
                                                    child: Text(
                                                  "Decline Booking",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16),
                                                ))),
                                          ],
                                        )
                                      : Center(
                                          child: Text(
                                          widget.feed.equipOrder!.orderStatus!
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: widget.feed.equipOrder!
                                                          .orderStatus ==
                                                      "accepted"
                                                  ? AppColors.green
                                                  : AppColors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ))
                                ]))))),
          );
        });
  }
}

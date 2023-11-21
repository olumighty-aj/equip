import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/ui/screens/chat/chats_widget/chat_details.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/screens/profile/profile_view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/utils/colors.dart';

class BookingDetails extends StatefulWidget {
  final Map<String, dynamic> feed;
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
                    padding: EdgeInsets.all(16),
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
                                  GestureDetector(
                                      onTap: () {
                                        _navigationService.navigateTo(
                                            HirerProfileRoute,
                                            arguments: widget
                                                .feed["equip_request"]
                                                .first["hirers"]);
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            child: CachedNetworkImage(
                                              imageUrl: widget
                                                              .feed["equip_request"]
                                                              .first["hirers"]
                                                          ["hirers_path"] !=
                                                      null
                                                  ? widget.feed["equip_request"]
                                                          .first["hirers"]
                                                      ["hirers_path"]!
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
                                            widget.feed["equip_request"]
                                                .first["hirers"]["fullname"]!,
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ChatDetailsPage(
                                                          feed: ChatListModel(
                                                              id: widget.feed["ID"],
                                                              userId: "",
                                                              chatWithId: "",
                                                              messageCount: "",
                                                              lastMessage: "",
                                                              dateCreated: "",
                                                              dateModified: "",
                                                              chatWith: ChatWith(
                                                                id: widget
                                                                        .feed[
                                                                            "equip_request"]
                                                                        .first[
                                                                    "hirers"]["ID"],
                                                                fullname: widget
                                                                        .feed[
                                                                            "equip_request"]
                                                                        .first["hirers"]
                                                                    [
                                                                    "fullname"],
                                                                email: "",
                                                                phoneNumber: "",
                                                                gender: "",
                                                                address: "",
                                                                addressOpt: "",
                                                                localState: "",
                                                                country: "",
                                                                latitude: "",
                                                                longitude: "",
                                                                hirersPath: widget.feed["equip_request"].first["hirers"]
                                                                            [
                                                                            "hirers_path"] !=
                                                                        null
                                                                    ? widget
                                                                        .feed[
                                                                            "equip_request"]
                                                                        .first["hirers"]["hirers_path"]
                                                                    : "",
                                                                status: "",
                                                                dateModified:
                                                                    "",
                                                                dateCreated: "",
                                                              )))));
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
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "QTY Hired: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          Text(
                                            widget.feed["equip_request"]
                                                .first["quantity"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Gap(15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rental Start Date: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          Text(
                                            DateFormat(
                                              "dd MMM, yyyy",
                                            )
                                                .format(DateTime.parse(
                                                  widget.feed["equip_request"]
                                                      .first["rental_from"]!,
                                                ))
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Gap(15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Duration: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          Text(
                                            DateTime.parse(widget
                                                        .feed["equip_request"]
                                                        .first["rental_to"]!)
                                                    .difference(DateTime.parse(
                                                        widget
                                                            .feed[
                                                                "equip_request"]
                                                            .first["rental_from"]!))
                                                    .inDays
                                                    .toString() +
                                                " day(s)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Gap(15),
                                      Row(
                                        children: [
                                          Text(
                                            "Delivery Location: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          Gap(15),
                                          Expanded(
                                            child: Text(
                                              widget.feed["equip_request"]
                                                  .first["delivery_location"]!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(15),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text("Charges",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15)),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text("Equipment charges:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          "${widget.feed["equip_request"].first["delivery_location"].contains("Nigeria") ? "NGN" : "GBP"}${widget.feed["total_amount"].toString()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 70,
                                  ),
                                  widget.feed["order_status"] == "pending"
                                      ? Column(
                                          children: [
                                            BaseButton(
                                              onPressed: () {
                                                model.newEquipApproval(
                                                    widget.feed["equip_request"]
                                                        .first["equip_order_id"]
                                                        .toString(),
                                                    "accepted",
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime.parse(
                                                          widget
                                                                  .feed[
                                                                      "equip_request"]
                                                                  .first[
                                                              "rental_from"]!,
                                                        ))
                                                        .toString(),
                                                    context);
                                              },
                                              label: "Accept Booking",
                                              isBusy: model.busy("Approval"),
                                            ),
                                            SizedBox(
                                              height: 23,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  model.newEquipApproval(
                                                      widget
                                                          .feed["equip_request"]
                                                          .first[
                                                              "equip_order_id"]
                                                          .toString(),
                                                      "rejected",
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              DateTime.parse(
                                                            widget
                                                                    .feed[
                                                                        "equip_request"]
                                                                    .first[
                                                                "rental_from"]!,
                                                          ))
                                                          .toString(),
                                                      context);
                                                },
                                                child: Text(
                                                  "Decline Booking",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.grey,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )),
                                          ],
                                        )
                                      : Center(
                                          child: Text(
                                          widget.feed["order_status"]
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color:
                                                  widget.feed["order_status"] ==
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

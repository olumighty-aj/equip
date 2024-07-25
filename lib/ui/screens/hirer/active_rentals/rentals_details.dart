import 'package:equipro/app/app_setup.router.dart';
import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rating.dart';
// import 'package:equipro/ui/screens/hirer/active_rentals/edit_booking/edit_bookings_screen.dart';
// import 'package:equipro/ui/screens/hirer/active_rentals/payment/payment.dart';
// import 'package:equipro/ui/screens/hirer/active_rentals/payment/payment_option_screen.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rentals_view_model.dart';
import 'package:equipro/ui/screens/hirer/book/details_view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/app_svgs.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/extensions.dart';
// import 'package:equipro/utils/locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app_setup.locator.dart';
import '../../../../app/app_setup.logger.dart';
import '../../../../core/model/active_rentals/active_rentals.dart';
import '../../../widget/equip_tiles.dart';
import '../../owner/active_rentals/payment_option.dart';
import '../../profile/edit_profile.dart';
import 'edit_booking/edit_booking_screen.dart';
import 'extend_booking.dart';

class RentalDetails extends StatefulWidget {
  final ActiveRentalsModel feed;
  const RentalDetails({Key? key, required this.feed}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<RentalDetails> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  bool isDateInPast(String dateString) {
    try {
      DateTime givenDate = DateFormat("yyyy-MM-dd").parse(dateString);
      DateTime currentDate = DateTime.now();
      print("Given Date: ${givenDate.toDashDate()}");
      print(
          "Given Date: ${givenDate.toString()}, CurrentDate: ${currentDate.toString()}, isAfter: ${currentDate.isAfter(givenDate)}");
      return currentDate.isAfter(givenDate);
    } catch (e) {
      print('Error parsing date: $e');
      return false;
    }
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
          getLogger("className").i("Feed: ${widget.feed.toJson()}");
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
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            widget.feed.equipments!.equip_name!,
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
                                              widget.feed.request_status! ==
                                                          "pending" ||
                                                      widget.feed
                                                              .request_status! ==
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
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (widget.feed.equip_order?.payment_status !=
                                      "1")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            widget.feed.request_status! ==
                                                    "pending"
                                                ? "Booking approval pending"
                                                : widget.feed.request_status! ==
                                                        "accepted"
                                                    ? "Your booking has been approved"
                                                    : "null",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: widget.feed
                                                                .request_status! ==
                                                            "pending"
                                                        ? Colors.red
                                                        : Colors.green)),
                                        if (widget.feed.request_status! ==
                                            "pending")
                                          GestureDetector(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditBookings(
                                                          model: widget.feed,
                                                        ))),
                                            child: Text(
                                              "Edit booking",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor: AppColors
                                                          .primaryColor),
                                            ),
                                          )
                                      ],
                                    ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  if (widget.feed.equip_order?.payment_status !=
                                      "1")
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Booking",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  Gap(10),
                                  if (widget.feed.equip_order?.payment_status ==
                                      "1")
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Amount Paid:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                            SizedBox(
                                              width: 60,
                                            ),
                                            Expanded(
                                              child: Text(
                                                  "${model.isNigerian ? "NGN " : "GBP "}${widget.feed.equip_order!.total_amount!.withCommas}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(fontSize: 15)),
                                            ),
                                            Gap(30),
                                            Text(
                                              "Funded",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
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
                                            widget.feed.equip_order!.quantity!,
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
                                            widget.feed.rental_from != null
                                                ? DateFormat(
                                                    "dd MMM, yyyy",
                                                  )
                                                    .format(DateTime.parse(
                                                        widget
                                                            .feed.rental_from!))
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
                                            widget.feed.rental_to != null
                                                ? DateFormat(
                                                    "dd MMM, yyyy",
                                                  )
                                                    .format(DateTime.parse(
                                                        widget.feed.rental_to!))
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
                                            widget.feed.delivery_location!,
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
                                  if (widget.feed.equip_order != null &&
                                      widget.feed.equip_order?.payment_status ==
                                          "0")
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
                                        Divider(color: Colors.grey),
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
                                                "${widget.feed.equipments!.currency} ${widget.feed.equip_order!.delivery_charge ?? "0"}",
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
                                              "Service Charges:",
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
                                                "${widget.feed.equipments!.currency} ${widget.feed.equip_order!.service_charge!.withCommas}",
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
                                                "${widget.feed.equipments!.currency} ${widget.feed.equip_order!.discount ?? "0"}",
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
                                                "${widget.feed.equipments!.currency} ${widget.feed.equip_order!.total_amount!.withCommas}",
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
                                  if (widget.feed.equip_delivery_status!
                                          .delivery_status !=
                                      null)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Gap(20),
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
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Gap(10),
                                  widget.feed.equip_delivery_status!
                                              .delivery_status !=
                                          null
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: widget
                                              .feed
                                              .equip_delivery_status!
                                              .delivery_status_lists!
                                              .length,
                                          itemBuilder: (context, i) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 8,
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
                                                                      .equip_delivery_status!
                                                                      .delivery_status_lists![
                                                                          i]
                                                                      .delivery_status! ==
                                                                  "pending"
                                                              ? "Pending"
                                                              : widget
                                                                          .feed
                                                                          .equip_delivery_status!
                                                                          .delivery_status_lists![
                                                                              i]
                                                                          .delivery_status! ==
                                                                      "picked_from_owner"
                                                                  ? "Picked up from owner"
                                                                  : widget.feed.equip_payment!.delivery_status_lists![i].delivery_status! ==
                                                                          "delivered_hirer"
                                                                      ? "Delivered to hirer"
                                                                      : widget.feed.equip_delivery_status!.delivery_status_lists![i].delivery_status! ==
                                                                              "picked_from_hirer"
                                                                          ? "Picked up from hirer"
                                                                          : widget.feed.equip_delivery_status!.delivery_status_lists![i].delivery_status! ==
                                                                                  "in_use"
                                                                              ? "Equipment in use"
                                                                              : widget.feed.equip_delivery_status!.delivery_status_lists![i].delivery_status! ==
                                                                                      "picked_from_owner"
                                                                                  ? "Picked up from hirer"
                                                                                  : "Returned to owner",
                                                          //   "Pending",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium),
                                                    ]),
                                                Gap(20),
                                                Expanded(
                                                  child: Text(
                                                    DateTime.parse(widget
                                                            .feed
                                                            .equip_delivery_status!
                                                            .delivery_status_lists![
                                                                i]
                                                            .date_created!)
                                                        .toDate(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.grey),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            );
                                          })
                                      : Container(
                                          child: Text(
                                            "Process pending",
                                          ),
                                        ),
                                  Gap(30),
                                  if (widget.feed.equip_delivery_status !=
                                          null &&
                                      widget.feed.equip_delivery_status!
                                              .delivery_status ==
                                          "in_use" &&
                                      model.getDateDifference(
                                              widget.feed.rental_to!) ==
                                          2)
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(AppSvgs.dnager),
                                            Gap(3),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "You have 2 days left to return this equipment.\n",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              TextSpan(
                                                text: "Extend hiring",
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () =>
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ExtendBookingScreen(
                                                                            feed:
                                                                                widget.feed,
                                                                          ))),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                        decorationColor:
                                                            AppColors
                                                                .primaryColor,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                              ),
                                              TextSpan(
                                                  text:
                                                      " period attracts extra charges",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                            ])),
                                          ],
                                        ),
                                        Gap(20),
                                      ],
                                    ),
                                  if (widget.feed.request_status == "declined")
                                    BaseButton(
                                      // isBusy: model.busy("InitPayment"),
                                      label: "Search other related equipments",
                                      onPressed: () =>
                                          locator<NavigationService>()
                                              .clearStackAndShow(Routes.home),
                                    ),
                                  if (widget.feed.request_status ==
                                              "accepted" &&
                                          widget.feed.equip_order
                                                  ?.payment_status ==
                                              "0" &&
                                          !isDateInPast(widget.feed.rental_to!)
                                      // &&
                                      // !isDateInPast(widget.feed.rentalTo!)
                                      )
                                    Column(
                                      children: [
                                        Gap(10),
                                        BaseButton(
                                            isBusy: model.busy("InitPayment"),
                                            label: "Make Payment",
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentOptionScreen(
                                                          feed: widget.feed,
                                                        )))),
                                      ],
                                    ),
                                  if (isDateInPast(widget.feed.rental_to!) &&
                                      widget.feed.equip_order?.payment_status ==
                                          "0")
                                    Text(
                                      "Booking Expired",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.red),
                                      textAlign: TextAlign.center,
                                    ),
                                  if (widget.feed.equip_payment != null)
                                    if (widget.feed.request_status ==
                                            "accepted" &&
                                        widget.feed.equip_payment[
                                                "payment_status"] ==
                                            "1")
                                      Column(
                                        children: [
                                          Gap(10),
                                          BaseButton(
                                              isBusy: model.busy("pickedOwner"),
                                              label:
                                                  "I Have Received The Equipment ",
                                              onPressed: () =>
                                                  model.pickedUpFromOwner(
                                                      widget
                                                          .feed.equip_order_id!,
                                                      context)),
                                        ],
                                      ),
                                  if (widget.feed.request_status ==
                                          "received" &&
                                      widget.feed.equip_delivery_status!
                                              .delivery_status ==
                                          "delivered_hirer")
                                    Column(
                                      children: [
                                        Gap(10),
                                        BaseButton(
                                            isBusy: model.busy("pickedOwner"),
                                            label: "Equipment in use ",
                                            onPressed: () => model.inUse(
                                                widget.feed.equip_order_id!,
                                                context)),
                                      ],
                                    ),
                                  if (widget.feed.equip_delivery_status
                                          ?.delivery_status ==
                                      "in_use")
                                    Column(
                                      children: [
                                        Gap(10),
                                        BaseButton(
                                          isBusy: model.busy("returned"),
                                          label: "Return Equipment",
                                          onPressed: () =>
                                              model.pickedFromHirer(
                                                  widget.feed.equip_order_id!,
                                                  context),
                                        ),
                                      ],
                                    ),
                                  if (widget.feed.equip_delivery_status
                                              ?.delivery_status ==
                                          "returned" ||
                                      widget.feed.equip_delivery_status
                                              ?.delivery_status ==
                                          "picked_from_hirer")
                                    BaseButton(
                                      // isBusy: model.busy("returned"),
                                      label: "Give Feedback",
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Rating(
                                                    id: widget
                                                        .feed.equipments_id!,
                                                  ))),
                                    ),
                                  Gap(10),
                                ]))))),
          );
        });
  }
}

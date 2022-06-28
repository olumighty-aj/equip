import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/ui/screens/owner/active_rentals/rentals_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/utils/colors.dart';

class OwnerRentalDetails extends StatefulWidget {
  final ActiveRentalsModel feed;
  const OwnerRentalDetails({Key? key, required this.feed}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<OwnerRentalDetails>
    with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? selectedDate;
  TextEditingController emailController = TextEditingController();
  AnimationController? _navController;
  Animation<Offset>? _navAnimation;

  displayDialog(BuildContext context, OwnerRentalsViewModel model) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15),
        ),
        content: Container(
            width: Responsive.width(context) / 1.2,
            height: 245,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Input Pickup Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      // YearPicker(firstDate: firstDate, lastDate: lastDate, selectedDate: selectedDate, onChanged: onChanged)
                      DatePicker.showDatePicker(context,
                          minTime: DateTime.now(),
                          showTitleActions: true, onChanged: (date) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                        setState(() {
                          selectedDate =
                              DateFormat('y-MM-dd').format(date).toString();
                        });
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());

                        displayDialog( context, model);
                      }, onConfirm: (date) {
                        setState(() {});
                      }, currentTime: DateTime.now());
                    },
                    child: Container(
                        height: 60,
                        width: Responsive.width(context),
                        decoration: BoxDecoration(
                            //   color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedDate != null ? selectedDate! : "From",
                                  style: TextStyle(
                                      color: selectedDate != null
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.grey,
                                )
                              ],
                            )))),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: GeneralButton(
                    buttonText: 'Confirm',
                    onPressed: () async {
                      var result = await model.sendDate(selectedDate!, widget.feed.id.toString());
                      if(result is SuccessModel){
                        Navigator.pop(context);
                      }
                     // _navigationService.pushAndRemoveUntil(homeRoute);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

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
    return ViewModelBuilder<OwnerRentalsViewModel>.reactive(
        viewModelBuilder: () => OwnerRentalsViewModel(),
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
                                          widget.feed.equipments!.equipName!,
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 30,
                                          child: GeneralButton(
                                            onPressed: () {},
                                            buttonText:
                                                toBeginningOfSentenceCase(widget
                                                    .feed.equipOrder!.orderStatus!)!,
                                            buttonTextColor: AppColors.white,
                                            splashColor: widget
                                                        .feed.equipOrder!.orderStatus! ==
                                                    "pending"
                                                ? Colors.blue
                                                : widget.feed.equipOrder!.orderStatus! ==
                                                        "rejected"
                                                    ? AppColors.red
                                                    : widget.feed
                                                .equipOrder!.orderStatus! ==
                                                            "returned"
                                                        ? AppColors.green
                                                        : widget.feed
                                                .equipOrder!.orderStatus! ==
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
                                          widget.feed.deliveryLocation!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  widget.feed.requestStatus! == "accepted"
                                      ?    GeneralButton(
                                      onPressed: () {
                                        model.updateBooking(
                                            widget.feed.equipOrderId.toString(),
                                            "delivered_hirer");
                                      },
                                      buttonText: "Delivered to Hirer")
                                      : widget.feed.requestStatus! == "returned"
                                          ? GeneralButton(
                                              onPressed: () {
                                                _navigationService.navigateTo(
                                                    RatingRoute,
                                                    arguments: widget.feed.id);
                                              },
                                              buttonText: "Give Feedback")
                                          : Container()
                                ]))))),
          );
        });
  }
}

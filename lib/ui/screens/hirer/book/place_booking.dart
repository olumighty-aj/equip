import 'package:badges/badges.dart';
import 'package:equipro/core/model/BookModel.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/ui/screens/chat/chats_widget/chat_details.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/hirer/book/details_view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/helpers.dart';
// import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/place_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app_setup.locator.dart';
import '../../../../app/app_setup.logger.dart';
import '../../../../app/app_setup.router.dart';
import '../../../../utils/text_styles.dart';

class PlaceBooking extends StatefulWidget {
  final EquipmentModel model;
  const PlaceBooking({Key? key, required this.model}) : super(key: key);

  @override
  PlaceBookingState createState() => PlaceBookingState();
}

class PlaceBookingState extends State<PlaceBooking>
    with TickerProviderStateMixin {
  final _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectedQuantity;
  String? pickupTime = DateTime.now().toString();
  String? selectedDate;
  String? selectedWeek;
  String? selectedDateTo;
  double? pickLat;
  double? pickLng;
  TextEditingController deliveryController = TextEditingController();
  AnimationController? _navController;
  Animation<Offset>? _navAnimation;
  var quantityList;
  void showPlacePicker() async {
    LocationResult result =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PlacePicker("AIzaSyAsoaOKfTVMSJll6LvVcQ3sYgALbwJ0B9A");
    }));
    // Handle the result in your way
    print(result);

    setState(() {
      print(result);
      deliveryController.text = result.formattedAddress!;
      pickLat = result.latLng!.latitude;
      pickLng = result.latLng!.longitude;
    });
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

  displayDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15),
        ),
        content: Container(
            padding: EdgeInsets.all(12),
            width: Responsive.width(context) / 1.2,
            height: 245,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Booking Request Sent",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 250,
                    child: Text(
                      "Booking request has been sent to equipment owner. You will be notified ones your request is approved",
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: 30,
                ),
                BaseButton(
                  label: 'Okay',
                  onPressed: () {
                    // Navigator.pop(context);
                    _navigationService.clearStackAndShow(Routes.home);
                  },
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsViewModel>.reactive(
        onViewModelReady: (v) {
          quantityList = List<int>.generate(
              int.parse(widget.model.quantity!), (i) => i + 1);
        },
        viewModelBuilder: () => DetailsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: AnimationLimiter(
                        child: Column(
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
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 2)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 15,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(widget.model.equipName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w800)),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getCurrency(widget.model.owners!.country)}${widget.model.costOfHire} per ${widget.model.costOfHireInterval == "1" ? "Day" : widget.model.costOfHireInterval == "7" ? "Week" : "Month"}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "QTY Available:  ${widget.model.quantity!}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Availability: ${DateFormat(
                                      "dd MMM, yyyy",
                                    ).format(DateTime.parse(widget.model.availFrom!)).toString()} - ${DateFormat(
                                      "dd MMM, yyyy",
                                    ).format(DateTime.parse(widget.model.availTo!)).toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  if (model.authentication.currentUser.id !=
                                      widget.model.owners!.id)
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: BaseButton(
                                        label: "Chat Owner",
                                        labelStyle: buttonText.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w500),
                                        bgColor: AppColors.primaryColor
                                            .withOpacity(0.2),
                                        onPressed: () {
                                          getLogger("BookingPlace").i(
                                              "PlaceBooking: ${widget.model.toJson()}");
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ChatDetailsPage(
                                                feed: ChatListModel(
                                                    id: widget.model.userId,
                                                    userId:
                                                        widget.model.ownersId,
                                                    chatWithId:
                                                        widget.model.userId,
                                                    messageCount: "",
                                                    lastMessage: "",
                                                    dateCreated: "",
                                                    dateModified: "",
                                                    chatWith: ChatWith(
                                                      id: widget.model.ownersId,
                                                      fullname: widget.model
                                                          .owners!.fullname!,
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
                                                                  .model
                                                                  .owners!
                                                                  .hirersPath !=
                                                              null
                                                          ? widget.model.owners!
                                                              .hirersPath!
                                                          : "",
                                                      status: "",
                                                      dateModified: "",
                                                      dateCreated: "",
                                                    )));
                                          }));
                                        },
                                      ),
                                    ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Divider(
                                    thickness: 3,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Place a booking",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: Responsive.width(context),
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                      child: DropdownButtonFormField<int>(
                                        decoration: InputDecoration.collapsed(
                                            hintText:
                                                'Number of quantity to hire'),
                                        isExpanded: true,
                                        value: selectedQuantity,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedQuantity = newValue;
                                          });
                                        },
                                        items: quantityList
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(value.toString()),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        // YearPicker(firstDate: firstDate, lastDate: lastDate, selectedDate: selectedDate, onChanged: onChanged)
                                        DatePickerBdaya.showDatePicker(context,
                                            minTime: DateTime.now(),
                                            showTitleActions: true,
                                            onChanged: (date) {
                                          setState(() {
                                            selectedDate = DateFormat('y-MM-dd')
                                                .format(date)
                                                .toString();
                                          });
                                          print('change $date in time zone ' +
                                              date.timeZoneOffset.inHours
                                                  .toString());
                                        }, onConfirm: (date) {
                                          setState(() {});
                                        }, currentTime: DateTime.now());
                                      },
                                      child: Container(
                                          height: 60,
                                          width: Responsive.width(context),
                                          decoration: BoxDecoration(
                                              //   color: AppColors.primaryColor.withOpacity(0.1),
                                              borderRadius: const BorderRadius
                                                      .all(
                                                  Radius.circular(
                                                      5.0) //                 <--- border radius here
                                                  ),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    selectedDate != null
                                                        ? selectedDate!
                                                        : "From",
                                                    style: TextStyle(
                                                        color:
                                                            selectedDate != null
                                                                ? Colors.black
                                                                : Colors.grey),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              )))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        // YearPicker(firstDate: firstDate, lastDate: lastDate, selectedDate: selectedDate, onChanged: onChanged)
                                        DatePickerBdaya.showDatePicker(context,
                                            minTime: DateTime.now(),
                                            showTitleActions: true,
                                            onChanged: (date) {
                                          setState(() {
                                            selectedDateTo =
                                                DateFormat('y-MM-dd')
                                                    .format(date)
                                                    .toString();
                                            print(DateFormat('y')
                                                .format(date)
                                                .toString());
                                          });
                                        }, onConfirm: (date) {
                                          setState(() {});
                                        }, currentTime: DateTime.now());
                                      },
                                      child: Container(
                                          height: 60,
                                          width: Responsive.width(context),
                                          decoration: BoxDecoration(
                                              //   color: AppColors.primaryColor.withOpacity(0.1),
                                              borderRadius: const BorderRadius
                                                      .all(
                                                  Radius.circular(
                                                      5.0) //                 <--- border radius here
                                                  ),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    selectedDateTo != null
                                                        ? selectedDateTo!
                                                        : "Till",
                                                    style: TextStyle(
                                                        color: selectedDateTo !=
                                                                null
                                                            ? Colors.black
                                                            : Colors.grey),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              )))),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Container(
                                  //   padding: EdgeInsets.all(10),
                                  //   width: Responsive.width(context),
                                  //   height: 60,
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(color: Colors.grey),
                                  //     borderRadius: BorderRadius.circular(5.0),
                                  //   ),
                                  //   child: Center(
                                  //     child: DropdownButtonFormField<String>(
                                  //       decoration: InputDecoration.collapsed(
                                  //           hintText: 'Number of weeks'),
                                  //       isExpanded: true,
                                  //       value: selectedWeek,
                                  //       onChanged: (newValue) {
                                  //         setState(() {
                                  //           selectedWeek = newValue;
                                  //         });
                                  //       },
                                  //       items: <String>[
                                  //         '1',
                                  //         '2',
                                  //         '3',
                                  //         '4',
                                  //       ].map<DropdownMenuItem<String>>(
                                  //           (String value) {
                                  //         return DropdownMenuItem<String>(
                                  //           value: value,
                                  //           child: Text(value),
                                  //         );
                                  //       }).toList(),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        showPlacePicker();
                                      },
                                      child: TextFormField(
                                        enabled: false,
                                        controller: deliveryController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter delivery location',
                                          hintStyle: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          disabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(),
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        cursorColor: Colors.black,
                                      )),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                      child: SlideTransition(
                                          position: _navAnimation!,
                                          //  textDirection: TextDirection.rtl,
                                          child: BaseButton(
                                              isBusy: model.busy("Book"),
                                              onPressed: () => model.newBook(
                                                  BookModel(
                                                      equipmentsId: widget
                                                          .model.id
                                                          .toString(),
                                                      quantity: selectedQuantity
                                                          .toString(),
                                                      rentalFrom: selectedDate,
                                                      rentalTo: selectedDateTo,
                                                      latitude:
                                                          pickLat.toString(),
                                                      longitude:
                                                          pickLng.toString(),
                                                      deliveryLocation:
                                                          deliveryController
                                                              .text),
                                                  context),

                                              // if (result is SuccessModel) {
                                              //   displayDialog(context);
                                              // }
                                              label: "Book Now")))
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

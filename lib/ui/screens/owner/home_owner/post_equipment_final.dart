import 'package:badges/badges.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/place_picker.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';

class PostEquipmentFinal extends StatefulWidget {
  final String equipName;
  final List images;
  final description;
  const PostEquipmentFinal(
      {Key? key,
      required this.equipName,
      required this.images,
      this.description})
      : super(key: key);
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<PostEquipmentFinal>
    with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedQuantity;
  String? selectedDate;
  String? selectedDateTo;
  String? selectedPer;
  String? selectedPerNumber;
  TextEditingController costController = TextEditingController();
  AnimationController? _navController;
  Animation<Offset>? _navAnimation;
  TextEditingController deliveryController = TextEditingController();
  double? pickLat;
  double? pickLng;

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyAsoaOKfTVMSJll6LvVcQ3sYgALbwJ0B9A")));
    // Handle the result in your way
    print(result);

    setState(() {
      print(result);
      deliveryController.text = result.formattedAddress!;
      pickLat = result.latLng!.latitude;
      pickLng = result.latLng!.longitude;
    });
  }

  void _startUploading(HomeOwnerViewModel model) async {
    var response = await model.postEquip(
      widget.images,
      widget.equipName,
      costController.text,
      selectedPerNumber!,
      selectedDate!,
      selectedDateTo!,
      selectedQuantity!,
      widget.description,
      pickLat.toString(),
      pickLng.toString(),
        deliveryController.text
    );
    print(response);
    if (response == null) {
      print('error');
    } else {}
  }

  @override
  void initState() {
    super.initState();
    print(widget.images);
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

  var quantityList = new List<int>.generate(4, (i) => i + 1);
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
            width: Responsive.width(context) / 1.2,
            height: 245,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Booking Request",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Sent",
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: GeneralButton(
                    buttonText: 'Okay',
                    onPressed: () {
                      Navigator.pop(context);
                      _navigationService.pushAndRemoveUntil(homeRoute);
                    },
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.pop(context);
                  //     _navigationService.pushAndRemoveUntil(homeRoute);
                  //   },
                  //   child:
                  // Container(
                  //   height:70,
                  //  // width: Responsive.width(context)/1.5,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                  //     color: AppColors.primaryColor,
                  //   ),
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     "Okay",
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 20),
                  //   ),
                  // ))
                ),
              ],
            )),
      ),
    );
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
                                    "Post New Equipment",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Other Details",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  BarProgress(
                                    percentage: 100,
                                    backColor: AppColors.white,
                                    color: AppColors.primaryColor,
                                    showPercentage: false,
                                    stroke: 9,
                                    round: true,
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    "Cost of hire",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: costController,
                                    decoration: InputDecoration(
                                      hintText: 'Cost',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
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
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
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
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration.collapsed(
                                            hintText: 'Per?'),
                                        isExpanded: true,
                                        value: selectedPer,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedPer = newValue;
                                            newValue == "Day 1"
                                                ? selectedPerNumber = "1"
                                                : newValue == "Week 7"
                                                    ? selectedPerNumber =
                                                        "Month 30"
                                                    : selectedPerNumber = "30";
                                          });
                                        },
                                        items: <String>[
                                          'Day 1',
                                          'Week 7',
                                          'Month 30',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Availability",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
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
                                  InkWell(
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Quantities available for hire",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
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
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration.collapsed(
                                            hintText:
                                                'Number of quantity for hire'),
                                        isExpanded: true,
                                        value: selectedQuantity,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedQuantity = newValue;
                                          });
                                        },
                                        items: <String>[
                                          '1',
                                          '2',
                                          '3',
                                          '4',
                                          '5',
                                          '6',
                                          '7',
                                          '8',
                                          '9',
                                          '10',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(onTap: (){
                                    showPlacePicker();
                                  },
                                      child:
                                      TextFormField(
                                        enabled: false,
                                        controller: deliveryController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter delivery location',
                                          hintStyle: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          disabledBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          enabledBorder: const OutlineInputBorder(
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
                                        keyboardType: TextInputType.emailAddress,
                                        style: const TextStyle(color: Colors.black),
                                        cursorColor: Colors.black,
                                      )  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                      child: SlideTransition(
                                          position: _navAnimation!,
                                          //  textDirection: TextDirection.rtl,
                                          child: Container(
                                              width: 300,
                                              child: GeneralButton(
                                                  onPressed: () {
                                                    if (costController
                                                            .text.isNotEmpty &&
                                                        selectedDate != null &&
                                                        selectedDateTo !=
                                                            null &&
                                                        selectedPer != null &&
                                                        selectedQuantity !=
                                                            null) {
                                                      _startUploading(model);
                                                    } else {
                                                      showErrorToast(
                                                          "All fields are compulsory");
                                                    }
                                                  },
                                                  buttonText: "Post"))))
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

import 'package:badges/badges.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';

class PostEquipmentFinal extends StatefulWidget {
  const PostEquipmentFinal({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<PostEquipmentFinal> with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectedQuantity;
  String? pickupTime = DateTime.now().toString();
  String? selectedDate;
  String? selectedWeek;
  String? selectedPer;
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

  var quantityList = new List<int>.generate(4, (i) => i + 1);
  displayDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding:EdgeInsets.zero ,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15),),
        content:
        Container(
          width: Responsive.width(context)/1.2,
          height: 245,
          child:
        Column(
          children: [
            SizedBox(height: 10,),
            Text(
              "Booking Request",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5,),
            Text(
              "Sent",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            Container(
              width: 250,
              child:
            Text(
              "Booking request has been sent to equipment owner. You will be notified ones your request is approved",
              textAlign: TextAlign.center,
            )  ),
            SizedBox(height: 20,),
            Container(
              width: 200,
              child:
                  GeneralButton(buttonText: 'Okay',
                    onPressed: (){
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
        ) ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
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
                                            borderRadius: BorderRadius.circular(12),
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
                                        color: AppColors.black,),
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
                                        fontSize: 15,),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  TextFormField(
                                    controller: emailController,
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
                                            hintText:
                                                'Per?'),
                                        isExpanded: true,
                                        value: selectedPer,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedPer = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Day',
                                          'Week',
                                          'Month',
                                          'Costume',
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
                                      fontSize: 15,),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        // YearPicker(firstDate: firstDate, lastDate: lastDate, selectedDate: selectedDate, onChanged: onChanged)
                                        DatePicker.showDateTimePicker(context,
                                            maxTime: DateTime.now(),
                                            showTitleActions: true,
                                            onChanged: (date) {
                                          setState(() {
                                            pickupTime = date.toString();
                                            selectedDate =
                                                DateFormat('M/d/y - h:mm a')
                                                    .format(date)
                                                    .toString();
                                            print(DateFormat('y')
                                                .format(date)
                                                .toString());
                                          });
                                          print('change $date in time zone ' +
                                              date.timeZoneOffset.inHours
                                                  .toString());
                                        }, onConfirm: (date) {
                                          setState(() {
                                            pickupTime = date.toString();
                                          });
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
                                                    style: const TextStyle(
                                                        color: Colors.grey),
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
                                        DatePicker.showDateTimePicker(context,
                                            maxTime: DateTime.now(),
                                            showTitleActions: true,
                                            onChanged: (date) {
                                              setState(() {
                                                pickupTime = date.toString();
                                                selectedDate =
                                                    DateFormat('M/d/y - h:mm a')
                                                        .format(date)
                                                        .toString();
                                                print(DateFormat('y')
                                                    .format(date)
                                                    .toString());
                                              });
                                              print('change $date in time zone ' +
                                                  date.timeZoneOffset.inHours
                                                      .toString());
                                            }, onConfirm: (date) {
                                              setState(() {
                                                pickupTime = date.toString();
                                              });
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
                                                        : "Till",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
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
                                      fontSize: 15,),
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
                                            hintText: 'Number of quantity for hire'),
                                        isExpanded: true,
                                        value: selectedWeek,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedWeek = newValue;
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
                                    height: 30,
                                  ),
                                  Center(
                                      child:  SlideTransition(
                                          position: _navAnimation!,
                                        //  textDirection: TextDirection.rtl,
                                          child:Container(
                                          width: 300,
                                          child: GeneralButton(
                                              onPressed: () {
                                                _navigationService.pushAndRemoveUntil(HomeOwnerRoute);
                                              },
                                              buttonText: "Post"))))
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

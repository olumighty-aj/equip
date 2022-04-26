import 'package:badges/badges.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/widget/booking_request.dart';
import 'package:equipro/ui/widget/dash_painter.dart';
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
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';

class EquipOwnerDetails extends StatefulWidget {
  const EquipOwnerDetails({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EquipOwnerDetails> with TickerProviderStateMixin {
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
                                    "Bulldozer",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "N5000 per week",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "QTY Available: 4",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Description:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "This wheelbarrow has four extented legs and can carry up to 4kg load. It has an extra tyre also",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Availlability: 02 Sept. 2022 - 09 Oct, 2022",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),


                                  CustomPaint(painter: LineDashedPainter()),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Booking requests (2)",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  BookingRequest(),
                                  BookingRequest(),
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

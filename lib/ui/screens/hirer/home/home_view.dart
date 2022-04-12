import 'package:badges/badges.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
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
                                    height: 60,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _scaffoldKey.currentState!
                                              .openDrawer();
                                        },
                                        child: SvgPicture.asset(
                                          "assets/images/hamburger.svg",
                                        ),
                                      ),
                                      const Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Find an ",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "equipment",
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "quickly!",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              Responsive.width(context) / 1.3,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.search_outlined,
                                                color: AppColors.grey,
                                                size: 30,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 20.0),
                                              hintText:
                                                  "Search by location, name of equipment, etc",
                                              hintStyle: TextStyle(
                                                color: Color(0XFF818181),
                                                fontSize: 12,
                                              ),
                                              // fillColor: Colors.white,
                                              // filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0),
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0),
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              _navigationService.navigateTo(NotificationRoute);
                                            },
                                            child: Badge(
                                              badgeContent: Text(
                                                "0",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              child: SvgPicture.asset(
                                                  "assets/images/notification.svg"),
                                            ))
                                      ]),
SizedBox(height: 30,),
                                  Text("EQUIPMENTS LISTING NEAR YOU",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(height: 30,),
                                  EquipTiles(),
                                  EquipTiles(),
                                  EquipTiles(),


                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

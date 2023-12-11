import 'dart:async';
import 'package:equipro/app/app_setup.router.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equipro/core/services/auth_service.dart';
// import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.dart';
import '../../app/app_setup.locator.dart';
import '../../utils/app_svgs.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  bool? isHirer;
  final _navigationService = locator<NavigationService>();
  late AnimationController animationController;
  bool? userExists;
  late Animation<double> animation;
  final Authentication _authentication = locator<Authentication>();
  startTime() async {
    var _duration = const Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString('currentUser');
    if (id != null) {
      _authentication.alreadyLoggedIn();
    } else {
      _navigationService.clearStackAndShow(Routes.onboardingScreen);
      // _navigationService.navigateReplacementTo(loginRoute);
    }
  }

  void check() async {
    userExists = await App.checkIfUserIsNew();
    isHirer = await App.checkIfIsHirer();
  }

  @override
  void initState() {
    check();
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    Future.delayed(Duration(seconds: 4)).then(
        (value) => _navigationService.clearStackAndShow(userExists! && isHirer!
            ? Routes.home
            : userExists! && !isHirer!
                ? Routes.homeOwner
                : Routes.onboardingScreen));
    // startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Container(
          //     width: Responsive.width(context),
          //     height: Responsive.height(context)/1.1,
          //     child: Image.asset(
          //       "assets/images/background.png",
          //       // color: AppColors.white,
          //     )),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: animation.value * 200,
                    child: SvgPicture.asset(AppSvgs.logoMark)),
                // Text("equipro",style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold, fontSize: 50),)
              ]),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  final NavigationService _navigationService = locator<NavigationService>();
  late AnimationController animationController;
  late Animation<double> animation;
  final Authentication _authentication = locator<Authentication>();
  startTime() async {
    var _duration = const Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString('profile');
    if (id != null) {
      _authentication.alreadyLoggedIn();
    } else {
      _navigationService.navigateReplacementTo(OnBoardingScreenRoute);
     // _navigationService.navigateReplacementTo(loginRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
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
                        child: Image.asset(
                          "assets/images/logo.png",
                          //color: AppColors.white,
                        )),
                    // Text("equipro",style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold, fontSize: 50),)
                  ]),
            ],
          ),
        );
  }
}

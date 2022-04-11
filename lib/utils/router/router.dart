import 'package:equipro/ui/screens/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:equipro/ui/screens/login/login_view.dart';
import 'package:equipro/ui/screens/login/forgot_password.dart';
import 'package:equipro/ui/screens/onboarding/onboardingscreen_view.dart';
import 'package:equipro/ui/screens/register/register_view.dart';
import 'package:equipro/ui/screens/register/verification_view.dart';
import 'package:equipro/utils/router/route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Login(),
      );
    case registerRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Register(),
      );
    case bottomNavigationRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const BottomNavigation(),
      );

    case verificationViewRoute:
      String phoneNumber = settings.arguments as String;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: VerificationView(
          phoneNumber: phoneNumber,
        ),
      );

    case forgotPasswordRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ForgotPasswordPage(),
      );

    case OnBoardingScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow:OnboardingScreen(),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute(
    {required String routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

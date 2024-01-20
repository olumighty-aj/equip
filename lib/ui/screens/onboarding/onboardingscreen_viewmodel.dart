import 'package:equipro/core/model/onboarding_screen_model.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
// import 'package:equipro/utils/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../app/app_setup.router.dart';

List<OnboardingScreenModel> getScreens() {
  List<OnboardingScreenModel> screens = [];
  OnboardingScreenModel screensModel = new OnboardingScreenModel();

  //screen 0
  screensModel
      .setSubtitle("A smart payment solution to manage your businesses.");
  screensModel.setImage("assets/images/onboard1.png");
  screensModel.setTitle("Online Payment");
  screens.add(screensModel);

  screensModel = new OnboardingScreenModel();

  //screen 1
  screensModel.setSubtitle("Get all your products in one place");
  screensModel.setImage("assets/images/onboard2.png");
  screensModel.setTitle(" Inventory Management");
  screens.add(screensModel);

  screensModel = new OnboardingScreenModel();

  // //screen 2
  // screensModel.setSubtitle(
  //     "Manage your employees and payroll schedule conveniently in one place");
  // screensModel.setImage("assets/images/onboard3.png");
  // screensModel.setTitle("HR & Payroll");
  // screens.add(screensModel);

  return screens;
}

class OnboardingScreenViewModel extends BaseViewModel {
  //final AuthenticationService _authenticationService = locator<AuthenticationService>();

  // final DialogService _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  EdgeInsetsGeometry padding = EdgeInsets.only(left: 30);
  EdgeInsetsGeometry margin =
      EdgeInsets.symmetric(horizontal: 30, vertical: 20);
  EdgeInsetsGeometry bottomIconPadding =
      EdgeInsets.symmetric(horizontal: 30, vertical: 30);

  void navigateToWelcome() {
    _navigationService.navigateTo(Routes.login);
  }

  Widget pageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 7.0 : 10.0,
      width: isCurrentPage ? 25.0 : 10.0,
      decoration: BoxDecoration(
          color: isCurrentPage ? AppColors.primaryColor : AppColors.grey,
          borderRadius: BorderRadius.circular(12)),
    );
  }
}

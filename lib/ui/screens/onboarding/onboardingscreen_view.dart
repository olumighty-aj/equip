import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:equipro/core/model/onboarding_screen_model.dart';
import 'package:equipro/ui/widget/pageview_card.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'dart:io';
import 'package:stacked/stacked.dart';
import 'onboardingscreen_viewmodel.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingScreenModel> screens = [];
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    screens = getScreens();
  }

  // Page Indicator

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingScreenViewModel>.reactive(
        viewModelBuilder: () => OnboardingScreenViewModel(),
        // onModelReady: (model) => model.getScreens(),
        builder: (context, model, child) => Scaffold(

              body: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: screens.length,
                        onPageChanged: (val) {
                          setState(() {
                            currentIndex = val;
                          });
                        },
                        itemBuilder: (context, index) {
                          return ScreenTile(
                            subtitle: screens[index].getSubtitle(),
                            image: screens[index].getImage(),
                            title: screens[index].getTitle(),
                            screenvalue: currentIndex < screens.length - 1,
                          );
                        }),
                  ),
                  Container(
                      //color: AppColors.white,
                      padding: EdgeInsets.only(bottom: 60),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            height: Responsive.height(context) / 2,
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.white,
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                currentIndex != screens.length - 1
                                    ? Column(
                                        children: [
                                          Text(
                                            "Equipment",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Owner",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              width: 250,
                                              child: Text(
                                                  "Lease out your construction equipment for a period of time and get paid instantly",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w100)))
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Text(
                                            "Equipment",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Hirer",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              width: 250,
                                              child: Text(
                                                  "Rent construction equipment quickly at a cheaper price directly from equipment owners",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w100)))
                                        ],
                                      ),
                                SizedBox(
                                  height: 40,
                                ),
                                Center(
                                    child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      for (int i = 0; i < screens.length; i++)
                                        currentIndex == i
                                            ? model.pageIndicator(true)
                                            : model.pageIndicator(false)
                                    ],
                                  ),
                                )),
                                Padding(
                                  padding: model.bottomIconPadding,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (currentIndex != screens.length - 1) {
                                        pageController.animateToPage(
                                            currentIndex + 1,
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.linear);
                                      } else {
                                        model.navigateToWelcome();
                                      }
                                    },
                                    child: Container(
                                      height: Platform.isIOS ? 60 : 50,
                                      width: width(0.5, context),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.primaryColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        currentIndex != screens.length - 1
                                            ? "Next"
                                            : "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ))
                ],
              ),
            ));
  }
}

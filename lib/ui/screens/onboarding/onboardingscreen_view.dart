import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              backgroundColor: Colors.white,
              body: Container(
                height: height(1.0, context),
                child: Stack(
                  children: [
                    Container(
                      height: height(0.75, context),
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
                    // SizedBox(height: 10),

                    SizedBox(height: 20),
                    currentIndex != screens.length - 1
                        ? Container(
                            padding: model.bottomIconPadding,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(""),
                                  Container(
                                      margin: EdgeInsets.only(top: 20),
                                      height: 30,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      Colors.black),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      side: BorderSide(color: Colors.black)))),
                                          onPressed: () {
                                            pageController.animateToPage(
                                                screens.length - 1,
                                                duration:
                                                    Duration(milliseconds: 400),
                                                curve: Curves.linear);
                                          },
                                          child: Text(
                                            "SKIP",
                                          )))
                                ]))
                        : Container(),
                    Container(
                      padding: EdgeInsets.only(bottom: 140),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: model.bottomIconPadding,
                          child: GestureDetector(
                            onTap: () {
                              if (currentIndex != screens.length - 1) {
                                pageController.animateToPage(currentIndex + 1,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.linear);
                              } else {
                                model.navigateToWelcome();
                              }
                            },
                            child: Container(
                              height: Platform.isIOS ? 60 : 50,
                              width: width(0.5, context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColor,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                currentIndex != screens.length - 1
                                    ? "Next"
                                    : "Start",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                      Center(
                        child:
                      Container(
                        margin: EdgeInsets.only(top: height(0.8, context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < screens.length; i++)
                              currentIndex == i
                                  ? model.pageIndicator(true)
                                  : model.pageIndicator(false)
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ));
  }
}

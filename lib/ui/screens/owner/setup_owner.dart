import 'package:badges/badges.dart';
import 'package:equipro/core/model/success_model.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rentals_view_model.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/ui/widget/rental_tiles.dart';
import 'package:equipro/utils/helpers.dart';
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

class SetupOwner extends StatefulWidget {
  const SetupOwner({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<SetupOwner> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeOwnerViewModel>.reactive(
        viewModelBuilder: () => HomeOwnerViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              key: _scaffoldKey,
              body:SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: AnimationLimiter(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 200),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                    horizontalOffset:
                                        -MediaQuery.of(context).size.width / 4,
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
                                    Container(
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
                                            ))),
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
                                Text(
                                  "Setup An Equipment Owner’s Account",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DefaultTabController(
                                    length: 2,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TabBar(
                                            controller: _controller,
                                            unselectedLabelColor: Colors.grey,
                                            indicatorWeight: 3,
                                            labelStyle: TextStyle(fontSize: 12),
                                            labelColor: AppColors.primaryColor,
                                            indicatorColor:
                                                AppColors.primaryColor,
                                            tabs: [
                                              Tab(
                                                text: "Contact",
                                              ),
                                              Tab(
                                                text: "Payment",
                                              ),
                                            ],
                                          ),
                                        ])),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                    height: Responsive.height(context) / 1.7,
                                    child: TabBarView(
                                      controller: _controller,
                                      children: [
                                        ListView(
                                          children: [
                                            Text(
                                              "Address",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: addressController,
                                              decoration: InputDecoration(
                                                hintText: '',
                                                hintStyle: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey),
                                                ),
                                                disabledBorder:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey),
                                                ),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide:
                                                      const BorderSide(),
                                                ),
                                              ),
                                              keyboardType: TextInputType.name,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            GeneralButton(
                                                onPressed: () async{
                                                  if (addressController.text.isNotEmpty) {
                                                    var result = await model
                                                        .updateAddress(
                                                        addressController.text);
                                                    if (result != null) {
                                                      _controller.animateTo(1);
                                                    }
                                                  }else{
                                                    showErrorToast("Address is compulsory");
                                                  }
                                                },
                                                buttonText: "Save & Proceed")
                                          ],
                                        ),
                                        ListView(
                                          children: [
                                            Text(
                                              "Setup your preferred payment method",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "How to do want your money deposited",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              width: Responsive.width(context),
                                              height: 160,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Direct to Local Bank (USD)",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Deposit directly to your local bank  in  USD",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Container(
                                                      width: 200,
                                                      height: 30,
                                                      child: GeneralButton(
                                                          onPressed: () {
                                                            _navigationService.navigateTo(HomeOwnerRoute);
                                                          },
                                                          buttonText: "SETUP",
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(5),
                                                          ))),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              width: Responsive.width(context),
                                              height: 160,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Paypal",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Link your paypal account to deposit to be made directly",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Container(
                                                      width: 200,
                                                      height: 30,
                                                      child: GeneralButton(
                                                          onPressed: () {
                                                            _navigationService.pushAndRemoveUntil(HomeOwnerRoute);
                                                          },
                                                          buttonText: "SETUP",
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(5),
                                                          ))),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                              ]))))));
        });
  }
}

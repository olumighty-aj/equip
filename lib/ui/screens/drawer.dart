import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/chat/chat.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/active_rentals.dart';
import 'package:equipro/ui/screens/hirer/home/home_view_model.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/screens/profile/profile.dart';
import 'package:equipro/ui/screens/terms_and_condition/terms_condition_screen.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/app_svgs.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../../core/enums/dialog_type.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  const CollapsingNavigationDrawer({Key? key}) : super(key: key);

  @override
  CollapsingNavigationDrawerState createState() {
    return CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with TickerProviderStateMixin {
  double maxWidth = 300;
  double minWidth = 90;
  bool isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;
  final _navigationService = locator<NavigationService>();
  final Authentication _authentication = locator<Authentication>();

  HomeViewModel model = HomeViewModel();

  displayDialog(BuildContext context, HomeViewModel model) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15),
        ),
        content: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Confirm switch to Owner?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BaseButton(
                        hasBorder: true,
                        label: 'No',
                        onPressed: () {
                          Navigator.pop(context);
                          // if(_authentication.currentUser.address == null){
                          //   _navigationService.navigateTo(SetupOwnerRoute);
                          // }else{
                          //   _navigationService.pushAndRemoveUntil(HomeOwnerRoute);
                          // }
                        },
                      ),
                    ),
                    Gap(15),
                    Expanded(
                      child: BaseButton(
                        label: 'Yes',
                        onPressed: () {
                          Navigator.pop(context);
                          model.newSwitchRole(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Material(
        color: Color(0XFFF5F5F5),
        elevation: 10.0,
        child: SizedBox(
          width: maxWidth,
          height: deviceHeight,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      color: AppColors.white,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.clear,
                          color: AppColors.primaryColor,
                        ))),
              ),
              GestureDetector(
                  onTap: () {
                    _navigationService.navigateTo(homeRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  _authentication.currentUser.hirersPath != null
                                      ? _authentication.currentUser.hirersPath!
                                      : "",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                radius: 40,
                                backgroundColor: AppColors.grey,
                                child: SvgPicture.asset(AppSvgs.svgLogo),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_authentication.currentUser.fullname!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w800))
                              ],
                            ),
                          ]),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Row(
                  children: [
                    Container(
                      height: 23,
                      width: 3,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Home',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  //  _navigationService.navigateTo(draftRoute);
                },
              ),
              ListTile(
                  title: const Text(
                    'Active Rentals',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Rentals()))),
              ListTile(
                  title: const Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Chat()))),
              ListTile(
                  title: const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()))),
              // ListTile(
              //   title: const Text(
              //     'Settings',
              //     style: TextStyle(fontSize: 16),
              //   ),
              //   onTap: () => Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => SettingScreen())),
              // ),
              Divider(
                thickness: 1,
              ),
              if (_authentication.currentUser.kycApproved! != "approved")
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Post your equipments for hire and generate instant revenue",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              BaseButton(
                label: _authentication.isOwner == true
                    ? "Switch to Owner"
                    : "Become An Equipment Owner",
                onPressed: () {
                  if (_authentication.isOwner == true) {
                    displayDialog(context, model);
                  } else {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => EditProfile()));
                    showErrorToast(
                        "Oops, you're not an owner or yet to be verified.",
                        context: context);
                  }
                },
              ),
              if (_authentication.currentUser.kycApproved! != "approved")
                SizedBox(
                  height: 50,
                ),
              ListTile(
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsAndConditionScreen())),
              ),
              ListTile(
                title: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  locator<DialogService>()
                      .showCustomDialog(variant: DialogType.logout);
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ));
  }
}

import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/tiny_db.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OwnerDrawer extends StatefulWidget {
  const OwnerDrawer({Key? key}) : super(key: key);

  @override
  CollapsingNavigationDrawerState createState() {
    return CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<OwnerDrawer>
    with TickerProviderStateMixin {
  double maxWidth = 300;
  double minWidth = 90;
  bool isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;
  final NavigationService _navigationService = locator<NavigationService>();
  final Authentication _authentication = locator<Authentication>();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(""),
                  Container(
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
                            Icons.clear,
                            color: AppColors.primaryColor,
                          )))
                ],
              ),
              InkWell(
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
                              imageUrl: "https://i.pravatar.cc/",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                radius: 40,
                                backgroundColor: AppColors.grey,
                                child: Image.asset(
                                  "assets/images/user.png",
                                  scale: 2,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amandan ",
                                  //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Banks",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
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
                onTap: () {
                  _navigationService.navigateTo(RentalsRoute);
                },
              ),
              ListTile(
                title: const Text(
                  'Earnings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  _navigationService.navigateTo(EarningPageRoute);
                },
              ),
              ListTile(
                title: const Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                   _navigationService.navigateTo(chatRoute);
                },
              ),
              ListTile(
                title: const Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                   _navigationService.navigateTo(ProfileRoute);
                },
              ),
              // ListTile(
              //   title: const Text(
              //     'Settings',
              //     style: TextStyle(fontSize: 16),
              //   ),
              //   onTap: () {
              //     TinyDb.removeAll();
              //     _navigationService.navigateTo(loginRoute);
              //   },
              // ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 30,
              ),

              GeneralButton(
                buttonText: "Switch to Equipment Hirer",
                onPressed: () {
                  _navigationService.pushAndRemoveUntil(HomeOwnerRoute);
                },
              ),
              SizedBox(
                height: 50,
              ),
              ListTile(
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  TinyDb.removeAll();
                  _navigationService.navigateTo(loginRoute);
                },
              ),
              ListTile(
                title: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  TinyDb.removeAll();
                  _navigationService.navigateTo(loginRoute);
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

import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/bottom_navigation/bottom_nav_model_view.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/tiny_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final NavigationService _navigationService = locator<NavigationService>();
  final Authentication _authentication = locator<Authentication>();
  AppStateProvider appStateProvider = AppStateProvider();

  @override
  void initState() {
    super.initState();
    appStateProvider = AppStateProvider.of(context);
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
        elevation: 10.0,
        child: SizedBox(
          width: maxWidth,
          height: deviceHeight,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              InkWell(
                  onTap: () {
                    appStateProvider.setCurrentTabTo(newTabIndex: 3);
                    _navigationService.navigateTo(bottomNavigationRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //     passBackButton(context,
                      //         back: 'back');
                      //   },
                      //   child:
                      //   Container(
                      //     margin: EdgeInsets.only(right: 10.0),
                      //     height: 80.0,
                      //     width: 80.0,
                      //     decoration: BoxDecoration(
                      //
                      //       image: DecorationImage(
                      //
                      //           image:   CachedNetworkImageProvider(
                      //               _authentication
                      //                   .currentUser
                      //                   .picture != null?    _authentication
                      //                   .currentUser
                      //                   .picture: ''), fit: BoxFit.cover),
                      //
                      //       borderRadius: BorderRadius.circular(7.0),
                      //     ),
                      //   ),
                      // ),
                      Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/dummy_dp.png',
                                width: 60.0,
                                height: 60.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.white,
                            //   radius: 25,
                            //   child: Image.asset("assets/images/dummy_dp.png"),
                            // ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Amandan Banks",
                                  //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "@ama",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ]),

                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.clear,
                          ))
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/draft.svg",
                  width: 23.0,
                ),
                title: const Text(
                  'Drafts',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                //  _navigationService.navigateTo(draftRoute);
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/bookmark.svg",
                  width: 23.0,
                ),
                title: const Text(
                  'Bookmarks',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  //_navigationService.navigateTo(bookMarkRoute);
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/setting.svg",
                  width: 23.0,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                 // _navigationService.navigateTo(settingsRoute);
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/money.svg",
                  width: 23.0,
                ),
                title: const Text(
                  'Monetization',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                 // _navigationService.navigateTo(bookMarkRoute);
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/logout.svg",
                  width: 23.0,
                ),
                title: const Text(
                  'Logout',
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

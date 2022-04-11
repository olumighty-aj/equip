import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/bottom_navigation/bottom_nav_model_view.dart';
import 'package:equipro/ui/screens/home/home_view.dart';
import 'package:equipro/ui/screens/login/login_view.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BottomNavigation> {
  final Authentication _authentication = locator<Authentication>();
  final NavigationService _navigationService = locator<NavigationService>();

  late String counter;
  Widget getViewForIndex(int index) {
    print('jdjdsjds:::::::::::::::::');
    print(index);
    switch (index) {
      case 0:
        return Home();

      case 1:
        return Home();
      case 2:
        return Home();
      case 3:
        return Home();
      case 4:
        return Home();
      default:
        return Login();
    }
  }

  @override
  void initState() {
    // call();
    // model. notificationCounter();
    super.initState();
  }
  // call()async{
  //   var result =await _authentication.notificationCountCall();
  //   setState(() {
  //     counter= result.toString();
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(builder: (context, model, _) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: getViewForIndex(model.currentTabIndex),
        // pageList[model.currentTabIndex],
        // pageList[_selectedIndex],
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppColors.primaryColor,
        //   splashColor: AppColors.primaryColor,
        //   onPressed: () {
        //     _navigationService.navigateTo(postRoute);
        //
        //     //code to execute on button press
        //   },
        //   child: Icon(Icons.add), //icon inside button
        // ),

        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // isSelected: appNotifier.currentTabIndex == 1,
          // appNotifier.setCurrentTabTo(newTabIndex: 1);
          onTap: (newTab) {
            print(newTab);
            model.setCurrentTabTo(newTabIndex: newTab);
          },
          // onTap: (newTab) => setState(() =>
          // _selectedIndex =  appNotifier.setCurrentTabTo(newTabIndex: 1),),
          currentIndex: model.currentTabIndex,
          items: [
            // final List<String> _icons = [
            //   "assets/images/home.svg",
            //   "assets/images/message.svg",
            //   "assets/images/notification.svg",
            //   "assets/images/user.svg"
            //   ];
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/home.svg",
                width: 23.0,
                color: model.currentTabIndex == 0
                    ? AppColors.primaryColor
                    : Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/payment.svg",
                width: 23.0,
                color: model.currentTabIndex == 1
                    ? AppColors.primaryColor
                    : Colors.black,
              ),
              label: 'Payment',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/hr.svg",
                width: 23.0,
                color: model.currentTabIndex == 2
                    ? AppColors.primaryColor
                    : Colors.black,
              ),
              label: 'HR',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                    "assets/images/inventory.svg",
                    width: 23.0,
                    color: model.currentTabIndex == 3
                        ? AppColors.primaryColor
                        : Colors.black,
                  ),
              label: 'Inventory',
            ),
            BottomNavigationBarItem(
              icon:  CachedNetworkImage(
                imageUrl: "https://i.pravatar.cc/",
                imageBuilder: (context, imageProvider) => Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.grey,
                  child: Image.asset(
                    "assets/images/logo.png",
                    scale: 2.5,
                  ),
                ),
              ) ,
              label: 'Account',
            ),
          ],
          selectedItemColor: AppColors.primaryColor,
        ),
      );
    });
  }
}

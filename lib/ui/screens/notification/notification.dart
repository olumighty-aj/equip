import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/ui/widget/chat_widget.dart';
import 'package:equipro/ui/widget/noti_widget.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<NotificationPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String fcmToken;

  late bool active = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              key: _scaffoldKey,
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              curve: Curves.fastOutSlowIn, child: widget),
                        ),
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
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
                                  ))),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Notification',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("")
                              // SvgPicture.asset(
                              //   "assets/images/sort.svg",
                              //   width: 23.0,
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 60.0,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search_outlined,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 20.0),
                                hintText: "Search",
                                //hintText: tr.text( "Upcoming feature"),
                                hintStyle: TextStyle(
                                  color: Color(0XFF818181),
                                  fontSize: 15,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  // searchWord = value;
                                  // print(searchWord);
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          NotiItem(
                            onPressed: () {
                              _navigationService
                                  .navigateTo(chatDetailsPageRoute);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          NotiItem(
                            onPressed: () {
                              _navigationService
                                  .navigateTo(chatDetailsPageRoute);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          NotiItem(
                            onPressed: () {
                              _navigationService
                                  .navigateTo(chatDetailsPageRoute);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          NotiItem(
                            onPressed: () {
                              _navigationService
                                  .navigateTo(chatDetailsPageRoute);
                            },
                          ),
                        ],
                      ),
                    ),
                  )));
        });
  }
}

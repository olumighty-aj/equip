import 'package:equipro/core/model/NotificationModel.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/widget/chat_widget.dart';
import 'package:equipro/ui/widget/input_fields/custom_text_field.dart';
import 'package:equipro/ui/widget/noti_widget.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<NotificationPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String fcmToken;
  Future<List<NotificationModel>>? myFuture;
  late bool active = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeOwnerViewModel>.reactive(
        onModelReady: (model) {
          myFuture = model.getNewNotification();
        },
        viewModelBuilder: () => HomeOwnerViewModel(),
        builder: (context, model, child) {
          return WillPopScope(
              onWillPop: () async {
                // _navigationService.pushAndRemoveUntil();
                return true;
              },
              child: Scaffold(
                  key: _scaffoldKey,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Text(
                          'Notification',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        FutureBuilder<List<NotificationModel>>(
                            future: myFuture,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Expanded(
                                  child: Container(
                                      height: Responsive.height(context) / 2,
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Center(
                                        child: Shimmer.fromColors(
                                            direction: ShimmerDirection.ltr,
                                            period: const Duration(seconds: 2),
                                            baseColor:
                                                AppColors.grey.withOpacity(0.5),
                                            highlightColor: Colors.white,
                                            child: ListView(
                                              scrollDirection: Axis.vertical,
                                              // shrinkWrap: true,
                                              children: [0, 1, 2, 3]
                                                  .map((_) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: 8.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            2.0),
                                                                  ),
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: 8.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            2.0),
                                                                  ),
                                                                  Container(
                                                                    width: 40.0,
                                                                    height: 8.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ))
                                                  .toList(),
                                            )),
                                      )),
                                );
                              } else if (snapshot.data!.isNotEmpty) {
                                return Expanded(
                                  child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      // shrinkWrap: true,
                                      children: snapshot.data!
                                          .map(
                                            (feed) => NotiItem(feed: feed),
                                          )
                                          .toList()),
                                );
                              } else if (snapshot.hasError) {
                                return Expanded(
                                  child: Center(
                                      child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                        'Network error',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Network error'),
                                      SizedBox(
                                        height: 100,
                                      ),
                                    ],
                                  )),
                                );
                              } else {
                                return Expanded(
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "No Notifications available",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )),
                                );
                              }
                            }),
                      ],
                    ),
                  )));
        });
  }
}

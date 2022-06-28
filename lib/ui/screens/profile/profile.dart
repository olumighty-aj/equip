import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/screens/profile/profile_view_model.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/ui/widget/reviews_widget.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Profile> with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Authentication _authentication = locator<Authentication>();
  TextEditingController emailController = TextEditingController();
  AnimationController? _navController;
  Animation<Offset>? _navAnimation;
  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    _navAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.99),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _navController!,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _navController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: AnimationLimiter(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 200),
                                childAnimationBuilder: (widget) =>
                                    SlideAnimation(
                                      horizontalOffset:
                                          -MediaQuery.of(context).size.width /
                                              4,
                                      child: FadeInAnimation(
                                          curve: Curves.fastOutSlowIn,
                                          child: widget),
                                    ),
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          //  margin: EdgeInsets.all(20),
                                          padding: EdgeInsets.only(left: 8),
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
                                              )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(children: [
                                    Text(
                                      "Profile",
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: 150.0,
                                        height: 150.0,
                                        child: Image.asset(
                                            "assets/images/dot_circle.png"),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, top: 13),
                                          child: CachedNetworkImage(
                                            imageUrl: _authentication
                                                        .currentUser
                                                        .hirersPath !=
                                                    null
                                                ? _authentication
                                                    .currentUser.hirersPath!
                                                : baseUrl,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 120.0,
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    CircleAvatar(
                                              radius: 60,
                                              backgroundColor: AppColors.grey,
                                              child: Image.asset(
                                                "assets/images/icon.png",
                                                scale: 2,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    _authentication.currentUser.fullname!,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _authentication.currentUser.email!,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        _navigationService
                                            .navigateTo(EditProfileRoute);
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                "assets/images/edit.svg"),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Edit profile",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ])),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Text(
                                  //   "Profile 60% Completed",
                                  //   style: TextStyle(
                                  //       color: AppColors.red,
                                  //       fontWeight: FontWeight.w400,
                                  //       fontSize: 15),
                                  // ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  FittedBox(
                                      child: Container(
                                          padding: EdgeInsets.all(20),
                                          height: 300,
                                          width: Responsive.width(context),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      height: 70,
                                                      child: Text(
                                                        "Phone Number",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      )),
                                                  Container(
                                                      height: 100,
                                                      child: Text(
                                                        "Address",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      )),
                                                  Container(
                                                      height: 80,
                                                      child: Text(
                                                        "Means of ID",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      )),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    height: 70,
                                                    width: 200,
                                                    child: Text(
                                                      _authentication
                                                                  .currentUser
                                                                  .phoneNumber !=
                                                              null
                                                          ? _authentication
                                                              .currentUser
                                                              .phoneNumber!
                                                          : "Not updated",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 100,
                                                    width: 200,
                                                    child: Text(
                                                        _authentication
                                                                    .currentUser
                                                                    .address !=
                                                                null
                                                            ? _authentication
                                                                .currentUser
                                                                .address!
                                                            : "Not updated ",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  // Container(
                                                  //     height: 80,
                                                  //     width: 200,
                                                  //     child: Column(
                                                  //       mainAxisAlignment:
                                                  //           MainAxisAlignment.start,
                                                  //       crossAxisAlignment:
                                                  //           CrossAxisAlignment
                                                  //               .start,
                                                  //       children: [
                                                  // Text(
                                                  //     "National Identification Card",
                                                  //     style: TextStyle(
                                                  //         color:
                                                  //             Colors.grey,
                                                  //         fontSize: 15,
                                                  //         fontWeight:
                                                  //             FontWeight
                                                  //                 .w500)),
                                                  // SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                  Container(
                                                    width: 110,
                                                    height: 30,
                                                    child: GeneralButton(
                                                      onPressed: () {},
                                                      splashColor:
                                                          Color(0xCC4EA14D)
                                                              .withOpacity(0.3),
                                                      buttonText:
                                                          _authentication
                                                                  .currentUser
                                                                  .kycApproved!
                                                              ? "Verified"
                                                              : "Not Verified",
                                                      buttonTextColor:
                                                          Color(0xff247322),
                                                    ),
                                                  )
                                                  //   ],
                                                  // ))
                                                ],
                                              ),
                                            ],
                                          ))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _authentication.currentUser.userType ==
                                          "hirers"
                                      ? Container(
                                          height:
                                              Responsive.height(context) / 3,
                                          child: FutureBuilder<
                                                  List<ReviewsModel>>(
                                              future: model.getReviews(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Container(
                                                      height: 400,
                                                      padding: EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20),
                                                      child: Center(
                                                        child:
                                                            Shimmer.fromColors(
                                                                direction:
                                                                    ShimmerDirection
                                                                        .ltr,
                                                                period:
                                                                    Duration(
                                                                        seconds:
                                                                            2),
                                                                child: ListView(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  // shrinkWrap: true,
                                                                  children: [
                                                                    0,
                                                                    1,
                                                                    2,
                                                                    3
                                                                  ]
                                                                      .map((_) =>
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: double.infinity,
                                                                                        height: 8.0,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                                                      ),
                                                                                      Container(
                                                                                        width: double.infinity,
                                                                                        height: 8.0,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 40.0,
                                                                                        height: 8.0,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                ),
                                                                baseColor:
                                                                    AppColors
                                                                        .grey,
                                                                highlightColor:
                                                                    Colors
                                                                        .white),
                                                      ));
                                                } else if (snapshot
                                                    .data!.isNotEmpty) {
                                                  return ListView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      // shrinkWrap: true,
                                                      children: snapshot.data!
                                                          .map((feed) =>
                                                              Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      ReviewItem(
                                                                    feed: feed,
                                                                  )))
                                                          .toList());
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 100,
                                                      ),
                                                      Text(
                                                        'Network error',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                  ));
                                                } else {
                                                  return Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "No reviews yet.",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .black),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                    ],
                                                  ));
                                                }
                                              }),
                                        )
                                      : Container(),
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

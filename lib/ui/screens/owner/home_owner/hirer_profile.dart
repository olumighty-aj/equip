import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/EquipmentModel.dart' as eq;
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/profile/profile_view_model.dart';
import 'package:equipro/ui/widget/reviews_widget.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class HirerProfile extends StatefulWidget {
  final eq.Hirers feed;

  const HirerProfile({Key? key, required this.feed}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<HirerProfile> with TickerProviderStateMixin {
  final NavService _navigationService = locator<NavService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                                            imageUrl:
                                                widget.feed.hirersPath != null
                                                    ? widget.feed.hirersPath!
                                                    : "",
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
                                                "assets/images/logo.png",
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
                                    widget.feed.fullname!,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.feed.email!,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      height: 200,
                                      width: Responsive.width(context),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
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
                                                    "Phone Number ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  )),
                                              Container(
                                                  height: 70,
                                                  child: Text(
                                                    "Address",
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
                                                  widget.feed.phoneNumber!,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                    widget.feed.address!,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Reviews",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Here are what other equipment owners have said about this hirer",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: Responsive.height(context) / 3,
                                    child: FutureBuilder<List<ReviewsModel>>(
                                        future: model.getHirerReviews(
                                            widget.feed.id.toString()),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Container(
                                                height: 400,
                                                padding: EdgeInsets.only(
                                                    left: 20.0, right: 20),
                                                child: Center(
                                                  child: Shimmer.fromColors(
                                                      direction:
                                                          ShimmerDirection.ltr,
                                                      period:
                                                          Duration(seconds: 2),
                                                      child: ListView(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        // shrinkWrap: true,
                                                        children: [0, 1, 2, 3]
                                                            .map((_) => Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                8.0),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
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
                                                      baseColor: AppColors.grey,
                                                      highlightColor:
                                                          Colors.white),
                                                ));
                                          } else if (snapshot
                                              .data!.isNotEmpty) {
                                            return ListView(
                                                scrollDirection: Axis.vertical,
                                                // shrinkWrap: true,
                                                children: snapshot.data!
                                                    .map((feed) => Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: ReviewItem(
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
                                            ));
                                          } else {
                                            return Center(
                                                child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "No reviews yet.",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                              ],
                                            ));
                                          }
                                        }),
                                  ),
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

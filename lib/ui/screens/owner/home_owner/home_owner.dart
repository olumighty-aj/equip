import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/core/model/enums.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/notification/notification.dart';
import 'package:equipro/ui/screens/owner/drawer_owner.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/screens/owner/home_owner/post_equipment.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/ui/widget/loader_widget.dart';
import 'package:equipro/ui/widget/owner_equip.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';

class HomeOwner extends StatefulWidget {
  const HomeOwner({Key? key}) : super(key: key);

  @override
  HomeOwnerState createState() => HomeOwnerState();
}

class HomeOwnerState extends State<HomeOwner> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final NavService _navigationService = locator<NavService>();
  String searchWord = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeOwnerViewModel>.reactive(
        viewModelBuilder: () => HomeOwnerViewModel(),
        onViewModelReady: (model) => model.init(context),
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            body: Padding(
                padding: EdgeInsets.all(20),
                child: AnimationLimiter(
                    child: SingleChildScrollView(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _scaffoldKey.currentState!.openDrawer();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/hamburger.svg",
                                  ),
                                ),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Equipments",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  BaseButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PostEquipment())),
                                    label: "Post New Equipment",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Responsive.width(context) / 1.3,
                                    child: TextFormField(
                                      //extAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.search_outlined,
                                          color: AppColors.grey,
                                          size: 30,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 20.0),
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          color: Color(0XFF818181),
                                          fontSize: 12,
                                        ),
                                        // fillColor: Colors.white,
                                        // filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          searchWord = value;
                                          print(searchWord);
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NotificationPage())),
                                      child: Badge(
                                        label: Text(
                                          "0",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        child: SvgPicture.asset(
                                            "assets/images/notification.svg"),
                                      ))
                                ]),
                            SizedBox(
                              height: 30,
                            ),
                            Builder(builder: (context) {
                              if (searchWord.isEmpty) {
                                return Container(
                                  height: Responsive.height(context) / 2,
                                  child: ViewModelBuilder<
                                          HomeOwnerViewModel>.reactive(
                                      viewModelBuilder: () =>
                                          HomeOwnerViewModel(),
                                      onModelReady: (vm) {
                                        vm.getMyEquipment();
                                        vm.controller = new ScrollController()
                                          ..addListener(() {
                                            vm.getMyEquipmentMore();
                                          });
                                      },
                                      builder: (context, v, child) {
                                        if (v.fetchState ==
                                            LoadingState.loading) {
                                          return Container(
                                              height: 400,
                                              padding: EdgeInsets.all(20.0),
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
                                                          .map((_) =>
                                                              LoaderWidget())
                                                          .toList(),
                                                    ),
                                                    baseColor: AppColors.white,
                                                    highlightColor:
                                                        AppColors.grey),
                                              ));
                                        } else if (v.fetchState ==
                                            LoadingState.done) {
                                          if (v.packageList.isNotEmpty) {
                                            return SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                controller: v.controller,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                // shrinkWrap: true,
                                                child: Column(
                                                  children: [
                                                    Column(
                                                        children: v.packageList
                                                            .map((feed) =>
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        // _navigationService.navigateTo(
                                                                        //     OrderInfoRoute,
                                                                        //     arguments: feed);
                                                                      },
                                                                      child: OwnerEquipTiles(
                                                                          model:
                                                                              feed),
                                                                    )))
                                                            .toList()),
                                                    SizedBox(height: 20),
                                                    v.loadingState ==
                                                            LoadingState.loading
                                                        ? Container(
                                                            height: 400,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20.0),
                                                            child: Center(
                                                              child: Shimmer
                                                                  .fromColors(
                                                                      direction:
                                                                          ShimmerDirection
                                                                              .ltr,
                                                                      period: Duration(
                                                                          seconds:
                                                                              2),
                                                                      child:
                                                                          ListView(
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        // shrinkWrap: true,
                                                                        children:
                                                                            [
                                                                          0,
                                                                          1,
                                                                        ].map((_) => LoaderWidget()).toList(),
                                                                      ),
                                                                      baseColor:
                                                                          AppColors
                                                                              .white,
                                                                      highlightColor:
                                                                          AppColors
                                                                              .grey),
                                                            ))
                                                        : SizedBox(height: 1)
                                                  ],
                                                ));
                                          } else {
                                            return Center(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "No equipment saved yet",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primaryColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "When you do they will be here",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primaryColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                              ],
                                            ));
                                          }
                                        } else {
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
                                        }
                                      }),
                                );
                              } else {
                                return Container(
                                  height: Responsive.height(context) / 2,
                                  child: FutureBuilder<List<EquipmentModel>>(
                                      future:
                                          model.searchMyEquipment(searchWord),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container(
                                              height: 400,
                                              padding: EdgeInsets.all(20.0),
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
                                                          .map((_) =>
                                                              LoaderWidget())
                                                          .toList(),
                                                    ),
                                                    baseColor: AppColors.white,
                                                    highlightColor:
                                                        AppColors.grey),
                                              ));
                                        } else if (snapshot.data!.isNotEmpty) {
                                          return ListView(
                                              children: snapshot.data!
                                                  .map((feed) =>
                                                      OwnerEquipTiles(
                                                          model: feed))
                                                  .toList());
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
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
                                                height: 10,
                                              ),
                                            ],
                                          ));
                                        } else {
                                          return Center(
                                              child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Equipment not found',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Equipment not found',
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ));
                                        }
                                      }),
                                );
                              }
                            }),
                            searchWord.isEmpty
                                ? Container(
                                    height: Responsive.height(context) / 2,
                                    child:
                                        ViewModelBuilder<
                                                HomeOwnerViewModel>.reactive(
                                            viewModelBuilder: () =>
                                                HomeOwnerViewModel(),
                                            onModelReady: (vm) {
                                              vm.getMyEquipment();
                                              vm.controller =
                                                  new ScrollController()
                                                    ..addListener(() {
                                                      vm.getMyEquipmentMore();
                                                    });
                                            },
                                            builder: (context, v, child) {
                                              if (v.fetchState ==
                                                  LoadingState.loading) {
                                                return Container(
                                                    height: 400,
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    child: Center(
                                                      child: Shimmer.fromColors(
                                                          direction:
                                                              ShimmerDirection
                                                                  .ltr,
                                                          period: Duration(
                                                              seconds: 2),
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
                                                                    LoaderWidget())
                                                                .toList(),
                                                          ),
                                                          baseColor:
                                                              AppColors.white,
                                                          highlightColor:
                                                              AppColors.grey),
                                                    ));
                                              } else if (v.fetchState ==
                                                  LoadingState.done) {
                                                if (v.packageList.isNotEmpty) {
                                                  return SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      controller: v.controller,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      // shrinkWrap: true,
                                                      child: Column(
                                                        children: [
                                                          Column(
                                                              children: v
                                                                  .packageList
                                                                  .map((feed) =>
                                                                      Padding(
                                                                          padding: EdgeInsets.all(
                                                                              10),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              // _navigationService.navigateTo(
                                                                              //     OrderInfoRoute,
                                                                              //     arguments: feed);
                                                                            },
                                                                            child:
                                                                                OwnerEquipTiles(model: feed),
                                                                          )))
                                                                  .toList()),
                                                          SizedBox(height: 20),
                                                          v.loadingState ==
                                                                  LoadingState
                                                                      .loading
                                                              ? Container(
                                                                  height: 400,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20.0),
                                                                  child: Center(
                                                                    child: Shimmer.fromColors(
                                                                        direction: ShimmerDirection.ltr,
                                                                        period: Duration(seconds: 2),
                                                                        child: ListView(
                                                                          scrollDirection:
                                                                              Axis.vertical,
                                                                          // shrinkWrap: true,
                                                                          children:
                                                                              [
                                                                            0,
                                                                            1,
                                                                          ].map((_) => LoaderWidget()).toList(),
                                                                        ),
                                                                        baseColor: AppColors.white,
                                                                        highlightColor: AppColors.grey),
                                                                  ))
                                                              : SizedBox(
                                                                  height: 1)
                                                        ],
                                                      ));
                                                } else {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "No equipment saved yet",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .primaryColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "When you do they will be here",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .primaryColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  );
                                                }
                                              } else {
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
                                              }
                                            }),
                                  )
                                : Container(
                                    height: Responsive.height(context) / 2,
                                    child: FutureBuilder<List<EquipmentModel>>(
                                        future:
                                            model.searchMyEquipment(searchWord),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Container(
                                                height: 400,
                                                padding: EdgeInsets.all(20.0),
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
                                                            .map((_) =>
                                                                LoaderWidget())
                                                            .toList(),
                                                      ),
                                                      baseColor:
                                                          AppColors.white,
                                                      highlightColor:
                                                          AppColors.grey),
                                                ));
                                          } else if (snapshot
                                              .data!.isNotEmpty) {
                                            return ListView(
                                                children: snapshot.data!
                                                    .map((feed) =>
                                                        OwnerEquipTiles(
                                                            model: feed))
                                                    .toList());
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
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
                                                  height: 10,
                                                ),
                                              ],
                                            ));
                                          } else {
                                            return Center(
                                                child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Equipment not found',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Equipment not found',
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ));
                                          }
                                        }),
                                  ),
                          ])),
                ))),
            drawer: OwnerDrawer(),
          );
        });
  }
}

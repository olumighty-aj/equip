import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/ui/screens/owner/active_rentals/rentals_view_model.dart';
import 'package:equipro/ui/widget/rental_tiles.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/model/active_rentals/active_rentals.dart';
import '../../../../utils/app_svgs.dart';
import '../../profile/edit_profile.dart';

class OwnerRentals extends StatefulWidget {
  const OwnerRentals({Key? key}) : super(key: key);

  @override
  OwnerRentalsState createState() => OwnerRentalsState();
}

class OwnerRentalsState extends State<OwnerRentals>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OwnerRentalsViewModel>.reactive(
        viewModelBuilder: () => OwnerRentalsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                leading: CustomBackButton(),
              ),
              key: _scaffoldKey,
              body: Padding(
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
                                Text(
                                  "Active Rentals",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
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
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DefaultTabController(
                                    length: 4,
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
                                                text: "All",
                                              ),
                                              Tab(
                                                text: "Booked",
                                              ),
                                              Tab(
                                                text: "Received",
                                              ),
                                              Tab(
                                                text: "Returned",
                                              )
                                            ],
                                          ),
                                        ])),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "List of equipments you have booked for hire",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                Container(
                                    height: Responsive.height(context) / 2.7,
                                    child: TabBarView(
                                      controller: _controller,
                                      children: [
                                        Column(
                                          children: [
                                            Expanded(
                                              //  height: Responsive.height(context) / 1.3,
                                              child: FutureBuilder<
                                                      List<ActiveRentalsModel>>(
                                                  future: model
                                                      .activeRentals("all"),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Container(
                                                          height: 400,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20.0,
                                                                  right: 20),
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
                                                                      children: [
                                                                        0,
                                                                        1,
                                                                        2,
                                                                        3
                                                                      ]
                                                                          .map((_) =>
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
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
                                                          children: snapshot
                                                              .data!
                                                              .map((feed) => InkWell(
                                                                  onTap: () {},
                                                                  child: Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: RentalTiles(
                                                                        feed:
                                                                            feed,
                                                                      ))))
                                                              .toList());
                                                    } else if (snapshot
                                                        .hasError) {
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
                                                                  FontWeight
                                                                      .bold,
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
                                                          SvgPicture.asset(
                                                              AppSvgs
                                                                  .emptyRental),
                                                          Gap(50),
                                                          Text(
                                                            "You do not have an active rental",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          // SizedBox(
                                                          //   height: 30,
                                                          // ),
                                                        ],
                                                      ));
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Expanded(
                                              //  height: Responsive.height(context) / 1.3,
                                              child: FutureBuilder<
                                                      List<ActiveRentalsModel>>(
                                                  future: model
                                                      .activeRentals("booked"),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Container(
                                                          height: 400,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20.0,
                                                                  right: 20),
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
                                                                      children: [
                                                                        0,
                                                                        1,
                                                                        2,
                                                                        3
                                                                      ]
                                                                          .map((_) =>
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
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
                                                          children: snapshot
                                                              .data!
                                                              .map((feed) => InkWell(
                                                                  onTap: () {},
                                                                  child: Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: RentalTiles(
                                                                        feed:
                                                                            feed,
                                                                      ))))
                                                              .toList());
                                                    } else if (snapshot
                                                        .hasError) {
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
                                                                  FontWeight
                                                                      .bold,
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
                                                          SvgPicture.asset(
                                                              AppSvgs
                                                                  .emptyRental),
                                                          Gap(50),
                                                          Text(
                                                            "You do not have an active rental",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          // SizedBox(
                                                          //   height: 30,
                                                          // ),
                                                        ],
                                                      ));
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Expanded(
                                              //  height: Responsive.height(context) / 1.3,
                                              child: FutureBuilder<
                                                      List<ActiveRentalsModel>>(
                                                  future: model.activeRentals(
                                                      "received"),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Container(
                                                          height: 400,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20.0,
                                                                  right: 20),
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
                                                                      children: [
                                                                        0,
                                                                        1,
                                                                        2,
                                                                        3
                                                                      ]
                                                                          .map((_) =>
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
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
                                                          children: snapshot
                                                              .data!
                                                              .map((feed) => InkWell(
                                                                  onTap: () {},
                                                                  child: Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: RentalTiles(
                                                                        feed:
                                                                            feed,
                                                                      ))))
                                                              .toList());
                                                    } else if (snapshot
                                                        .hasError) {
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
                                                                  FontWeight
                                                                      .bold,
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
                                                          SvgPicture.asset(
                                                              AppSvgs
                                                                  .emptyRental),
                                                          Gap(50),
                                                          Text(
                                                            "You do not have an active rental",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          // SizedBox(
                                                          //   height: 30,
                                                          // ),
                                                        ],
                                                      ));
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Expanded(
                                              //  height: Responsive.height(context) / 1.3,
                                              child: FutureBuilder<
                                                      List<ActiveRentalsModel>>(
                                                  future: model.activeRentals(
                                                      "returned"),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Container(
                                                          height: 400,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20.0,
                                                                  right: 20),
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
                                                                      children: [
                                                                        0,
                                                                        1,
                                                                        2,
                                                                        3
                                                                      ]
                                                                          .map((_) =>
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
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
                                                          children: snapshot
                                                              .data!
                                                              .map((feed) => InkWell(
                                                                  onTap: () {},
                                                                  child: Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: RentalTiles(
                                                                        feed:
                                                                            feed,
                                                                      ))))
                                                              .toList());
                                                    } else if (snapshot
                                                        .hasError) {
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
                                                                  FontWeight
                                                                      .bold,
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
                                                          SvgPicture.asset(
                                                              AppSvgs
                                                                  .emptyRental),
                                                          Gap(50),
                                                          Text(
                                                            "You do not have an active rental",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          // SizedBox(
                                                          //   height: 30,
                                                          // ),
                                                        ],
                                                      ));
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                              ])))));
        });
  }
}

import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rentals_view_model.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/widget/input_fields/custom_text_field.dart';
import 'package:equipro/ui/widget/rental_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/utils/colors.dart';

import '../../../../utils/app_svgs.dart';

class Rentals extends StatefulWidget {
  const Rentals({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Rentals> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RentalsViewModel>.reactive(
        viewModelBuilder: () => RentalsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                leading: CustomBackButton(),
              ),
              key: _scaffoldKey,
              body: Padding(
                  padding: EdgeInsets.all(20),
                  child: DefaultTabController(
                    length: 4,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Active Rentals",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomSearchField(
                              hintText: "Search",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TabBar(
                              controller: _controller,
                              unselectedLabelColor: Colors.grey,
                              indicatorWeight: 3,
                              labelStyle: TextStyle(fontSize: 12),
                              labelColor: AppColors.primaryColor,
                              indicatorColor: AppColors.primaryColor,
                              isScrollable: true,
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
                            SizedBox(
                              height: 20,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: TabBarView(
                                controller: _controller,
                                children: [
                                  AllRentals(
                                    model: model,
                                  ),
                                  BookedRentals(
                                    model: model,
                                  ),
                                  ReceivedRentals(
                                    model: model,
                                  ),
                                  ReturnedRentals(model: model),
                                ],
                              ),
                            ),
                          ],
                        )),
                  )));
        });
  }
}

class ReturnedRentals extends StatelessWidget {
  final RentalsViewModel model;
  const ReturnedRentals({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActiveRentalsModel>>(
        future: model.activeRentals("returned"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                height: 400,
                padding: EdgeInsets.only(left: 20.0, right: 20),
                child: Center(
                  child: Shimmer.fromColors(
                      direction: ShimmerDirection.ltr,
                      period: Duration(seconds: 2),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        children: [0, 1, 2, 3]
                            .map((_) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
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
                      highlightColor: Colors.white),
                ));
          } else if (snapshot.data!.isNotEmpty) {
            return Column(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                children: snapshot.data!
                    .map((feed) => InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: RentalTiles(
                              feed: feed,
                            ))))
                    .toList());
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
            );
          } else {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(100),
                SvgPicture.asset(AppSvgs.emptyRental),
                Gap(50),
                Text(
                  "You do not have an active rental",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: 30,
                // ),
              ],
            );
          }
        });
  }
}

class ReceivedRentals extends StatelessWidget {
  final RentalsViewModel model;
  const ReceivedRentals({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActiveRentalsModel>>(
        future: model.activeRentals("received"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                height: 400,
                padding: EdgeInsets.only(left: 20.0, right: 20),
                child: Center(
                  child: Shimmer.fromColors(
                      direction: ShimmerDirection.ltr,
                      period: Duration(seconds: 2),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        children: [0, 1, 2, 3]
                            .map((_) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
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
                      highlightColor: Colors.white),
                ));
          } else if (snapshot.data!.isNotEmpty) {
            return Column(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                children: snapshot.data!
                    .map((feed) => InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: RentalTiles(
                              feed: feed,
                            ))))
                    .toList());
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text('Network error',
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(
                  height: 100,
                ),
              ],
            );
          } else {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(100),
                SvgPicture.asset(AppSvgs.emptyRental),
                Gap(50),
                Text(
                  "You do not have an active rental",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: 30,
                // ),
              ],
            );
          }
        });
  }
}

class BookedRentals extends StatelessWidget {
  final RentalsViewModel model;
  const BookedRentals({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActiveRentalsModel>>(
        future: model.activeRentals("booked"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                height: 400,
                padding: EdgeInsets.only(left: 20.0, right: 20),
                child: Center(
                  child: Shimmer.fromColors(
                      direction: ShimmerDirection.ltr,
                      period: Duration(seconds: 2),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        children: [0, 1, 2, 3]
                            .map((_) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
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
                      highlightColor: Colors.white),
                ));
          } else if (snapshot.data!.isNotEmpty) {
            return ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!
                    .map((feed) => InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: RentalTiles(
                              feed: feed,
                            ))))
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
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(100),
                SvgPicture.asset(AppSvgs.emptyRental),
                Gap(50),
                Text(
                  "You do not have an active rental",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: 30,
                // ),
              ],
            ));
          }
        });
  }
}

class AllRentals extends StatelessWidget {
  final RentalsViewModel model;
  const AllRentals({Key? key, required this.model})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActiveRentalsModel>>(
        future: model.activeRentals("all"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                height: 400,
                padding: EdgeInsets.only(left: 20.0, right: 20),
                child: Center(
                  child: Shimmer.fromColors(
                      direction: ShimmerDirection.ltr,
                      period: Duration(seconds: 2),
                      child: Column(
                        // scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        children: [0, 1, 2, 3]
                            .map((_) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
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
                      highlightColor: Colors.white),
                ));
          } else if (snapshot.data!.isNotEmpty) {
            return Column(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                children: snapshot.data!
                    .map((feed) => GestureDetector(
                        onTap: () {},
                        child: RentalTiles(
                          feed: feed,
                        )))
                    .toList());
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
            );
          } else {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(100),
                SvgPicture.asset(AppSvgs.emptyRental),
                Gap(50),
                Text(
                  "You do not have an active rental",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: 30,
                // ),
              ],
            );
          }
        });
  }
}

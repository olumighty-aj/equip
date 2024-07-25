import 'package:equipro/app/app_setup.logger.dart';
import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rentals_view_model.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/widget/input_fields/custom_text_field.dart';
import 'package:equipro/ui/widget/rental_tiles.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/model/active_rentals/active_rentals.dart';
import '../../../../utils/app_svgs.dart';

class Rentals extends StatefulWidget {
  const Rentals({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Rentals> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RentalsViewModel>.reactive(
        viewModelBuilder: () => RentalsViewModel(),
        onViewModelReady: (model) => model.getRentals(),
        builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                leading: CustomBackButton(),
              ),
              key: _scaffoldKey,
              body: NewActiveRentalsBody(model: model));
        });
  }
}

class NewActiveRentalsBody extends StatelessWidget {
  final RentalsViewModel model;
  const NewActiveRentalsBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Active Rentals",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Gap(20),
          CustomSearchField(
            hintText: "Search",
          ),
          Gap(20),
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: RefreshIndicator(
                onRefresh: () => model.refreshRentals(),
                color: AppColors.primaryColor,
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                        child: TabBar(
                          unselectedLabelColor: Colors.grey,
                          indicatorWeight: 3,
                          labelStyle: Theme.of(context).textTheme.bodySmall,
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
                      ),
                    ),
                    SliverFillRemaining(
                      child: TabBarView(
                        children: [
                          NewAllRentals(
                            model: model,
                          ),
                          NewBookedRentals(
                            model: model,
                          ),
                          NewReceivedRentals(
                            model: model,
                          ),
                          NewReturnedRentals(
                            model: model,
                          ),
                        ],
                      ),
                    )
                  ],
                  // children: [],
                ),
              ),
            ),
          ),
          // Gap(20),
        ],
      ),
    );
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
            return SingleChildScrollView(
              child: Column(
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
                      .toList()),
            );
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
            return SingleChildScrollView(
              child: Column(
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
                      .toList()),
            );
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

class NewAllRentals extends StatelessWidget {
  final RentalsViewModel model;
  const NewAllRentals({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (model.busy("all")) {
        return Container(
            height: 400,
            padding: EdgeInsets.only(left: 20.0, right: 20),
            child: Center(
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: Duration(seconds: 2),
                  child: Column(
                    children: [0, 1, 2, 3]
                        .map((_) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
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
      } else if (model.allRentals != null && model.allRentals!.isNotEmpty) {
        return SingleChildScrollView(
          child: Column(
              // scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              children: model.allRentals!
                  .map((feed) => GestureDetector(
                      onTap: () {},
                      child: RentalTiles(
                        feed: feed,
                      )))
                  .toList()),
        );
      } else if (model.allRentals != null && model.allRentals!.isEmpty) {
        return Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(100),
            SvgPicture.asset(AppSvgs.emptyRental),
            Gap(20),
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
      } else {
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
      }
    });
  }
}

class NewBookedRentals extends StatelessWidget {
  final RentalsViewModel model;
  const NewBookedRentals({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (model.busy("booked")) {
        return Container(
            height: 400,
            padding: EdgeInsets.only(left: 20.0, right: 20),
            child: Center(
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: Duration(seconds: 2),
                  child: Column(
                    children: [0, 1, 2, 3]
                        .map((_) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
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
      } else if (model.bookedRentals != null &&
          model.bookedRentals!.isNotEmpty) {
        return SingleChildScrollView(
          child: Column(
              children: model.bookedRentals!
                  .map((feed) => RentalTiles(
                        feed: feed,
                      ))
                  .toList()),
        );
      } else if (model.bookedRentals != null && model.bookedRentals!.isEmpty) {
        return Column(
          children: [
            Gap(100),
            SvgPicture.asset(AppSvgs.emptyRental),
            Gap(20),
            Text(
              "You do not have any booked rental",
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
      } else {
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
      }
    });
  }
}

class NewReceivedRentals extends StatelessWidget {
  final RentalsViewModel model;
  const NewReceivedRentals({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (model.busy("received")) {
        return Container(
            height: 400,
            padding: EdgeInsets.only(left: 20.0, right: 20),
            child: Center(
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: Duration(seconds: 2),
                  child: Column(
                    children: [0, 1, 2, 3]
                        .map((_) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
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
      } else if (model.receivedRentals != null &&
          model.receivedRentals!.isNotEmpty) {
        return SingleChildScrollView(
          child: Column(
              // scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              children: model.receivedRentals!
                  .map((feed) => GestureDetector(
                      onTap: () {},
                      child: RentalTiles(
                        feed: feed,
                      )))
                  .toList()),
        );
      } else if (model.receivedRentals != null &&
          model.receivedRentals!.isEmpty) {
        return Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(100),
            SvgPicture.asset(AppSvgs.emptyRental),
            Gap(20),
            Text(
              "You do not have any received rental",
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
      } else {
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
      }
    });
  }
}

class NewReturnedRentals extends StatelessWidget {
  final RentalsViewModel model;
  const NewReturnedRentals({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (model.busy("returned")) {
        return Container(
            height: 400,
            padding: EdgeInsets.only(left: 20.0, right: 20),
            child: Center(
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: Duration(seconds: 2),
                  child: Column(
                    children: [0, 1, 2, 3]
                        .map((_) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
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
      } else if (model.returnRentals != null &&
          model.returnRentals!.isNotEmpty) {
        return SingleChildScrollView(
          child: Column(
              // scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              children: model.returnRentals!
                  .map((feed) => GestureDetector(
                      onTap: () {},
                      child: RentalTiles(
                        feed: feed,
                      )))
                  .toList()),
        );
      } else if (model.returnRentals != null && model.returnRentals!.isEmpty) {
        return Column(
          children: [
            Gap(100),
            SvgPicture.asset(AppSvgs.emptyRental),
            Gap(20),
            Text(
              "You do not have any returned rental",
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
      } else {
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
      }
    });
  }
}

class AllRentals extends StatelessWidget {
  final RentalsViewModel model;
  const AllRentals({
    Key? key,
    required this.model,
  }) : super(
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
            return SingleChildScrollView(
              child: Column(
                  // scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                  children: snapshot.data!
                      .map((feed) => GestureDetector(
                          onTap: () {},
                          child: RentalTiles(
                            feed: feed,
                          )))
                      .toList()),
            );
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

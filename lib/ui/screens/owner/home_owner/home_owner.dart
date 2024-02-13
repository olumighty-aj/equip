import 'package:equipro/core/model/enums.dart';
import 'package:equipro/ui/screens/notification/notification.dart';
import 'package:equipro/ui/screens/owner/drawer_owner.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/screens/owner/home_owner/post_equipment.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/input_fields/custom_text_field.dart';
import 'package:equipro/ui/widget/loader_widget.dart';
import 'package:equipro/ui/widget/owner_equip.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/enums/dialog_type.dart';
import '../../../../utils/app_svgs.dart';

class HomeOwner extends StatefulWidget {
  const HomeOwner({Key? key}) : super(key: key);

  @override
  HomeOwnerState createState() => HomeOwnerState();
}

class HomeOwnerState extends State<HomeOwner> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
          return WillPopScope(
            onWillPop: () async {
              var res = await locator<DialogService>()
                  .showCustomDialog(variant: DialogType.exit);
              if (res != null && res.confirmed) {
                return true;
              } else {
                return false;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () => _scaffoldKey.currentState!.openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "assets/images/hamburger.svg",
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ),
              key: _scaffoldKey,
              body: Padding(
                padding: EdgeInsets.all(20),
                child: RefreshIndicator(
                  onRefresh: () async => model.refresh(context),
                  color: AppColors.primaryColor,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("My Equipments",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800)),
                          Gap(20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: BaseButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostEquipment())),
                              label: "Post New Equipment",
                            ),
                          ),
                          Gap(30),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomSearchField(
                                    hintText: "Search",
                                  ),
                                ),
                                Gap(10),
                                GestureDetector(
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
                          Gap(20),
                          NewEquipListBuilder(model: model)
                          // if (searchWord.isEmpty)
                          //   Container(
                          //     height: Responsive.height(context) / 2,
                          //     child: Builder(builder: (context) {
                          //       if (model.fetchState == LoadingState.loading) {
                          //         return Container(
                          //             height: 400,
                          //             padding: EdgeInsets.all(20.0),
                          //             child: Center(
                          //               child: Shimmer.fromColors(
                          //                   direction: ShimmerDirection.ltr,
                          //                   period: Duration(seconds: 2),
                          //                   child: ListView(
                          //                     scrollDirection: Axis.vertical,
                          //                     // shrinkWrap: true,
                          //                     children: [0, 1, 2, 3]
                          //                         .map((_) => LoaderWidget())
                          //                         .toList(),
                          //                   ),
                          //                   baseColor: AppColors.white,
                          //                   highlightColor: AppColors.grey),
                          //             ));
                          //       } else if (model.fetchState ==
                          //           LoadingState.done) {
                          //         if (model.packageList.isNotEmpty) {
                          //           return SingleChildScrollView(
                          //               scrollDirection: Axis.vertical,
                          //               controller: model.controller,
                          //               physics: BouncingScrollPhysics(),
                          //               // shrinkWrap: true,
                          //               child: Column(
                          //                 children: [
                          //                   Column(
                          //                       children: model.packageList
                          //                           .map((feed) =>
                          //                               OwnerEquipTiles(
                          //                                   model: feed))
                          //                           .toList()),
                          //                   SizedBox(height: 20),
                          //                   model.loadingState ==
                          //                           LoadingState.loading
                          //                       ? Container(
                          //                           height: 400,
                          //                           padding: EdgeInsets.all(20.0),
                          //                           child: Center(
                          //                             child: Shimmer.fromColors(
                          //                                 direction:
                          //                                     ShimmerDirection
                          //                                         .ltr,
                          //                                 period: Duration(
                          //                                     seconds: 2),
                          //                                 child: ListView(
                          //                                   scrollDirection:
                          //                                       Axis.vertical,
                          //                                   // shrinkWrap: true,
                          //                                   children: [
                          //                                     0,
                          //                                     1,
                          //                                   ]
                          //                                       .map((_) =>
                          //                                           LoaderWidget())
                          //                                       .toList(),
                          //                                 ),
                          //                                 baseColor:
                          //                                     AppColors.white,
                          //                                 highlightColor:
                          //                                     AppColors.grey),
                          //                           ))
                          //                       : SizedBox(height: 1)
                          //                 ],
                          //               ));
                          //         } else {
                          //           return Center(
                          //               child: Column(
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: [
                          //               SvgPicture.asset(AppSvgs.emptyRental),
                          //               Gap(50),
                          //               Text(
                          //                 "No equipments saved yet",
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .bodyMedium
                          //                     ?.copyWith(
                          //                         fontSize: 15,
                          //                         fontWeight: FontWeight.w600,
                          //                         color: Colors.grey),
                          //                 textAlign: TextAlign.center,
                          //               ),
                          //               // SizedBox(
                          //               //   height: 30,
                          //               // ),
                          //             ],
                          //           ));
                          //         }
                          //       } else {
                          //         return Center(
                          //             child: Column(
                          //           children: <Widget>[
                          //             SizedBox(
                          //               height: 100,
                          //             ),
                          //             Text(
                          //               'Network error',
                          //               style: TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 20,
                          //               ),
                          //             ),
                          //             SizedBox(
                          //               height: 10,
                          //             ),
                          //             Text('Network error'),
                          //             SizedBox(
                          //               height: 100,
                          //             ),
                          //           ],
                          //         ));
                          //       }
                          //     }),
                          //   ),
                          // if (searchWord.isNotEmpty)
                          //   Container(
                          //     height: Responsive.height(context) / 2,
                          //     child: FutureBuilder<List<EquipmentModel>>(
                          //         future: model.searchMyEquipment(searchWord),
                          //         builder: (context, snapshot) {
                          //           if (!snapshot.hasData) {
                          //             return Container(
                          //                 height: 400,
                          //                 padding: EdgeInsets.all(20.0),
                          //                 child: Center(
                          //                   child: Shimmer.fromColors(
                          //                       direction: ShimmerDirection.ltr,
                          //                       period: Duration(seconds: 2),
                          //                       child: ListView(
                          //                         scrollDirection: Axis.vertical,
                          //                         // shrinkWrap: true,
                          //                         children: [0, 1, 2, 3]
                          //                             .map((_) => LoaderWidget())
                          //                             .toList(),
                          //                       ),
                          //                       baseColor: AppColors.white,
                          //                       highlightColor: AppColors.grey),
                          //                 ));
                          //           } else if (snapshot.data!.isNotEmpty) {
                          //             return ListView(
                          //                 children: snapshot.data!
                          //                     .map((feed) =>
                          //                         OwnerEquipTiles(model: feed))
                          //                     .toList());
                          //           } else if (snapshot.hasError) {
                          //             return Center(
                          //                 child: Column(
                          //               children: <Widget>[
                          //                 SizedBox(
                          //                   height: 10,
                          //                 ),
                          //                 Text(
                          //                   'Network error',
                          //                   style: TextStyle(
                          //                     fontWeight: FontWeight.bold,
                          //                     fontSize: 20,
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 10,
                          //                 ),
                          //                 Text('Network error'),
                          //                 SizedBox(
                          //                   height: 10,
                          //                 ),
                          //               ],
                          //             ));
                          //           } else {
                          //             return Center(
                          //                 child: Column(
                          //               children: <Widget>[
                          //                 SizedBox(
                          //                   height: 10,
                          //                 ),
                          //                 Text(
                          //                   'Equipment not found',
                          //                   style: TextStyle(
                          //                     fontWeight: FontWeight.bold,
                          //                     fontSize: 20,
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 10,
                          //                 ),
                          //                 Text(
                          //                   'Equipment not found',
                          //                 ),
                          //                 SizedBox(
                          //                   height: 10,
                          //                 ),
                          //               ],
                          //             ));
                          //           }
                          //         }),
                          //   ),
                        ]),
                  ),
                ),
              ),
              drawer: OwnerDrawer(),
            ),
          );
        });
  }
}

class NewEquipListBuilder extends StatelessWidget {
  final HomeOwnerViewModel model;
  const NewEquipListBuilder({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (model.fetchState == LoadingState.loading) {
        return Container(
            height: 400,
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: Duration(seconds: 2),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    // shrinkWrap: true,
                    children: [0, 1, 2, 3].map((_) => LoaderWidget()).toList(),
                  ),
                  baseColor: AppColors.white,
                  highlightColor: AppColors.grey),
            ));
      } else if (model.fetchState == LoadingState.done &&
          model.packageList.isNotEmpty) {
        return Column(
          children: [
            Column(
                children: model.packageList
                    .map((feed) => OwnerEquipTiles(model: feed))
                    .toList()),
          ],
        );
      } else if (model.fetchState == LoadingState.done &&
          model.packageList.isEmpty) {
        return Center(
          child: Column(
            children: [
              Gap(100),
              SvgPicture.asset(AppSvgs.emptyRental),
              Text("No equipments saved yet")
            ],
          ),
        );
      } else {
        return Center(child: Text("Network Error"));
      }
    });
  }
}

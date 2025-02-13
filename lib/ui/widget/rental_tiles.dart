import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rentals_details.dart';
import 'package:equipro/ui/screens/owner/active_rentals/rentals_details.dart';
import 'package:equipro/utils/app_svgs.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../../core/model/active_rentals/active_rentals.dart';

class RentalTiles extends StatelessWidget {
  final ActiveRentalsModel feed;
  RentalTiles({required this.feed});
  final _navigationService = locator<NavigationService>();
  final Authentication authentication = locator<Authentication>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => EquipDetails()),
          // );

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      authentication.currentUser.userType == "hirers"
                          ? RentalDetails(feed: feed)
                          : OwnerRentalDetails(feed: feed)));
          // _navigationService.navigateTo(RentalDetailsRoute,
          //         arguments: feed)
          //     : _navigationService.navigateTo(OwnerRentalDetailsRoute,
          //         arguments: feed);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: feed.equipments!.id != null
                            ? feed
                                .equipments!.equip_images![0].equip_images_path!
                            : "",
                        placeholder: (context, url) => Container(
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  baseColor: AppColors.grey,
                                  highlightColor: Colors.white),
                            )),
                        errorWidget: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SvgPicture.asset(
                            AppSvgs.svgLogo,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ))),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      feed.equipments!.equip_name != null
                          ? feed.equipments!.equip_name!
                          : "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/location.svg",
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          // flex: 2,
                          child: Text(
                            feed.delivery_location ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 10, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: feed.request_status! == "pending"
                                ? Colors.orange.withOpacity(0.4)
                                : feed.request_status! == "rejected"
                                    ? AppColors.red.withOpacity(0.3)
                                    : feed.request_status! == "returned"
                                        ? AppColors.green.withOpacity(0.3)
                                        : feed.request_status! == "received"
                                            ? AppColors.blue.withOpacity(0.3)
                                            : feed.request_status! == "accepted"
                                                ? Colors.green.shade500
                                                : AppColors.primaryColor
                                                    .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          toBeginningOfSentenceCase(feed.request_status!)!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

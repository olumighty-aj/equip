import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/ui/screens/owner/home_owner/booking_details.dart';
// import 'package:equipro/core/model/equip_booking_model.dart' as equip;
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/services/activities_service.dart';

class BookingRequest extends StatelessWidget {
  final Map<String, dynamic> feed;
  final EquipmentModel? model;
  BookingRequest({
    required this.feed,
    this.model,
  });
  final _navigationService = locator<NavService>();
  final _activity = locator<Activities>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _activity.setModel(model);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingDetails(feed: feed)));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: CachedNetworkImage(
                          imageUrl: feed["equip_request"].first["hirers"]
                                      ["hirers_path"] !=
                                  null
                              ? feed["equip_request"].first["hirers"]
                                  ["hirers_path"]
                              : "",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.grey,
                            child: Image.asset(
                              "assets/images/logo.png",
                              scale: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        feed["equip_request"].first["hirers"]["fullname"] ??
                            "-",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        "QTY Hired: ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      Text(feed["equip_request"].first["quantity"].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Duration: ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      Text(
                          DateTime.parse(
                                      feed["equip_request"].first["rental_to"]!)
                                  .difference(DateTime.parse(
                                      feed["equip_request"]
                                          .first["rental_from"]))
                                  .inDays
                                  .toString() +
                              " day(s)",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              )
            ],
          ),
        ));
  }
}

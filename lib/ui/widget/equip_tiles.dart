import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/general_button.dart';
// import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../../app/app_setup.router.dart';

class EquipTiles extends StatelessWidget {
  final EquipmentModel model;
  EquipTiles({
    required this.model,
  });
  // final NavService _navigationService = locator<NavService>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          locator<NavigationService>().navigateTo(Routes.equipDetails,
              arguments: EquipDetailsArguments(model: model));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 90,
                  width: 97,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Hero(
                      tag: model.id.toString(),
                      child: CachedNetworkImage(
                        imageUrl: model.equipImages!.first.equipImagesPath!,
                        placeholder: (context, url) => Center(
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ))),
                        errorWidget: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            "assets/images/logo.png",
                            scale: 2,
                            width: 80,
                          ),
                        ),
                      )),
                ),
              ),
              Gap(11),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.equipName!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15)),
                    Gap(10),
                    Row(
                      children: [
                        Text(
                            "${getCurrency(model.owners!.country) + model.costOfHire!}",
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(
                            " per ${model.costOfHireInterval == "1" ? "Day" : model.costOfHireInterval == "7" ? "Week" : "Month"}",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/location.svg",
                                width: 10,
                              ),
                              Gap(5),
                              Expanded(
                                child: Text(model.address!,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Colors.grey, fontSize: 10)),
                              ),
                            ],
                          ),
                        ),
                        Gap(30),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                            ),
                            onPressed: () {
                              locator<NavigationService>().navigateTo(
                                  Routes.equipDetails,
                                  arguments:
                                      EquipDetailsArguments(model: model));
                            },
                            child: Text(
                              "Book",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                //fontSize: 15
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

String getCurrency(country) {
  switch (country) {
    case "Nigeria":
      return "NGN";
    case "London":
      return "GBP";
    default:
      return "NGN";
  }
}

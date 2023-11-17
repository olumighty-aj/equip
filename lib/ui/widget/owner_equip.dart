import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../screens/hirer/book/equip_details.dart';
import '../screens/owner/home_owner/equip_owner_details.dart';

class OwnerEquipTiles extends StatelessWidget {
  final EquipmentModel model;
  OwnerEquipTiles({
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EquipOwnerDetails(
                      model: model,
                    )),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.all(12),
          // height: 180,
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
            children: [
              Container(
                  height: 90,
                  width: 90,
                  child: Hero(
                      tag: model.id!,
                      child: CachedNetworkImage(
                        imageUrl: model.equipImages!.isNotEmpty
                            ? model.equipImages!.first.equipImagesPath!
                            : "",
                        placeholder: (context, url) => Center(
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ))),
                        errorWidget: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            "assets/images/logo.png",
                            scale: 2,
                          ),
                        ),
                      ))),
              SizedBox(
                width: 11,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.equipName!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("NGN${model.costOfHire!}",
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(
                            " per ${model.costOfHireInterval == "1" ? "Day" : model.costOfHireInterval == "7" ? "Week" : "Month"}",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${model.equipRequest?.length.toString() ?? " "} booking requests received",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 10, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

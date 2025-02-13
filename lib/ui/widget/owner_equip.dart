import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/ui/screens/hirer/book/details_view_model.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/model/equipments/equipments.dart';
import '../../utils/app_svgs.dart';
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
                      tag: model.ID!,
                      child: CachedNetworkImage(
                        imageUrl: model.equip_images!.isNotEmpty
                            ? model.equip_images!.first.equip_images_path!
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
                          child: SvgPicture.asset(
                            AppSvgs.svgLogo,
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
                      model.equip_name!,
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
                        Text(
                            "${getCurrency(model.owners!.country)}${model.cost_of_hire!.withCommas}",
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(
                            " per ${model.cost_of_hire_interval == "1" ? "Day" : model.cost_of_hire_interval == "7" ? "Week" : "Month"}",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${model.equip_request?.length.toString() ?? " "} booking requests received",
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

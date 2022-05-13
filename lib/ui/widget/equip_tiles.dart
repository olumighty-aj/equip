import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EquipTiles extends StatelessWidget {
  final EquipmentModel model;
  EquipTiles({
    required this.model,
  });
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {

          _navigationService.navigateTo(EquipDetailsRoute,arguments: model);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(10),
          height: 150,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                          tag: model.id.toString(),
                          child: CachedNetworkImage(
                            imageUrl: model.equipImages!.first.equipImagesPath!,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                "assets/images/logo.png",
                                scale: 2,
                              ),
                            ),
                          )))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.equipName!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        model.costOfHire!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      Text(
                        " per ${model.costOfHireInterval == "1" ? "Day" : model.costOfHireInterval == "7" ? "Week" : "Month"}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/location.svg",
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 150,
                        child:
                      Text(
                        model.owners!.address!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      )),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: 80,
                      child: SizedBox(
                          height: 34,
                          width: 70,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            ),
                            color: AppColors.primaryColor,
                            onPressed: () {
                              _navigationService.navigateTo(EquipDetailsRoute,arguments: model);
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
                          ))
                      // GeneralButton(onPressed: () {
                      //   _navigationService.navigateTo(EquipDetailsRoute);
                      // }, buttonText: "Book Now")

                      )
                ],
              )
            ],
          ),
        ));
  }
}

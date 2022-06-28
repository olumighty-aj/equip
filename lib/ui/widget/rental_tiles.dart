import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class RentalTiles extends StatelessWidget {
  final ActiveRentalsModel feed;
  RentalTiles({required this.feed});
  final NavigationService _navigationService = locator<NavigationService>();
  final Authentication authentication = locator<Authentication>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => EquipDetails()),
          // );
          authentication.currentUser.userType == "hirers"?
          _navigationService.navigateTo(RentalDetailsRoute,arguments: feed):
          _navigationService.navigateTo(OwnerRentalDetailsRoute,arguments: feed);


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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                          tag: "profile",
                          child: CachedNetworkImage(
                            imageUrl: feed.equipments!.equipImagesId!= null?feed.equipments!.equipImagesId!:"",
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
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    feed.equipments!.equipName!= null?   feed.equipments!.equipName!:"",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                        width: 10,
                      ),
                      Container(
                          width: 150,
                          child: Text(
                            feed.deliveryLocation!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 10),
                      height: 40,
                      width: 100,
                      child: GeneralButton(
                          buttonTextColor: AppColors.white,
                          splashColor: feed.requestStatus! == "pending"
                              ? Colors.blue
                              : feed.requestStatus! == "rejected"
                                  ? AppColors.red
                                  : feed.requestStatus! == "returned"
                                      ? AppColors.green
                                      : feed.requestStatus! == "received"
                                          ? AppColors.blue
                                          : AppColors.primaryColor,
                          onPressed: () {
                            // _navigationService.navigateTo(EquipDetailsRoute);
                          },
                          buttonText: toBeginningOfSentenceCase(feed.requestStatus!)!))
                ],
              ),
            ],
          ),
        ));
  }
}

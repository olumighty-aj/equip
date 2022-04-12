import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EquipTiles extends StatelessWidget {
  // final Function onPressed;
  EquipTiles(
      //{
      // required this.onPressed,
      // }
      );
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => EquipDetails()),
        // );
        _navigationService.navigateTo(EquipDetailsRoute);
      },
      child:Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(10),
      height: 120,
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
              height: 100,
              width: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child:Hero(tag: "profile", child: CachedNetworkImage(
                    imageUrl: "https://i.pravatar.cc/",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        "assets/images/user.png",
                        scale: 2,
                      ),
                    ),
                  )))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Driller & Harmer",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "N5000 ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Text(
                    "per week",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
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
                  Text(
                    "Surulere Lagos",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
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
                  width: 100,
                  child:
                      GeneralButton(onPressed: () {

                        _navigationService.navigateTo(EquipDetailsRoute);
                      }, buttonText: "Book Now"))
            ],
          )
        ],
      ),
      ) );
  }
}

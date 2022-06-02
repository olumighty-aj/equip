import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingRequest extends StatelessWidget {
 final EquipRequest feed;
  BookingRequest(
      {
      required this.feed,
      }
      );
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _navigationService.navigateTo(BookingDetailsRoute,arguments: feed);
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
                spreadRadius: 0.3,
                blurRadius: 1,
                offset: Offset(0, 0.3), // changes position of shadow
              ),
            ],
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
                        child:  CachedNetworkImage(
                          imageUrl: feed.hirers!.hirersPath!,
                          imageBuilder:
                              (context, imageProvider) =>
                              Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain),
                                ),
                              ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>        CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.grey,
                            child: Image.asset(
                              "assets/images/logo.png",
                              scale: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        feed.hirers!.fullname!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "QTY Hired: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      Text(
                        feed.quantity!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14,),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Duration:: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      Text(
                        DateTime.parse(feed.rentalFrom!).difference(DateTime.parse(feed.rentalTo!)).inDays.toString() + " day(s)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14,),
                      ),
                    ],
                  ),
                ],
              ),
   InkWell(
     onTap: (){

     },
     child: Icon(
       Icons.arrow_forward_ios
     ),
   )
            ],
          ),
        ));
  }
}

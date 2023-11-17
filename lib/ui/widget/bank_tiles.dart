import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankTile extends StatelessWidget {
  // final Function onPressed;
  BankTile(
      //{
      // required this.onPressed,
      // }
      );
  final NavService _navigationService = locator<NavService>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => EquipDetails()),
          // );
          _navigationService.navigateTo(BookingDetailsRoute);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Daniel Makinde",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Account No: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      Text(
                        "0123232322",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "GTBank",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
              PopupMenuButton<int>(
                offset: Offset(10, 10),
                child: SvgPicture.asset("assets/images/more.svg"),
                onSelected: (int selectedValue) async {
                  switch (selectedValue) {
                    case 0:
                      break;

                    default:
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 0,
                      child: Text(
                        "Delete",
                      )),
                ],
              )
            ],
          ),
        ));
  }
}

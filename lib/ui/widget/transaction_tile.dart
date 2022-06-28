import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/TransactionModel.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
   final TransactionHistory model;
  TransactionTile(
      {
      required this.model,
      }
      );
  final NavigationService _navigationService = locator<NavigationService>();
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
                    DateFormat(
                      "dd MMM, yyyy, hh:mm aa",
                    ).format(DateTime.parse(
              model.dateCreated.toString())),
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Receipt: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      Text(
                        model.hashCode.toString(),
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
                          model.status!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14,color: AppColors.primaryColor),
                      ),

                ],
              ),
              Text(
                  model.amount!,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ));
  }
}

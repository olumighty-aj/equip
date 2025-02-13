import 'package:equipro/core/model/NotificationModel.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../../core/enums/dialog_type.dart';

class NotiItem extends StatelessWidget {
  final NotificationModel feed;

  NotiItem({
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => locator<DialogService>().showCustomDialog(
            variant: DialogType.notification,
            data: feed.toJson(),
            barrierDismissible: true),
        child: Container(
            // padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            //  color: AppColors.white,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 10,
                    // width: Responsive.width(context)/1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color: AppColors.primaryColor,
                    ),
                    alignment: Alignment.center,
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  feed.message ?? "",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    overflow: TextOverflow.fade,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                  DateTime.parse(feed.dateCreated!)
                                      .formatToCustomFormat(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.grey)),
                            ])),
                  )
                ])));
  }
}

extension DateTimeFormatter on DateTime {
  String formatToCustomFormat() {
    // Month abbreviations
    List<String> monthAbbreviations = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    // Format the time
    String formattedTime =
        "${this.hour}:${this.minute.toString().padLeft(2, '0')}";

    // Format the date
    String formattedDate =
        "${this.day} ${monthAbbreviations[this.month]}, ${this.year}";

    // Determine AM/PM
    String amPm = this.hour < 12 ? 'AM' : 'PM';

    // Combine date, time, and AM/PM
    return "$formattedDate $formattedTime$amPm";
  }
}

extension DateTimeExtension on DateTime {
  String formatTimeIn12HourFormat() {
    return DateFormat.jm().format(this);
  }
}

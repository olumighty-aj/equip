import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/NotificationModel.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';

class NotiItem extends StatelessWidget {
  final NotificationModel feed;

  NotiItem({
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
            //  padding: EdgeInsets.all(10),
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
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feed.message!,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                feed.dateCreated!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ])),
                  )
                ])));
  }
}

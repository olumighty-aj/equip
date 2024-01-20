import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  final ChatListModel model;

  ChatItem({
    required this.model,
  });
  final NavService _navigationService = locator<NavService>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _navigationService.navigateTo(chatDetailsPageRoute, arguments: model);
        },
        child: Container(
            padding: EdgeInsets.all(10),
            //  color: AppColors.white,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.chatWith!.hirersPath != null
                        ? model.chatWith!.hirersPath!
                        : "",
                    imageBuilder: (context, imageProvider) => Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 17,
                      backgroundColor: AppColors.grey,
                      child: Image.asset(
                        "assets/images/icon.png",
                        scale: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                model.chatWith!.fullname!,
                                //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat(
                                  "dd MMM, hh:mm aa",
                                ).format(DateTime.parse(
                                    model.dateCreated.toString())),
                                //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          model.lastMessage!,
                          //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ])),
                ])));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final Function onPressed;

  ChatItem({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
            padding: EdgeInsets.all(10),
          //  color: AppColors.white,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: "https://i.pravatar.cc/",
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
                      radius: 40,
                      backgroundColor: AppColors.grey,
                      child: Image.asset(
                        "assets/images/user.png",
                        scale: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amandan Makdan",
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
                                "04:24pm",
                                //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                        SizedBox(height: 5,),
                        Text(
                          "There are three aspects of design that you should know about. Layout.",
                          //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),

                      ])),
                ])));
  }
}

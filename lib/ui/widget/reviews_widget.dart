import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewItem extends StatelessWidget {
  final ReviewsModel feed;

  ReviewItem(
  {
 required this.feed,
}

  );

  @override
  Widget build(BuildContext context) {
    return  Container(
            padding: EdgeInsets.all(10),
          //  color: AppColors.white,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: feed.hirers!.hirersPath!,
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
                        "assets/images/logo.png",
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
                             feed.hirers!.fullname!,
                                //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SmoothStarRating(
                                  defaultIconData:
                                  Icons.star_outline_rounded,
                                  allowHalfRating: true,
                                  onRated: (v) {},
                                  starCount: 5,
                                  rating: double.parse(feed.rating!),
                                  size: 20,
                                  isReadOnly: true,
                                  filledIconData: Icons.star_rounded,
                                  halfFilledIconData:
                                  Icons.star_half_rounded,
                                  color: AppColors.yellow,
                                  borderColor: Colors.grey,
                                  spacing: 0.5),
                            ]),
                        SizedBox(height: 5,),
                        Text(
                         feed.comment!,
                          //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ])),
                ]));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/utils/app_svgs.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewItem extends StatelessWidget {
  final ReviewsModel feed;

  ReviewItem({
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  radius: 20,
                  backgroundColor: AppColors.grey,
                  child: SvgPicture.asset(
                    AppSvgs.svgLogo,
                  ),
                ),
              ),
              Gap(10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(feed.hirers!.fullname!,
                              //  _authentication.currentUser.firstName! + " " + _authentication.currentUser.lastName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          Gap(5),
                          SmoothStarRating(
                              defaultIconData: Icons.star_outline_rounded,
                              allowHalfRating: true,
                              onRated: (v) {},
                              starCount: 5,
                              rating: double.parse(feed.rating!),
                              size: 14,
                              isReadOnly: true,
                              filledIconData: Icons.star_rounded,
                              halfFilledIconData: Icons.star_half_rounded,
                              color: Color(0xffF6DF08),
                              borderColor: Colors.grey,
                              spacing: 0.5),
                        ]),
                    SizedBox(
                      height: 5,
                    ),
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

import 'package:flutter/cupertino.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/screensize.dart';

class ScreenTile extends StatelessWidget {
  final String image, title, subtitle;
  final bool screenvalue;

  ScreenTile(
      {required this.image,
      required this.title,
      required this.subtitle,
      required this.screenvalue});

  @override
  Widget build(BuildContext context) {
   return
    Container(
      width: Responsive.width(context),
    height: Responsive.height(context) ,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage(image),
    fit: BoxFit.fill,
    colorFilter: ColorFilter.mode(
    AppColors.black.withOpacity(0.3),
    BlendMode.darken
    ),
    ),
    ));

  }
}

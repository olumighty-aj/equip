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
    return screenvalue
        ? Column(
            children: [
              Container(
                  color: AppColors.lowGrey,
                  height: Responsive.height(context) / 2,
                  child: Container(
                      margin: EdgeInsets.only(top: height(0.15, context)),
                      alignment: Alignment.center,
                      child: Image.asset(
                        image,
                        width: 350,
                        height: 250,
                      ))),
              SizedBox(
                height: 50,
              ),
              Container(
                child:Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    subtitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          )
        : Column(
            children: [
              Container(
                  color: AppColors.lowGrey,
                  height: Responsive.height(context) / 2,
                  child: Container(
                      margin: EdgeInsets.only(top: height(0.15, context)),
                      alignment: Alignment.center,
                      child: Image.asset(
                        image,
                        width: 300,
                        height: 200,
                      ))),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    subtitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          );
  }
}

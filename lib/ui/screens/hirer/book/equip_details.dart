import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/ui/screens/hirer/book/details_view_model.dart';
import 'package:equipro/ui/widget/dash_painter.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class EquipDetails extends StatefulWidget {
  final EquipmentModel model;
  const EquipDetails({Key? key, required this.model}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EquipDetails> with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();

  String? selected = "1";
  late bool active = false;

  AnimationController? _navController;
  Animation<Offset>? _navAnimation;

  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    _navAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.99),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _navController!,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _navController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsViewModel>.reactive(
        viewModelBuilder: () => DetailsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                // fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                      tag: widget.model.id.toString(),
                      child: CachedNetworkImage(
                        imageUrl:
                            widget.model.equipImages!.first.equipImagesPath!,
                        imageBuilder: (context, imageProvider) => Container(
                          width: Responsive.width(context),
                          height: Responsive.height(context) / 2.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                  AppColors.black.withOpacity(0.3),
                                  BlendMode.darken),
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                          width: Responsive.width(context),
                          height: Responsive.height(context) / 2.5,
                          child: Image.asset(
                            "assets/images/logo.png",
                            scale: 2,
                          ),
                        ),
                      )),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.only(left: 8),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.white,
                          ),
                          child: InkWell(
                              onTap: () {
                                _navigationService.pop();
                                //  Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.primaryColor,
                              )))
                    ],
                  ),
                  AnimationLimiter(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 1000),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                    horizontalOffset:
                                        MediaQuery.of(context).size.width / 4,
                                    child: FadeInAnimation(
                                        curve: Curves.fastOutSlowIn,
                                        child: widget),
                                  ),
                              children: [
                                SizedBox(
                                  height: Responsive.height(context) / 4,
                                ),
                                widget.model.equipImages != null
                                    ? Container(
                                        height: 100,
                                        child: Center(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: widget
                                                    .model.equipImages!.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            selected = widget
                                                                .model
                                                                .equipImages![
                                                                    index]
                                                                .id!
                                                                .toString();
                                                          });
                                                        },
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: widget
                                                                          .model
                                                                          .equipImages![
                                                                              index]
                                                                          .id!
                                                                          .toString() !=
                                                                      selected
                                                                  ? AppColors
                                                                      .primaryColor
                                                                  : AppColors
                                                                      .white,
                                                            ),
                                                            height: 70,
                                                            width: 70,
                                                            child: Container(
                                                                height: 60,
                                                                width: 60,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(3),
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10.0),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl: widget
                                                                              .model
                                                                              .equipImages![index]
                                                                              .equipImagesPath!,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          placeholder: (context, url) =>
                                                                              CircularProgressIndicator(),
                                                                          errorWidget: (context, url, error) =>
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/images/logo.png",
                                                                              scale: 2,
                                                                            ),
                                                                          ),
                                                                        ))))),
                                                  );
                                                })))
                                    : Container(
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),

                                // AnimationLimiter(
                                //     child: Row(
                                //         mainAxisAlignment: MainAxisAlignment.center,
                                //         children: AnimationConfiguration.toStaggeredList(
                                //           duration: const Duration(milliseconds: 1000),
                                //           childAnimationBuilder: (widget) => SlideAnimation(
                                //             horizontalOffset:
                                //                 MediaQuery.of(context).size.width / 4,
                                //             child: FadeInAnimation(
                                //                 curve: Curves.fastOutSlowIn, child: widget),
                                //           ),
                                //           children: [
                                //             InkWell(
                                //                 onTap: () {
                                //                   setState(() {
                                //                     selected = "1";
                                //                   });
                                //                 },
                                //                 child: Container(
                                //                     decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(10),
                                //                       color: selected != "1"
                                //                           ? AppColors.primaryColor
                                //                           : AppColors.white,
                                //                     ),
                                //                     height: 70,
                                //                     width: 70,
                                //                     child: Container(
                                //                         height: 60,
                                //                         width: 60,
                                //                         padding: EdgeInsets.all(3),
                                //                         child: ClipRRect(
                                //                             borderRadius:
                                //                                 BorderRadius.circular(10.0),
                                //                             child: CachedNetworkImage(
                                //                               imageUrl:
                                //                                   "https://i.pravatar.cc/",
                                //                               placeholder: (context, url) =>
                                //                                   CircularProgressIndicator(),
                                //                               errorWidget:
                                //                                   (context, url, error) =>
                                //                                       ClipRRect(
                                //                                 borderRadius:
                                //                                     BorderRadius.circular(
                                //                                         8.0),
                                //                                 child: Image.asset(
                                //                                   "assets/images/logo.png",
                                //                                   scale: 2,
                                //                                 ),
                                //                               ),
                                //                             ))))),
                                //             SizedBox(
                                //               width: 10,
                                //             ),
                                //             InkWell(
                                //                 onTap: () {
                                //                   setState(() {
                                //                     selected = "2";
                                //                   });
                                //                 },
                                //                 child: Container(
                                //                     decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(10),
                                //                       color: selected != "2"
                                //                           ? AppColors.primaryColor
                                //                           : AppColors.white,
                                //                     ),
                                //                     height: 70,
                                //                     width: 70,
                                //                     child: Container(
                                //                         height: 60,
                                //                         width: 60,
                                //                         padding: EdgeInsets.all(3),
                                //                         child: ClipRRect(
                                //                             borderRadius:
                                //                                 BorderRadius.circular(10.0),
                                //                             child: CachedNetworkImage(
                                //                               imageUrl:
                                //                                   "https://i.pravatar.cc/",
                                //                               placeholder: (context, url) =>
                                //                                   CircularProgressIndicator(),
                                //                               errorWidget:
                                //                                   (context, url, error) =>
                                //                                       ClipRRect(
                                //                                 borderRadius:
                                //                                     BorderRadius.circular(
                                //                                         8.0),
                                //                                 child: Image.asset(
                                //                                   "assets/images/user.png",
                                //                                   scale: 2,
                                //                                 ),
                                //                               ),
                                //                             ))))),
                                //             SizedBox(
                                //               width: 10,
                                //             ),
                                //             InkWell(
                                //                 onTap: () {
                                //                   setState(() {
                                //                     selected = "3";
                                //                   });
                                //                 },
                                //                 child: Container(
                                //                     decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(10),
                                //                       color: selected != "3"
                                //                           ? AppColors.primaryColor
                                //                           : AppColors.white,
                                //                     ),
                                //                     height: 70,
                                //                     width: 70,
                                //                     child: Container(
                                //                         height: 70,
                                //                         width: 70,
                                //                         padding: EdgeInsets.all(3),
                                //                         child: ClipRRect(
                                //                             borderRadius:
                                //                                 BorderRadius.circular(10.0),
                                //                             child: CachedNetworkImage(
                                //                               imageUrl:
                                //                                   "https://i.pravatar.cc/",
                                //                               placeholder: (context, url) =>
                                //                                   CircularProgressIndicator(),
                                //                               errorWidget:
                                //                                   (context, url, error) =>
                                //                                       ClipRRect(
                                //                                 borderRadius:
                                //                                     BorderRadius.circular(
                                //                                         8.0),
                                //                                 child: Image.asset(
                                //                                   "assets/images/user.png",
                                //                                   scale: 2,
                                //                                 ),
                                //                               ),
                                //                             )))))
                                //           ],
                                //         )))
                              ]))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: Responsive.height(context) / 2.5,
                      ),
                      Container(
                          width: Responsive.width(context),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                          ),
                          //height: Responsive.height(context) / 1.5,
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                widget.model.equipName!,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${widget.model.costOfHire} per ${widget.model.costOfHireInterval == "1" ? "Day" : widget.model.costOfHireInterval == "7" ? "Week" : "Month"}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'QTY Available: ${widget.model.quantity!}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Description:',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'View rental agreement',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                widget.model.description!,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Availability: ${DateFormat(
                                  "dd MMM, yyyy",
                                ).format(DateTime.parse(widget.model.availFrom!)).toString()} - ${DateFormat(
                                  "dd MMM, yyyy",
                                ).format(DateTime.parse(widget.model.availTo!)).toString()}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomPaint(painter: LineDashedPainter()),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Owner',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SmoothStarRating(
                                      defaultIconData:
                                          Icons.star_outline_rounded,
                                      allowHalfRating: true,
                                      onRated: (v) {},
                                      starCount: 5,
                                      rating: double.parse(widget
                                          .model.averageRating!
                                          .toString()),
                                      size: 20,
                                      isReadOnly: true,
                                      filledIconData: Icons.star_rounded,
                                      halfFilledIconData:
                                          Icons.star_half_rounded,
                                      color: AppColors.yellow,
                                      borderColor: Colors.grey,
                                      spacing: 0.5),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Name: ${widget.model.owners!.fullname}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Location: ${widget.model.owners!.address}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SlideTransition(
                                  position: _navAnimation!,
                                  //   textDirection: TextDirection.r,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:
                                              Responsive.width(context) / 2.3,
                                          child: GeneralButton(
                                              onPressed: () {
                                                _navigationService.navigateTo(
                                                    chatDetailsPageRoute);
                                              },
                                              buttonText: "Chat Owner",
                                              buttonTextColor: AppColors.black,
                                              splashColor: Color.fromRGBO(
                                                  255, 235, 173, 0.85))),
                                      Container(
                                          width:
                                              Responsive.width(context) / 2.3,
                                          child: GeneralButton(
                                            onPressed: () {
                                              _navigationService.navigateTo(
                                                  PlaceBookingRoute,
                                                  arguments: widget.model);
                                            },
                                            buttonText: "Book Now",
                                            splashColor: AppColors.primaryColor,
                                          )),
                                    ],
                                  ))
                            ],
                          ))),
                    ],
                  ),
                ],
              ),
            ],
          )));
        });
  }
}

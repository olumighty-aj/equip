import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/chat_list/chat_list.dart';
import 'package:equipro/core/services/auth_service.dart';
// import 'package:equipro/core/services/stripe_payment_service.dart';
import 'package:equipro/ui/screens/chat/chats_widget/chat_details.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/active_rentals.dart';
import 'package:equipro/ui/screens/hirer/book/details_view_model.dart';
import 'package:equipro/ui/screens/hirer/book/place_booking.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/dash_painter.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/utils/app_svgs.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app_setup.locator.dart';
import '../../../../app/app_setup.logger.dart';
import '../../../../core/model/chat_with/chat_with.dart';
import '../../../../core/model/equipments/equipments.dart';
import '../../../../utils/text_styles.dart';

class EquipDetails extends StatefulWidget {
  final EquipmentModel model;
  const EquipDetails({Key? key, required this.model}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EquipDetails> with TickerProviderStateMixin {
  // final _navigationService = locator<NavigationService>();

  String? selected;
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
    getLogger("EquipDetails").i("Equippppp Details: ${widget.model.toJson()}");
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
                        imageUrl: selected ??
                            widget.model.equip_images!.first.equip_images_path!,
                        imageBuilder: (context, imageProvider) => Container(
                          width: Responsive.width(context),
                          height: Responsive.height(context) / 2.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  AppColors.black.withOpacity(0.3),
                                  BlendMode.darken),
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: Responsive.width(context),
                          height: Responsive.height(context) / 2.5,
                          child: SvgPicture.asset(
                            AppSvgs.svgLogo,
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
                                // _navigationService.back();
                                Navigator.pop(context);
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
                                widget.model.equip_images != null
                                    ? Align(
                                        alignment: Alignment.center,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                                widget
                                                    .model.equip_images!.length,
                                                (index) => Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selected = widget
                                                                  .model
                                                                  .equip_images![
                                                                      index]
                                                                  .equip_images_path
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
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    width: 0.5),
                                                                color: widget
                                                                            .model
                                                                            .equip_images![
                                                                                index]
                                                                            .equip_images_path!
                                                                            .toString() !=
                                                                        selected
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .primaryColor,
                                                              ),
                                                              height: 70,
                                                              width: 70,
                                                              child: Container(
                                                                  height: 60,
                                                                  width: 60,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: widget
                                                                        .model
                                                                        .equip_images![
                                                                            index]
                                                                        .equip_images_path!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder: (context,
                                                                            url) =>
                                                                        SizedBox(
                                                                            height:
                                                                                10,
                                                                            width:
                                                                                10,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              color: AppColors.primaryColor,
                                                                            )),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/logo.png",
                                                                        scale:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  )))),
                                                    )),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
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
                                widget.model.equip_name!,
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
                                    "${widget.model.currency}${widget.model.cost_of_hire!.withCommas} per ${widget.model.cost_of_hire_interval == "1" ? "Day" : widget.model.cost_of_hire_interval == "7" ? "Week" : "Month"}",
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
                                  Text('Description:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700)),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Rentals())),
                                    child: Text(
                                      'Check active rentals',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.primaryColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(20),
                              Text(
                                widget.model.description!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Gap(20),
                              Text(
                                  "Availability: ${DateFormat(
                                    "dd MMM, yyyy",
                                  ).format(DateTime.parse(widget.model.avail_from!)).toString()} - ${DateFormat(
                                    "dd MMM, yyyy",
                                  ).format(DateTime.parse(widget.model.avail_to!)).toString()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600)),
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
                                      rating:
                                          widget.model.average_rating == "0.00"
                                              ? 5.0
                                              : double.parse(widget
                                                  .model.average_rating!
                                                  .toString()),
                                      size: 20,
                                      isReadOnly: true,
                                      filledIconData: Icons.star_rounded,
                                      halfFilledIconData:
                                          Icons.star_half_rounded,
                                      color: Color(0xffF6DF08),
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
                                'Location: ${widget.model.owners!.local_state}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              if (model.authentication.currentUser.id !=
                                  widget.model.owners!.id)
                                SlideTransition(
                                    position: _navAnimation!,
                                    //   textDirection: TextDirection.r,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: BaseButton(
                                            label: "Chat Owner",
                                            bgColor: AppColors.primaryColor
                                                .withOpacity(0.3),
                                            labelStyle: buttonText.copyWith(
                                                color: AppColors.primaryColor),
                                            onPressed: () => Navigator.push(
                                                context, MaterialPageRoute(
                                                    builder: (context) {
                                              getLogger("Chtas").i(
                                                  "Chat details: ${widget.model.toJson()}");
                                              return ChatDetailsPage(
                                                  feed: ChatListModel(
                                                      id: widget.model.user_id,
                                                      user_id: locator<
                                                              Authentication>()
                                                          .currentUser
                                                          .id,
                                                      chat_with_id: widget
                                                          .model.owners!.id,
                                                      message_count: "",
                                                      last_message: "",
                                                      date_created: "",
                                                      date_modified: "",
                                                      chat_with: ChatWith(
                                                        id: widget
                                                            .model.owners!.id,
                                                        fullname: widget.model
                                                            .owners!.fullname!,
                                                        email: "",
                                                        phone_number: "",
                                                        gender: "",
                                                        address: "",
                                                        address_opt: "",
                                                        local_state: "",
                                                        country: "",
                                                        latitude: "",
                                                        longitude: "",
                                                        hirers_path: widget
                                                                    .model
                                                                    .owners!
                                                                    .hirers_path !=
                                                                null
                                                            ? widget
                                                                .model
                                                                .owners!
                                                                .hirers_path!
                                                            : "",
                                                        status: "",
                                                        date_modified: "",
                                                        date_created: "",
                                                      )));
                                            })),
                                          ),
                                        ),
                                        Gap(10),
                                        Expanded(
                                          child: BaseButton(
                                            label: "Book Now",
                                            onPressed: () {
                                              // StripePaymentService()
                                              //     .stripeMakePayment();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PlaceBooking(
                                                              model: widget
                                                                  .model)));
                                            },
                                          ),
                                        )
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

//user_id: 5, owners_id: 1, owners.id: 1

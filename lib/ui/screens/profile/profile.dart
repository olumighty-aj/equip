import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:equipro/core/model/ReviewsModel.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/screens/profile/kyc_verif/become_owner.dart';
import 'package:equipro/ui/screens/profile/kyc_verif/verify_kyc.dart';
import 'package:equipro/ui/screens/profile/profile_view_model.dart';
import 'package:equipro/ui/widget/reviews_widget.dart';
import 'package:equipro/utils/app_svgs.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Authentication _authentication = locator<Authentication>();
  TextEditingController emailController = TextEditingController();
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
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (model) => model.initProfile(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Color(0xFFF5F5F5),
            key: _scaffoldKey,
            appBar: AppBar(
              leading: CustomBackButton(),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: AnimationLimiter(child: Builder(builder: (context) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 200),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                    horizontalOffset:
                                        -MediaQuery.of(context).size.width / 4,
                                    child: FadeInAnimation(
                                        curve: Curves.fastOutSlowIn,
                                        child: widget),
                                  ),
                              children: [
                                Row(children: [
                                  Text(
                                    "Profile",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ]),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                    child: DottedBorder(
                                  color: Colors.grey,
                                  padding: EdgeInsets.all(10),
                                  dashPattern: [2, 3, 4],
                                  borderType: BorderType.Circle,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      model.image != null
                                          ? CircleAvatar(
                                              radius: 70,
                                              backgroundImage:
                                                  FileImage(model.image!))
                                          : CachedNetworkImage(
                                              imageUrl: model.hirersPath != null
                                                  ? model.hirersPath!
                                                  : baseUrl,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 140.0,
                                                height: 140.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                radius: 70,
                                                backgroundColor: AppColors.grey,
                                                child: SvgPicture.asset(
                                                  AppSvgs.svgLogo,
                                                ),
                                              ),
                                            ),
                                      Positioned(
                                        bottom: 10,
                                        right: -20,
                                        child: PopupMenuButton(
                                          offset: Offset(100, 30),
                                          onSelected:
                                              (int selectedValue) async {
                                            switch (selectedValue) {
                                              case 0:
                                                model.handleChooseFromCamera();
                                                break;
                                              case 1:
                                                model.handleChooseFromGallery();
                                                break;
                                              default:
                                            }
                                          },
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 0,
                                              child: Text(
                                                "Camera",
                                              ),
                                            ),
                                            PopupMenuItem(
                                                value: 1,
                                                child: Text(
                                                  "Gallery",
                                                )),
                                          ],
                                          child: CircleAvatar(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  _authentication.currentUser.fullname!,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  _authentication.currentUser.email!,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfile())),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/images/edit.svg"),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Edit profile",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ])),
                                Gap(30),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Phone Number"),
                                          Expanded(
                                            child: Text(
                                              _authentication.currentUser
                                                          .phoneNumber !=
                                                      null
                                                  ? _authentication
                                                      .currentUser.phoneNumber!
                                                  : "Not updated",
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ],
                                      ),
                                      if (model.isNigerian)
                                        Column(
                                          children: [
                                            Gap(30),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Address"),
                                                Gap(10),
                                                Expanded(
                                                  child: Text(
                                                    _authentication.currentUser
                                                                .address !=
                                                            null
                                                        ? _authentication
                                                            .currentUser
                                                            .address!
                                                        : "Not updated ",
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                Gap(15),
                                GestureDetector(
                                  onTap: !model.kycApproved
                                      ? () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  KYCVerificationScreen()))
                                      : null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Expanded(child: Text("Means of ID")),
                                        Expanded(
                                            child: Text("KYC Verification")),
                                        RoundCheckBox(
                                          onTap: null,
                                          disabledColor: model.kycApproved
                                              ? Colors.green
                                              : Colors.red,
                                          uncheckedWidget: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          checkedWidget: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          uncheckedColor: Colors.red,
                                          checkedColor: Colors.green,
                                          isChecked: model.kycApproved,
                                          size: 25,
                                        ),
                                        Gap(20),
                                        if (model.verificationDetails != null &&
                                            model.verificationDetails!.isEmpty)
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red),
                                            child: Text(
                                              "Not Verified",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(10),
                                GestureDetector(
                                  onTap: !model.isOwner
                                      ? () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BecomeOwnerScreen()))
                                      : null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text("Verified Owner")),
                                        RoundCheckBox(
                                          onTap: null,
                                          disabledColor: model.isOwner
                                              ? Colors.green
                                              : Colors.red,
                                          checkedColor: Colors.green,
                                          isChecked: model.isOwner,
                                          size: 25,
                                          uncheckedColor: Colors.red,
                                          checkedWidget: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          uncheckedWidget: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        Gap(20),
                                        if (model.verificationDetails != null &&
                                            model.verificationDetails!.isEmpty)
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red),
                                            child: Text(
                                              "Not Verified",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(35),
                                _authentication.currentUser.userType == "hirers"
                                    ? Container(
                                        height: Responsive.height(context) / 3,
                                        child: FutureBuilder<
                                                List<ReviewsModel>>(
                                            future: model.getReviews(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container(
                                                    height: 400,
                                                    padding: EdgeInsets.only(
                                                        left: 20.0, right: 20),
                                                    child: Center(
                                                      child: Shimmer.fromColors(
                                                          direction:
                                                              ShimmerDirection
                                                                  .ltr,
                                                          period: Duration(
                                                              seconds: 2),
                                                          child: ListView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            // shrinkWrap: true,
                                                            children:
                                                                [0, 1, 2, 3]
                                                                    .map((_) =>
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                              ),
                                                                              Expanded(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: double.infinity,
                                                                                      height: 8.0,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                                                    ),
                                                                                    Container(
                                                                                      width: double.infinity,
                                                                                      height: 8.0,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 40.0,
                                                                                      height: 8.0,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ))
                                                                    .toList(),
                                                          ),
                                                          baseColor:
                                                              AppColors.grey,
                                                          highlightColor:
                                                              Colors.white),
                                                    ));
                                              } else if (snapshot
                                                  .data!.isNotEmpty) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Reviews(${snapshot.data!.length})",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                    Gap(18),
                                                    Column(
                                                        children: snapshot.data!
                                                            .map((feed) =>
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                5),
                                                                    child:
                                                                        ReviewItem(
                                                                      feed:
                                                                          feed,
                                                                    )))
                                                            .toList()),
                                                  ],
                                                );
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                    child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 100,
                                                    ),
                                                    Text(
                                                      'Network error',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('Network error'),
                                                    SizedBox(
                                                      height: 100,
                                                    ),
                                                  ],
                                                ));
                                              } else {
                                                return Center(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "No reviews yet.",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              AppColors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                  ],
                                                ));
                                              }
                                            }),
                                      )
                                    : Container(),
                              ]));
                    })))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

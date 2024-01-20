import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:equipro/core/services/index.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/profile/profile_view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/app_svgs.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EditProfile> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  var quantityList = new List<int>.generate(4, (i) => i + 1);

  File? banner;
  final DateTime timestamp = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        onViewModelReady: (v) => v.init(),
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: CustomBackButton(),
            ),
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: AnimationLimiter(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 200),
                                childAnimationBuilder: (widget) =>
                                    SlideAnimation(
                                      horizontalOffset:
                                          -MediaQuery.of(context).size.width /
                                              4,
                                      child: FadeInAnimation(
                                          curve: Curves.fastOutSlowIn,
                                          child: widget),
                                    ),
                                children: [
                                  // const SizedBox(
                                  //   height: 40,
                                  // ),
                                  // Row(
                                  //   children: [CustomBackButton()],
                                  // ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Row(
                                    children: [
                                      Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
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
                                                imageUrl:
                                                    model.hirersPath != null
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
                                                  backgroundColor:
                                                      AppColors.grey,
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
                                                  model
                                                      .handleChooseFromCamera();
                                                  break;
                                                case 1:
                                                  model
                                                      .handleChooseFromGallery();
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
                                    "Full Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    enabled: false,
                                    controller: model.nameController,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    enabled: false,
                                    controller: model.emailController,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Phone Number",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    enabled: false,
                                    controller: model.phoneController,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "State",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    enabled: true,
                                    controller: model.stateController,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Country",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    enabled: true,
                                    controller: model.countryController,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: Responsive.width(context),
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration.collapsed(
                                            hintText: 'Select Gender'),
                                        isExpanded: true,
                                        value: model.selectedGender,
                                        onChanged: (val) =>
                                            model.onChangedGender(val),
                                        items: <String>[
                                          'Male',
                                          'Female',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                      onTap: () => model.showPlacePicker(),
                                      child: TextFormField(
                                        enabled: false,
                                        controller: model.addressController,
                                        decoration: InputDecoration(
                                          hintText: '',
                                          hintStyle: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          disabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(),
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        cursorColor: Colors.black,
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  model.kycApproved ||
                                          model.kycPendng && model.kycUpdated
                                      // || model.kycPendng
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Means Of Identification",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              width: Responsive.width(context),
                                              height: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Center(
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                          hintText:
                                                              'Select One'),
                                                  isExpanded: true,
                                                  value: model.selectedMOI,
                                                  onChanged: (val) =>
                                                      model.onChangedMOI(val),
                                                  items: <String>[
                                                    'International Passport',
                                                    'Voters Card',
                                                    'National ID',
                                                    'Driver License',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Upload the image",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                                onTap: () => model
                                                    .handleChooseFromGalleryId(),
                                                child: TextFormField(
                                                  enabled: false,
                                                  controller:
                                                      model.uploadController,
                                                  decoration: InputDecoration(
                                                    hintText: 'Upload ID',
                                                    hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4)),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    disabledBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4)),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4)),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide:
                                                          const BorderSide(),
                                                    ),
                                                  ),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  cursorColor: Colors.black,
                                                )),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: SlideTransition(
                                          position: _navAnimation!,
                                          //  textDirection: TextDirection.rtl,
                                          child: BaseButton(
                                              isBusy: model.busy("Edit"),
                                              onPressed: () =>
                                                  model.newEditProfile(context),
                                              label: "Save")))
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

class CustomBackButton extends StatelessWidget {
  final Function()? onTap;
  const CustomBackButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}

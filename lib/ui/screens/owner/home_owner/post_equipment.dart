import 'dart:io';

import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/screens/owner/home_owner/post_equipment_final.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:stacked/stacked.dart';

import '../../../widget/base_button.dart';

class PostEquipment extends StatefulWidget {
  const PostEquipment({Key? key}) : super(key: key);

  @override
  PostEquipmentState createState() => PostEquipmentState();
}

class PostEquipmentState extends State<PostEquipment>
    with TickerProviderStateMixin {
  final NavService _navigationService = locator<NavService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  File? image;
  File? video;
  final imagePicker = ImagePicker();
  String? imageType;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  AnimationController? _navController;
  Animation<Offset>? _navAnimation;
  List<XFile> listImages = [];
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

  handleChooseCatalogueGallery() async {
    try {
      final pickedFileList = await imagePicker.pickMultiImage(

          // maxWidth: maxWidth,
          // maxHeight: maxHeight,
          // imageQuality: quality,
          );
      setState(() {
        for (var i in pickedFileList) {
          listImages.add(i);
        }
      });
    } catch (e) {
      print(e);
      // setState(() {
      //   _pickImageError = e;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeOwnerViewModel>.reactive(
        viewModelBuilder: () => HomeOwnerViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
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
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          //  margin: EdgeInsets.all(20),
                                          padding: EdgeInsets.only(left: 8),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: AppColors.white,
                                          ),
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Icon(
                                                Icons.arrow_back_ios,
                                                color: AppColors.primaryColor,
                                              )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Post New Equipment",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Upload Image",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  BarProgress(
                                    percentage: 50,
                                    backColor: AppColors.white,
                                    color: AppColors.primaryColor,
                                    showPercentage: false,
                                    stroke: 9,
                                    round: true,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Name of equipment",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: nameController,
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
                                    height: 30,
                                  ),
                                  Text(
                                    "Upload equipment images",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  listImages.isNotEmpty
                                      ? Column(
                                          children: List.generate(
                                              listImages.length,
                                              (index) => Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Container(
                                                    //padding: EdgeInsets.all(20),
                                                    height: 120,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    width: 3)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            height: 95,
                                                            width: 95,
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                child:
                                                                    Image.file(
                                                                  File(listImages[
                                                                          index]
                                                                      .path),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ))),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                listImages
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                            },
                                                            child: Text(
                                                                "Remove",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                        color: AppColors
                                                                            .red,
                                                                        decoration:
                                                                            TextDecoration.underline))),
                                                      ],
                                                    ),
                                                  ))),
                                        )
                                      : Container(),
                                  InkWell(
                                      onTap: () {
                                        handleChooseCatalogueGallery();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: Responsive.width(context),
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppColors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/images/upload.svg"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Upload images here")
                                            ],
                                          ))),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Description (Optional)",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    maxLines: 4,
                                    controller: descriptionController,
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
                                    height: 30,
                                  ),
                                  Center(
                                      child: SlideTransition(
                                          position: _navAnimation!,
                                          //  textDirection: TextDirection.rtl,
                                          child: BaseButton(
                                              onPressed: () {
                                                if (nameController
                                                        .text.isNotEmpty &&
                                                    listImages.isNotEmpty) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PostEquipmentFinal(
                                                                equipName:
                                                                    nameController
                                                                        .text,
                                                                images:
                                                                    listImages,
                                                                description:
                                                                    descriptionController
                                                                        .text,
                                                              )));
                                                  // _navigationService.navigateTo(
                                                  //     PostEquipmentFinalRoute,
                                                  //     arguments: {
                                                  //       "equipName":
                                                  //           nameController.text,
                                                  //       "images": listImages,
                                                  //       "description":
                                                  //           descriptionController
                                                  //               .text,
                                                  //     });
                                                } else {
                                                  showErrorToast(
                                                      "Name and images are compulsory");
                                                }
                                              },
                                              label: "Save & Proceed"))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

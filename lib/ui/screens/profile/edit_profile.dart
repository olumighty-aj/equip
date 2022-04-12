import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/profile/profile_view_model.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EditProfile> with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectedQuantity;
  String? pickupTime = DateTime.now().toString();
  String? selectedDate;
  String? selectedWeek;
  TextEditingController nameController = TextEditingController();
  TextEditingController uploadController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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

  var quantityList = new List<int>.generate(4, (i) => i + 1);

  File? image;
  File? banner;
  final DateTime timestamp = DateTime.now();
  final imagePicker = ImagePicker();
  handleChooseFromCamera() async {
    File file = File(await imagePicker
        .pickImage(
      source: ImageSource.camera,
    )
        .then((pickedFile) => pickedFile!.path));
    // Navigator.pop(context);
    setState(() {
      //  fileName = file.path.split('/').last;
      this.image = file;
      // _startUploading();
    });
  }

  handleChooseFromGallery() async {
    File file = File(await imagePicker
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((pickedFile) => pickedFile!.path));
    // Navigator.pop(context);
    setState(() {
      //  fileName = file.path.split('/').last;
      this.image = file;
      // _startUploading();
    });
  }
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
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
                                            borderRadius: BorderRadius.circular(12),
                                            color: AppColors.white,
                                          ),
                                          child: InkWell(
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
                                    height: 20,
                                  ),
                                  Row(children: [
                                    Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ],),

                                  SizedBox(
                                    height: 20,
                                  ),
Center(child:
                                  Stack(
                                    children: [
                                      Container(
                                        width: 150.0,
                                        height: 150.0,
                                        child: Image.asset(
                                            "assets/images/dot_circle.png"),
                                      ),
                                       PopupMenuButton<int>(
                                                offset: Offset(100, 100),
                                                iconSize: 120,
                                                icon: image != null
                                                    ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15, top: 13),
                                                  child: CircleAvatar(
                                                    radius: 70, backgroundImage: FileImage(image!)))
                                                    :  Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15, top: 13),
                                                  child:CachedNetworkImage(
                                                  imageUrl:"https://i.pravatar.cc/",
                                                  imageBuilder: (context, imageProvider) =>
                                                      Container(
                                                        width: 140.0,
                                                        height: 140.0,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.contain),
                                                        ),
                                                      ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) =>
                                                      CircleAvatar(
                                                        radius: 60,
                                                        backgroundColor: AppColors.grey,
                                                        child: Image.asset(
                                                          "assets/images/user.png",
                                                          scale: 2,
                                                        ),
                                                      ),
                                                  )),
                                                onSelected: (int selectedValue) async {
                                                  switch (selectedValue) {
                                                    case 0:
                                                      handleChooseFromCamera();
                                                      break;
                                                    case 1:
                                                      handleChooseFromGallery();
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
                                              ),
                                    ],
                                  ) ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Full Name",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                  SizedBox(
                                    height: 10,
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
                                    height: 20,
                                  ),
                                  Text("Email",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: emailController,
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
                                  Text("Address",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: addressController,
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

                                  Text("Means Of Identification",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
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
                                            hintText: 'National Identification Card'),
                                        isExpanded: true,
                                        value: selectedWeek,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedWeek = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Driver\'s Licence',
                                          'NIMC card',
                                          'Passport',
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
InkWell(
  onTap: (){

  },
  child:
                                  TextFormField(
                                    enabled: false,
                                    controller: uploadController,
                                    decoration: InputDecoration(
                                      hintText: 'Upload ID',
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
                                  )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child:  SlideTransition(
                                          position: _navAnimation!,
                                        //  textDirection: TextDirection.rtl,
                                          child:Container(
                                          width: 300,
                                          child: GeneralButton(
                                              onPressed: () {

                                              },
                                              buttonText: "Save"))))
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

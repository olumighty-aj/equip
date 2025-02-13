import 'dart:io';
import 'dart:math';

import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:place_picker/place_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/model/equip_booking_model.dart';
import '../../../../core/model/equip_images/equip_images.dart';
import '../../../../core/model/equipments/equipments.dart';

class EditEquipment extends StatefulWidget {
  final EquipmentModel model;
  const EditEquipment({Key? key, required this.model}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EditEquipment> with TickerProviderStateMixin {
  final NavService _navigationService = locator<NavService>();
  TextEditingController costController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  File? image;
  File? video;
  final imagePicker = ImagePicker();
  String? imageType;
  String? selectedQuantity;
  String? pickupTime = DateTime.now().toString();
  String? selectedDate;
  String? selectedDateTo;
  String? selectedPer;
  String? selectedPerNumber;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  AnimationController? _navController;
  Animation<Offset>? _navAnimation;
  List<XFile> listImages = [];
  TextEditingController deliveryController = TextEditingController();
  String? pickLat;
  String? pickLng;

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyAsoaOKfTVMSJll6LvVcQ3sYgALbwJ0B9A")));
    // Handle the result in your way
    print(result);

    setState(() {
      print(result);
      deliveryController.text = result.formattedAddress!;
      pickLat = result.latLng!.latitude.toString();
      pickLng = result.latLng!.longitude.toString();
    });
  }

  convertCatalogue() async {
    for (EquipImages multipleFile in widget.model.equip_images!) {
      // count++;
      print(multipleFile);

      var rng = new Random();
// get temporary directory of device.
      Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
      String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
      File file =
          new File('$tempPath' + (rng.nextInt(1000)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
      http.Response response =
          await http.get(Uri.parse(multipleFile.equip_images_path!));
// write bodyBytes received in response to file.
      await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
      setState(() {
        listImages.add(XFile(file.path));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    convertCatalogue();
    nameController.text = widget.model.equip_name!;
    costController.text = widget.model.cost_of_hire!;
    descriptionController.text = widget.model.description!;
    selectedQuantity = widget.model.quantity!;
    selectedDate = DateFormat(
      "y-MM-dd",
    ).format(DateTime.parse(widget.model.avail_from!)).toString();
    selectedDateTo = DateFormat(
      "y-MM-dd",
    ).format(DateTime.parse(widget.model.avail_to!)).toString();
    selectedPer = widget.model.cost_of_hire_interval == "1"
        ? "Day 1"
        : widget.model.cost_of_hire_interval == "7"
            ? "Week 7"
            : "Month 30";
    selectedPerNumber = widget.model.cost_of_hire_interval!;
    deliveryController.text = widget.model.address!;
    pickLng = widget.model.longitude;
    pickLat = widget.model.latitude;
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
        // listImages.add(pickedFileList) ;
      });
    } catch (e) {
      print(e);
      // setState(() {
      //   _pickImageError = e;
      // });
    }
  }

  void _startUploading(HomeOwnerViewModel model) async {
    var response = await model.updateEquip(
        listImages,
        nameController.text,
        costController.text,
        selectedPerNumber!,
        selectedDate!,
        selectedDateTo!,
        selectedQuantity!,
        descriptionController.text,
        widget.model.ID!,
        pickLat.toString(),
        pickLng.toString(),
        deliveryController.text,
        context);
    print(response);
    if (response == null) {
      print('error');
    } else {}
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
                                    height: 30,
                                  ),
                                  Text(
                                    "Edit Equipment",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Equipment details",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.black,
                                    ),
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
                                    height: 30,
                                  ),
                                  Text(
                                    "Upload new equipment images",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  listImages.isNotEmpty
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: listImages.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      height: 95,
                                                      width: 95,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              width: 3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: Image.file(
                                                            File(listImages[
                                                                    index]
                                                                .path),
                                                            fit: BoxFit.fill,
                                                          ))),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          listImages
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      child: Text(
                                                        "Remove",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color:
                                                                    Colors.red,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                      )),
                                                ],
                                              ),
                                            );
                                          })
                                      : Container(),
                                  GestureDetector(
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
                                  Text(
                                    "Cost of hire",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: costController,
                                    decoration: InputDecoration(
                                      hintText: 'Cost',
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
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 30,
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
                                            hintText: 'Per?'),
                                        isExpanded: true,
                                        value: selectedPer,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedPer = newValue;
                                            newValue == "Day 1"
                                                ? selectedPerNumber = "1"
                                                : newValue == "Week 7"
                                                    ? selectedPerNumber =
                                                        "Month 30"
                                                    : selectedPerNumber = "30";
                                          });
                                        },
                                        items: <String>[
                                          'Day 1',
                                          'Week 7',
                                          'Month 30',
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
                                    height: 20,
                                  ),
                                  Text(
                                    "Availability",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        // YearPicker(firstDate: firstDate, lastDate: lastDate, selectedDate: selectedDate, onChanged: onChanged)
                                        DatePickerBdaya.showDatePicker(context,
                                            minTime: DateTime.now(),
                                            showTitleActions: true,
                                            onChanged: (date) {
                                          setState(() {
                                            selectedDate = DateFormat('y-MM-dd')
                                                .format(date)
                                                .toString();
                                          });
                                          print('change $date in time zone ' +
                                              date.timeZoneOffset.inHours
                                                  .toString());
                                        }, onConfirm: (date) {
                                          setState(() {});
                                        }, currentTime: DateTime.now());
                                      },
                                      child: Container(
                                          height: 60,
                                          width: Responsive.width(context),
                                          decoration: BoxDecoration(
                                              //   color: AppColors.primaryColor.withOpacity(0.1),
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(
                                                      5.0) //                 <--- border radius here
                                                  ),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    selectedDate != null
                                                        ? selectedDate!
                                                        : "From",
                                                    style: TextStyle(
                                                        color:
                                                            selectedDate != null
                                                                ? Colors.black
                                                                : Colors.grey),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              )))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        // YearPicker(firstDate: firstDate, lastDate: lastDate, selectedDate: selectedDate, onChanged: onChanged)
                                        DatePickerBdaya.showDatePicker(context,
                                            minTime: DateTime.now(),
                                            showTitleActions: true,
                                            onChanged: (date) {
                                          setState(() {
                                            selectedDateTo =
                                                DateFormat('y-MM-dd')
                                                    .format(date)
                                                    .toString();
                                            print(DateFormat('y')
                                                .format(date)
                                                .toString());
                                          });
                                        }, onConfirm: (date) {
                                          setState(() {});
                                        }, currentTime: DateTime.now());
                                      },
                                      child: Container(
                                          height: 60,
                                          width: Responsive.width(context),
                                          decoration: BoxDecoration(
                                              //   color: AppColors.primaryColor.withOpacity(0.1),
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(
                                                      5.0) //                 <--- border radius here
                                                  ),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    selectedDateTo != null
                                                        ? selectedDateTo!
                                                        : "Till",
                                                    style: TextStyle(
                                                        color: selectedDateTo !=
                                                                null
                                                            ? Colors.black
                                                            : Colors.grey),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              )))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Quantities available for hire",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
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
                                            hintText:
                                                'Number of quantity for hire'),
                                        isExpanded: true,
                                        value: selectedQuantity!,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedQuantity = newValue;
                                          });
                                        },
                                        items: <String>[
                                          '1',
                                          '2',
                                          '3',
                                          '4',
                                          '5',
                                          '6',
                                          '7',
                                          '8',
                                          '9',
                                          '10',
                                          '11',
                                          '12',
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
                                    height: 20,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showPlacePicker();
                                      },
                                      child: TextFormField(
                                        enabled: false,
                                        controller: deliveryController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter delivery location',
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
                                    height: 30,
                                  ),
                                  Center(
                                      child: SlideTransition(
                                          position: _navAnimation!,
                                          //  textDirection: TextDirection.rtl,
                                          child: BaseButton(
                                              isBusy:
                                                  model.busy("UpdateMyEquip"),
                                              onPressed: () {
                                                if (nameController.text.isNotEmpty &&
                                                    listImages.isNotEmpty &&
                                                    costController
                                                        .text.isNotEmpty &&
                                                    selectedDate != null &&
                                                    selectedDateTo != null &&
                                                    selectedPer != null &&
                                                    selectedQuantity != null) {
                                                  _startUploading(model);
                                                } else {
                                                  showErrorToast(
                                                      "Name and images are compulsory",
                                                      context: context);
                                                }
                                              },
                                              label: "Save & Proceed"))),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}

import 'package:equipro/core/model/ActiveRentalsModel.dart' as active;
import 'package:equipro/ui/screens/hirer/active_rentals/edit_booking/view_model.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../../../core/model/active_rentals/active_rentals.dart';

class EditBookings extends StatefulWidget {
  final ActiveRentalsModel model;
  const EditBookings({Key? key, required this.model}) : super(key: key);

  @override
  State<EditBookings> createState() => _EditBookingsState();
}

class _EditBookingsState extends State<EditBookings> {
  int? selectedQuantity;
  var quantityList;
  String? pickupTime = DateTime.now().toString();
  String? selectedDate;
  String? selectedWeek;
  String? selectedDateTo;
  double? pickLat;
  double? pickLng;
  TextEditingController deliveryController = TextEditingController();

  void showPlacePicker() async {
    LocationResult result =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PlacePicker("AIzaSyAsoaOKfTVMSJll6LvVcQ3sYgALbwJ0B9A");
    }));
    // Handle the result in your way
    print(result);

    setState(() {
      print(result);
      deliveryController.text = result.formattedAddress!;
      pickLat = result.latLng!.latitude;
      pickLng = result.latLng!.longitude;
    });
  }

  @override
  void initState() {
    quantityList =
        List<int>.generate(int.parse(widget.model.quantity!), (i) => i + 1);
    setState(() {
      selectedDate = widget.model.rental_from;
      selectedDateTo = widget.model.rental_to;
      selectedQuantity = int.parse(widget.model.quantity!);
      deliveryController.text = widget.model.delivery_location!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Booking"),
        leading: CustomBackButton(),
      ),
      body: ViewModelBuilder<EditBookingViewModel>.reactive(
          viewModelBuilder: () => EditBookingViewModel(),
          builder: (context, model, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    // width: Responsive.width(context),
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: DropdownButtonFormField<int>(
                        decoration: InputDecoration.collapsed(
                            hintText: 'Number of quantity to hire'),
                        isExpanded: true,
                        value: selectedQuantity,
                        onChanged: (newValue) {
                          setState(() {
                            selectedQuantity = newValue;
                          });
                        },
                        items: quantityList
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        // YearPicker(firstDate: firstDate, lastDate: lastDate, selectedDate: selectedDate, onChanged: onChanged)
                        DatePickerBdaya.showDatePicker(context,
                            minTime: DateTime.now(),
                            showTitleActions: true, onChanged: (date) {
                          setState(() {
                            selectedDate =
                                DateFormat('y-MM-dd').format(date).toString();
                          });
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date) {
                          setState(() {});
                        }, currentTime: DateTime.now());
                      },
                      child: Container(
                          height: 60,
                          // width: Responsive.width(context),
                          decoration: BoxDecoration(
                              //   color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDate != null
                                        ? selectedDate!
                                        : "From",
                                    style: TextStyle(
                                        color: selectedDate != null
                                            ? Colors.black
                                            : Colors.grey),
                                  ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.grey,
                                  )
                                ],
                              )))),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        // YearPicker(firstDate: firstDate, lastDate: lastDate, selectedDate: selectedDate, onChanged: onChanged)
                        DatePickerBdaya.showDatePicker(context,
                            minTime: DateTime.now(),
                            showTitleActions: true, onChanged: (date) {
                          setState(() {
                            selectedDateTo =
                                DateFormat('y-MM-dd').format(date).toString();
                            print(DateFormat('y').format(date).toString());
                          });
                        }, onConfirm: (date) {
                          setState(() {});
                        }, currentTime: DateTime.now());
                      },
                      child: Container(
                          height: 60,
                          // width: Responsive.width(context),
                          decoration: BoxDecoration(
                              //   color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDateTo != null
                                        ? selectedDateTo!
                                        : "Till",
                                    style: TextStyle(
                                        color: selectedDateTo != null
                                            ? Colors.black
                                            : Colors.grey),
                                  ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.grey,
                                  )
                                ],
                              )))),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
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
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                      )),
                  Gap(40),
                  BaseButton(
                    label: "Continue",
                    isBusy: model.busy("Editing"),
                    onPressed: () => model.submitEditBooking({
                      ""
                          "quantity": selectedQuantity,
                      "rental_from": selectedDate,
                      "rental_to": selectedDateTo,
                      "delivery_location": deliveryController.text,
                      "longitude": pickLng,
                      "latitude": pickLat
                    }, context),
                  )
                ],
              ),
            );
          }),
    );
  }
}

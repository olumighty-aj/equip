import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rentals_view_model.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/extensions.dart';
import 'package:equipro/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../widget/equip_tiles.dart';

class ExtendBookingScreen extends StatefulWidget {
  final ActiveRentalsModel feed;
  ExtendBookingScreen({Key? key, required this.feed}) : super(key: key);

  @override
  State<ExtendBookingScreen> createState() => _ExtendBookingScreenState();
}

class _ExtendBookingScreenState extends State<ExtendBookingScreen> {
  String? selectedWeek;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: ViewModelBuilder<RentalsViewModel>.reactive(
          viewModelBuilder: () => RentalsViewModel(),
          builder: (context, model, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.feed.equipments!.equipName!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 25,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w800),
                  ),
                  Gap(30),
                  Row(
                    children: [
                      Text(
                          "${getCurrency(widget.feed.hirers!.country) + widget.feed.equipments!.costOfHire!}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.green)),
                      Text(
                          " per ${widget.feed.equipments!.costOfHireInterval == "1" ? "Day" : widget.feed.equipments!.costOfHireInterval == "7" ? "Week" : "Month"}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.green)),
                    ],
                  ),
                  Gap(24),
                  Row(
                    children: [
                      Text(
                        "Availability: ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${DateTime.parse(widget.feed.rentalFrom!).toDate()} - ${DateTime.parse(widget.feed.rentalTo!).toDate()}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Gap(26),
                  // GestureDetector(
                  //   onTap: () => Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => ChatDetailsPage(
                  //               feed: ChatListModel(
                  //                   id: widget.feed.equipments!.ownersId,
                  //                   userId: "",
                  //                   chatWithId: "",
                  //                   messageCount: "",
                  //                   lastMessage: "",
                  //                   dateCreated: "",
                  //                   dateModified: "",
                  //                   chatWith: ChatWith(
                  //                     id: widget.feed.equipments!.ownersId,
                  //                     fullname: widget.feed.ow,
                  //                     email: "",
                  //                     phoneNumber: "",
                  //                     gender: "",
                  //                     address: "",
                  //                     addressOpt: "",
                  //                     localState: "",
                  //                     country: "",
                  //                     latitude: "",
                  //                     longitude: "",
                  //                     hirersPath:
                  //                         widget.feed.hirers!.hirersPath != null
                  //                             ? widget.feed.hirers!.hirersPath!
                  //                             : "",
                  //                     status: "",
                  //                     dateModified: "",
                  //                     dateCreated: "",
                  //                   ))))),
                  //   child: Text(
                  //     "Chat Owner",
                  //     // textAlign: TextAlign.center,
                  //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //         color: AppColors.primaryColor,
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //         decoration: TextDecoration.underline),
                  //   ),
                  // ),
                  Divider(indent: 5),
                  Gap(15),
                  Text(
                    "Extend booking period",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Color(0xFF022F40)),
                  ),
                  Gap(18),
                  Text(
                    "Start date will be from the day the previous booking ends",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700, color: Color(0xFF596273)),
                  ),
                  Gap(54),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      // suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                      hintText: 'Number of weeks',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                    isExpanded: true,
                    value: selectedWeek,
                    onChanged: (newValue) {
                      selectedWeek = newValue;
                    },
                    items: <String>[
                      '1',
                      '2',
                      '3',
                      '4',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Gap(51),
                  BaseButton(
                    isBusy: model.busy("extend"),
                    label: "Send Booking Request",
                    onPressed: () {
                      DateTime parsedDate =
                          DateFormat('yyyy-MM-dd').parse(widget.feed.rentalTo!);
                      int numberOfWeeks = int.tryParse(selectedWeek!) ?? 0;
                      DateTime resultDate =
                          parsedDate.add(Duration(days: numberOfWeeks * 7));
                      print("New Date: $resultDate");
                      model.extendBooking({
                        "rental_end": resultDate.toDashDate(),
                        "prev_equip_order_id": widget.feed.equipOrderId,
                        "longitude":
                            locator<Authentication>().currentUser.longitude,
                        "latitude":
                            locator<Authentication>().currentUser.latitude,
                      }, context);
                    },
                  )
                ],
              ),
            );
          }),
    );
  }
}

import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/model/ChatListModel.dart';
import '../../../widget/equip_tiles.dart';
import '../../chat/chats_widget/chat_details.dart';

class ExtendBookingScreen extends StatelessWidget {
  final ActiveRentalsModel feed;
  ExtendBookingScreen({Key? key, required this.feed}) : super(key: key);

  String? selectedWeek;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              feed.equipments!.equipName!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 25,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w800),
            ),
            Gap(30),
            Row(
              children: [
                Text(
                    "${getCurrency(feed.hirers!.country) + feed.equipments!.costOfHire!}",
                    style: Theme.of(context).textTheme.bodySmall),
                Text(
                    " per ${feed.equipments!.costOfHireInterval == "1" ? "Day" : feed.equipments!.costOfHireInterval == "7" ? "Week" : "Month"}",
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Row(
              children: [
                Text("Availability:"),
                Text(
                    "${DateTime.parse(feed.rentalFrom!).toDate()} - ${DateTime.parse(feed.rentalTo!).toDate()}"),
              ],
            ),
            Gap(36),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatDetailsPage(
                          feed: ChatListModel(
                              id: feed.equipments!.ownersId,
                              userId: "",
                              chatWithId: "",
                              messageCount: "",
                              lastMessage: "",
                              dateCreated: "",
                              dateModified: "",
                              chatWith: ChatWith(
                                id: feed.equipments!.ownersId,
                                fullname: feed.equipments!.ownersId,
                                email: "",
                                phoneNumber: "",
                                gender: "",
                                address: "",
                                addressOpt: "",
                                localState: "",
                                country: "",
                                latitude: "",
                                longitude: "",
                                hirersPath: feed.hirers!.hirersPath != null
                                    ? feed.hirers!.hirersPath!
                                    : "",
                                status: "",
                                dateModified: "",
                                dateCreated: "",
                              ))))),
              child: Text(
                "Chat Owner",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline),
              ),
            ),
            Divider(indent: 5),
            Gap(15),
            Text(
              "Extend booking period",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            Gap(18),
            Text(
              "Start date will be from the day the previous booking ends",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Gap(54),
            DropdownButtonFormField<String>(
              decoration:
                  InputDecoration.collapsed(hintText: 'Number of weeks'),
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
              label: "Send Booking Request",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

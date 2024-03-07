import 'package:equipro/ui/bottomsheets/view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../widget/base_button.dart';

class LocationSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  const LocationSheet(
      {Key? key, required this.completer, required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: ViewModelBuilder<LocationSheetViewModel>.reactive(
            viewModelBuilder: () => LocationSheetViewModel(),
            builder: (context, model, _) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  Gap(10),
                  Text("Location is turned off. Turn it on to use the app"),
                  Gap(30),
                  BaseButton(
                    label: "Turn on",
                    onPressed: () async {
                      bool isActive = await model.requestPermission();
                      if (isActive) {
                        completer(
                            SheetResponse(confirmed: true, data: isActive));
                      }
                    },
                  )
                ],
              );
            }));
  }
}

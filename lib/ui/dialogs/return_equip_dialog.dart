import 'package:equipro/app/app_setup.router.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/active_rentals.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/noti_widget.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../../utils/colors.dart';

class ReturnEquipDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const ReturnEquipDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.40,
        width: 200,
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Gap(20),
                    Text(
                      "Return Equipment",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Gap(43),
                    Text(
                      "Confirm you want to return this equipment to Owner. The equipment will be picked up from your location and delivered to the owner",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey))),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            completer(DialogResponse(confirmed: false)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 24, horizontal: 20),
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => completer(
                            DialogResponse(confirmed: true, data: "confirm")),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                              )),
                          padding: EdgeInsets.symmetric(
                              vertical: 24, horizontal: 20),
                          child: Text(
                            "Confirm",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

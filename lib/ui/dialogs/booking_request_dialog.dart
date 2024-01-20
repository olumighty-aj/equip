import 'package:equipro/app/app_setup.router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../../utils/colors.dart';

class BookingRequestDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const BookingRequestDialog(
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
                    Text(
                      "Booking Request\nSent",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Gap(37),
                    Text(
                      "Booking request has been sent to equipment owner. You will be notified ones your request is approved",
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
              child: GestureDetector(
                onTap: () => locator<NavigationService>()
                    .clearTillFirstAndShow(Routes.rentals),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Text(
                    "Okay",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

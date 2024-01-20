import 'package:equipro/ui/widget/base_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';


class ExitApp extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const ExitApp({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.23,
          width: 150,
          padding: EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                "Are you sure you want to exit the app?",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Gap(30),
              Row(
                children: [
                  Expanded(
                    child: BaseButton(
                      label: "Cancel",
                      hasBorder: true,
                      onPressed: () =>
                          completer(DialogResponse(confirmed: false)),
                    ),
                  ),
                  Gap(15),
                  Expanded(
                    child: BaseButton(
                      label: "Yes, Exit",
                      onPressed: () =>
                          completer(DialogResponse(confirmed: true)),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

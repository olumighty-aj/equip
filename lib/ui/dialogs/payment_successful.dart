import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentSuccessfulDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const PaymentSuccessfulDialog(
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
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Gap(17),
                    Text(
                      "Payment Successful",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Gap(37),
                    Text(
                      "Payment of ${request.data["amount"]} for hiring wheelbarrow has been completed successfully ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/input_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../utils/colors.dart';

class PaymentMethodDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const PaymentMethodDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.55,
          width: 250,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Method",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  GestureDetector(
                      onTap: () => completer(DialogResponse(confirmed: false)),
                      child: Icon(Icons.close)),
                ],
              ),
              Gap(5),
              Divider(),
              Gap(10),
              CustomTextField(
                fillColor: AppColors.primaryColor.withOpacity(0.15),
                label: "Bank Name",
                hintText: "Enter bank name",
              ),
              Gap(10),
              CustomTextField(
                fillColor: AppColors.primaryColor.withOpacity(0.15),
                label: "Account Number",
                hintText: "Enter account number",
              ),
              Gap(10),
              CustomTextField(
                fillColor: AppColors.primaryColor.withOpacity(0.15),
                label: "Account Name",
                hintText: "Enter account name",
              ),
              Gap(40),
              BaseButton(
                label: "Submit",
                onPressed: () {},
              )
            ],
          )),
    );
  }
}

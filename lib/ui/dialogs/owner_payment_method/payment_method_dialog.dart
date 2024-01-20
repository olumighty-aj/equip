import 'package:equipro/ui/dialogs/owner_payment_method/view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/input_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../utils/colors.dart';

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
          child: ViewModelBuilder<PaymentMethodViewModel>.reactive(
              viewModelBuilder: () => PaymentMethodViewModel(),
              builder: (context, model, _) {
                return Column(
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
                            onTap: () =>
                                completer(DialogResponse(confirmed: false)),
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
                      controller: model.bankNameController,
                    ),
                    Gap(10),
                    CustomTextField(
                      fillColor: AppColors.primaryColor.withOpacity(0.15),
                      label: "Account Number",
                      keyboardType: TextInputType.number,
                      hintText: "Enter account number",
                      controller: model.accountNumberController,
                    ),
                    Gap(10),
                    CustomTextField(
                      fillColor: AppColors.primaryColor.withOpacity(0.15),
                      label: "Account Name",
                      hintText: "Enter account name",
                      controller: model.accountNameController,
                    ),
                    Gap(40),
                    BaseButton(
                      isBusy: model.busy("paymentMethod"),
                      label: "Submit",
                      onPressed: () async {
                        var res = await model.addPaymentMethod(context);
                        if (res == true) {
                          completer(DialogResponse(confirmed: true));
                        }
                      },
                    )
                  ],
                );
              })),
    );
  }
}

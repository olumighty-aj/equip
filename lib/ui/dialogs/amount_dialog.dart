import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/input_fields/custom_text_field.dart';
import 'package:equipro/ui/widget/noti_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

class AmountDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const AmountDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  State<AmountDialog> createState() => _AmountDialogState();
}

class _AmountDialogState extends State<AmountDialog> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: 150,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amount to withdraw",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                      onTap: () =>
                          widget.completer(DialogResponse(confirmed: false)),
                      child: Icon(Icons.close)),
                ],
              ),
              Divider(),
              Gap(10),
              CustomTextField(
                controller: controller,
                keyboardType: TextInputType.phone,
              ),
              Gap(10),
              BaseButton(
                label: "Withdraw",
                onPressed: () => widget.completer(
                    DialogResponse(confirmed: true, data: controller.text)),
              )
            ],
          )),
    );
  }
}

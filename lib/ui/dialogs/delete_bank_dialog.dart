import 'package:equipro/ui/widget/base_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

class DeleteBankDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const DeleteBankDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.23,
          width: 150,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                "Are you sure you want to delete bank?",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Gap(41),
              Row(children: [
                Expanded(
                  child: BaseButton(
                    hasBorder: true,
                    label: "Cancel",
                    onPressed: () =>
                        completer(DialogResponse(confirmed: false)),
                  ),
                ),
                Gap(15),
                Expanded(
                  child: BaseButton(
                      label: "delete",
                      onPressed: () => completer(
                          DialogResponse(confirmed: true, data: true))),
                ),
              ])
            ],
          )),
    );
  }
}

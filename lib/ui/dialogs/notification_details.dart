import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/ui/widget/noti_widget.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationDetail extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const NotificationDetail(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.42,
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
                    "Message",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                      onTap: () => completer(DialogResponse(confirmed: false)),
                      child: Icon(Icons.close)),
                ],
              ),
              Divider(),
              Gap(10),
              Text(
                request.data["message"],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Expanded(child: Gap(20)),
              Text(
                DateTime.parse(request.data["date_created"])
                    .formatToCustomFormat(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey),
              )
            ],
          )),
    );
  }
}

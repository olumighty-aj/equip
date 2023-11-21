import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_setup.locator.dart';
import '../../app/app_setup.router.dart';
import '../../utils/app_svgs.dart';
import '../../utils/colors.dart';
import '../../utils/tiny_db.dart';

class LogoutDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const LogoutDialog({Key? key, required this.request, required this.completer})
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
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: () => completer(DialogResponse(confirmed: false)),
                    child: Icon(
                      Icons.close,
                      color: Colors.black54,
                    )),
              ),
              CircleAvatar(
                backgroundColor: Color(0x89FFEBAD),
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset(AppSvgs.login),
                ),
              ),
              Gap(21),
              Text(
                "Confirm Logout",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Gap(41),
              BaseButton(
                  label: "Yes, Log Out",
                  onPressed: () {
                    locator<Authentication>()
                        .logout(context: context)
                        .then((value) {
                      if (value == true) {
                        TinyDb.removeAll();
                        locator<NavigationService>()
                            .clearStackAndShow(Routes.login);
                      } else {
                        showErrorToast("Failed, please try again",
                            context: context);
                      }
                    });
                  }),
              Gap(32),
              GestureDetector(
                onTap: () => completer(DialogResponse(confirmed: false)),
                child: Text(
                  "Not Yet",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                      fontSize: 18),
                ),
              )
            ],
          )),
    );
  }
}

import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/screens/settings/view_model.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/app_svgs.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ViewModelBuilder<SettingsViewModel>.reactive(
            viewModelBuilder: () => SettingsViewModel(),
            onViewModelReady: (model) => model.getSettings(),
            builder: (context, model, _) {
              if (!model.busy("settings")) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Settings",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    Gap(45),
                    ListTile(
                      leading: SvgPicture.asset(AppSvgs.notification),
                      title: Text(
                        "Notifications",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 18),
                      ),
                      subtitle: Text(
                        "Turn on or off notifications",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 13, color: Colors.grey),
                      ),
                      trailing: Switch.adaptive(
                          value: model.isNotificationEnabled,
                          activeColor: AppColors.primaryColor,
                          activeTrackColor: AppColors.primaryColor,
                          inactiveThumbColor: Colors.white,
                          thumbColor: MaterialStateProperty.all(Colors.white),
                          onChanged: (val) =>
                              model.changeNotificationState(val, context)),
                    ),
                    ListTile(
                      leading: SvgPicture.asset(AppSvgs.profile),
                      title: Text(
                        "Profile Visibility",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 18),
                      ),
                      subtitle: Text(
                        "Make my profile private",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 13, color: Colors.grey),
                      ),
                      trailing: Switch.adaptive(
                          value: model.isProfileVisible,
                          activeColor: AppColors.primaryColor,
                          activeTrackColor: AppColors.primaryColor,
                          inactiveThumbColor: Colors.white,
                          thumbColor: MaterialStateProperty.all(Colors.white),
                          onChanged: (val) =>
                              model.changeProfileVisibilityState(val, context)),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )),
                );
              }
            }),
      ),
    );
  }
}

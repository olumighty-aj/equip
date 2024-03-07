import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/screens/profile/kyc_verif/view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../../utils/colors.dart';

class BecomeOwnerScreen extends StatelessWidget {
  const BecomeOwnerScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ViewModelBuilder<KYCViewModel>.reactive(
          viewModelBuilder: ()=> KYCViewModel(),
          builder: (context, model, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Become an Owner",  style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),),

                Gap(35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Become an Owner",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        // fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    // Gap(5),
                    Switch.adaptive(
                      inactiveTrackColor: Colors.grey,
                      activeColor: AppColors.primaryColor,
                      value: model.isOwner,
                      onChanged: model.isOwner
                          ? null
                          : (val) => model.becomeOwner(context, val),
                    ),
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

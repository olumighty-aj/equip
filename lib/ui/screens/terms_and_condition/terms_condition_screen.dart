import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/screens/terms_and_condition/view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/colors.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Terms & Condition",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 28),
              ),
              Gap(20),
              ViewModelBuilder<TermsConditionsViewModel>.reactive(
                  viewModelBuilder: () => TermsConditionsViewModel(),
                  builder: (context, model, _) {
                    return FutureBuilder<String>(
                        future: model.fetchTermsAndConditions(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  )),
                            );
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              textAlign: TextAlign.justify,
                            );
                          } else {
                            return Center(
                              child:
                                  Text("An error occurred, please try again."),
                            );
                          }
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

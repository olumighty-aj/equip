import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/screens/terms_and_condition/view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

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
                    // return FutureBuilder<String>(
                    //     future: model.fetchTermsAndConditions(),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return Center(
                    //           child: SizedBox(
                    //               height: 30,
                    //               width: 30,
                    //               child: CircularProgressIndicator(
                    //                 color: AppColors.primaryColor,
                    //               )),
                    //         );
                    //       } else if (snapshot.connectionState ==
                    //               ConnectionState.done &&
                    //           snapshot.hasData) {
                    //         return Text(
                    //           snapshot.data!,
                    //           textAlign: TextAlign.justify,
                    //         );
                    //       } else {
                    //         return Center(
                    //           child:
                    //               Text("An error occurred, please try again."),
                    //         );
                    //       }
                    //     });
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Welcome to Equipro. By using our platform, you agree to comply with the following terms and conditions:",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Gap(20),
                        Text(
                          "1. General Terms",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "a. Eligibility: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  "To use our platform, you must be at least 18 years old and have the legal capacity to enter into contracts.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "b. Registration: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  "When you register for an account, you agree to provide accurate and complete information. You are responsible for maintaining the confidentiality of your account details and for all activities that occur under your account.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "c. Content: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  "You agree to use our platform for lawful purposes only. You may not post or upload any content that is illegal, offensive or violates the rights of others.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "d. Intellectual Property: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  "All content and materials on our platform are owned by Equipro.io or its affliates. You may not use, copy, or distribute any content or materials without our prior written consent.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(20),
                        Text(
                          "2. User Responsibilities",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "a. Contractors: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  "Contractors are responsible for ensuring that their projects comply with all applicable laws and regulations. They are also responsible for ensuring that they have the necessary permits and approvals to carry out their projects.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "b. Equipment Owners: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  "Equipment owners are responsible for ensuring that their equipment is in good condition and complies with all applicable laws and regulations. They are also responsible for ensuring that their equipment is available for rental as agreed with the contractor.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "c. Payment: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  "Contractors are responsible for paying equipment owners for rental fees and any other charges associated with the rental. Payments should be made through our platform.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(20),
                        Text(
                          "3. Disclaimers and Limitations of Liability",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "a. Equipro.io does not guarantee the accuracy or completeness of any content or materials on our platform.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "b. Equipro.io is not responsible for any damages or losses incurred as a result of using our platform or any content or materials on our platform.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "c. Equipro.io is not responsible for any disputes that may arise between contractors and equipment owners.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(20),
                        Text(
                          "4. Governing Law",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Gap(10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "These terms and conditions shall be governed by and construed in accordance with the laws of the United Kingdom.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                        Gap(20),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "Thank you for choosing Equipro.io. If you have any questions or concerns about these terms and conditions, please contact us.",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

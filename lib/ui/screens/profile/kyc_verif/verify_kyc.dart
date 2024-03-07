import 'package:equipro/ui/screens/profile/kyc_verif/view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../../utils/colors.dart';
import '../edit_profile.dart';

class KYCVerificationScreen extends StatelessWidget {
  const KYCVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ViewModelBuilder<KYCViewModel>.reactive(
            onViewModelReady: (model) => model.init(),
            viewModelBuilder: () => KYCViewModel(),
            builder: (context, model, _) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Verify KYC",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    Gap(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Means Of Identification",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          // width: Responsive.width(context),
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Select One'),
                              isExpanded: true,
                              value: model.selectedMOI,
                              onChanged: (val) => model.onChangedMOI(val),
                              items: model.kycApproved
                                  ? []
                                  : <String>[
                                      'International Passport',
                                      'Voters Card',
                                      'National ID',
                                      'Driver License',
                                    ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Upload the image",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Gap(10),
                        GestureDetector(
                            onTap: model.kycApproved
                                ? null
                                : () => model.handleChooseFromGalleryId(),
                            child: TextFormField(
                              enabled: false,
                              controller: model.uploadController,
                              decoration: InputDecoration(
                                hintText: 'Upload ID',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black),
                              cursorColor: Colors.black,
                            )),
                        Gap(20),
                        Text(
                          "Country",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        TextFormField(
                          controller: model.countryController,
                          enabled: !model.kycApproved,
                          decoration: InputDecoration(
                            hintText: 'Enter Country',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                        ),
                        Gap(30),
                        BaseButton(
                            label: "Submit",
                            onPressed: model.kycApproved
                                ? null
                                : () => model.verifyKYC(context),
                            isBusy: model.busy('verify')),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

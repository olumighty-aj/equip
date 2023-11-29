import 'package:equipro/core/model/VerifyForgotPassword.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';

import '../../../widget/base_button.dart';
import '../view_model.dart';

class VerifyForgotPasswordPage extends StatefulWidget {
  final String email;
  const VerifyForgotPasswordPage({Key? key, required this.email})
      : super(key: key);

  @override
  VerifyForgotPasswordPageState createState() =>
      VerifyForgotPasswordPageState();
}

class VerifyForgotPasswordPageState extends State<VerifyForgotPasswordPage> {
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool passwordVisible;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewLoginViewModel>.reactive(
        viewModelBuilder: () => NewLoginViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  // fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                        width: Responsive.width(context),
                        height: Responsive.height(context) / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/login_background.png"),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                AppColors.black.withOpacity(0.3),
                                BlendMode.darken),
                          ),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 250,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                )),
                            height: MediaQuery.of(context).size.height * 0.7,
                            padding: EdgeInsets.all(16),
                            child: SingleChildScrollView(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'Reset ',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        'Password',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Type the otp you received on ${widget.email} and your new password",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                Gap(15),
                                Form(
                                    key: _formKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Please enter your OTP',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.grey),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            validator: Validators().isEmpty,
                                            controller: otpController,
                                            // maxLength: 11,
                                            decoration: InputDecoration(
                                              hintText: 'Enter OTP',
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey),
                                              labelStyle: const TextStyle(
                                                  color: AppColors.black),
                                            ),
                                            onChanged: (v) {
                                              setState(() {});
                                            },
                                            keyboardType: TextInputType.number,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            cursorColor: Colors.black,
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          const Text(
                                            'Please enter your new password',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.white),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            validator: Validators().isEmpty,
                                            controller: passwordController,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  // Based on passwordVisible state choose the icon
                                                  passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    passwordVisible =
                                                        !passwordVisible;
                                                  });
                                                },
                                              ),
                                              hintText: '******',
                                              hintStyle: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            onChanged: (v) {
                                              setState(() {});
                                            },
                                            obscureText: passwordVisible,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            cursorColor: Colors.black,
                                          ),
                                        ])),
                                const SizedBox(
                                  height: 40,
                                ),
                                BaseButton(
                                  isBusy: model.busy("Verify"),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      model.newVerifyForgotPassword(
                                          VerifyForgotPassword(
                                              password: passwordController.text,
                                              otp: otpController.text,
                                              email: widget.email),
                                          context);
                                    }
                                  },
                                  label: 'Verify',
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ));
        });
  }
}

import 'package:equipro/core/model/VerifyForgotPassword.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';

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
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              body: Column(
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
                          image:
                              AssetImage("assets/images/login_background.png"),
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
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                          ),
                          height: Responsive.height(context) / 1.6,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              Form(
                                  key: _formKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Please enter your OTP',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.white),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              validator: Validators().isEmpty,
                                              controller: otpController,
                                              // maxLength: 11,
                                              decoration: InputDecoration(
                                                hintText: '',
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                labelStyle: const TextStyle(
                                                    color: AppColors.black),
                                              ),
                                              onChanged: (v) {
                                                setState(() {});
                                              },
                                              keyboardType:
                                                  TextInputType.number,
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
                                          ]))),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  padding: const EdgeInsets.all(20),
                                  child: GeneralButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        model.verifyForgotPassword(
                                            VerifyForgotPassword(
                                                password:
                                                    passwordController.text,
                                                otp: otpController.text,
                                                email: widget.email));
                                      }
                                    },
                                    buttonText: 'Verify',
                                    buttonTextColor: AppColors.white,
                                  )),
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
          ));
        });
  }
}

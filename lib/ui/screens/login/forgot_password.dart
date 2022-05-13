import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/notification_helper.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool passwordVisible;
  late String fcmToken;

  late bool active = false;

  getFCMToken() async {
    fcmToken = await NotificationHelper.getFcmToken();
  }

  @override
  void initState() {
    super.initState();
    getFCMToken();
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
                                      'Forgot ',
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
                                "Type your email address to send instructions to reset your password to your inbox",
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
                                            const SizedBox(
                                              height: 50,
                                            ),
                                            Text(
                                              "Email Address",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            TextFormField(
                                              validator: Validators().isEmpty,
                                              controller: emailController,
                                              // maxLength: 11,
                                              decoration: InputDecoration(
                                                hintText: 'deo@gmail.com',
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                labelStyle: const TextStyle(
                                                    color: AppColors.black),
                                              ),
                                              onChanged: (v) {
                                                setState(() {});
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                          ]))),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                  padding: const EdgeInsets.all(20),
                                  child: GeneralButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        model.forgotPassword(
                                            emailController.text);
                                      }
                                    },
                                    buttonText: 'Reset Password',
                                    splashColor: AppColors.primaryColor,
                                    buttonTextColor: AppColors.white,
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                              Center(
                                  child: Text("Log in",
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          decoration:
                                              TextDecoration.underline))),
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

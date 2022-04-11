
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class VerifyForgotPasswordPage extends StatefulWidget {
  const VerifyForgotPasswordPage({Key? key}) : super(key: key);

  @override
  VerifyForgotPasswordPageState createState() => VerifyForgotPasswordPageState();
}

class VerifyForgotPasswordPageState extends State<VerifyForgotPasswordPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Authentication _authentication = locator<Authentication>();
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
              backgroundColor: AppColors.secondaryColor,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: Colors.white,
                            )),
                        Text('')
                      ],
                    ),
                    Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          const Text(
                            'Muve',
                            style: TextStyle(
                                fontSize: 25,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Forgot password',
                            style: TextStyle(
                                fontSize: 28,
                                color: AppColors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ])),
                    Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Please enter your OTP',
                                    style: TextStyle(
                                        fontSize: 15, color: AppColors.white),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    validator: Validators().isEmpty,
                                    controller: otpController,
                                    decoration: InputDecoration(
//
                                      hintText: '',
                                      hintStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.white),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.white),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.white),
                                      ),
                                      labelStyle: const TextStyle(
                                          color: AppColors.green),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.white),
                                    cursorColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    'Please enter your new password',
                                    style: TextStyle(
                                        fontSize: 15, color: AppColors.white),
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
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            passwordVisible = !passwordVisible;
                                          });
                                        },
                                      ),
                                      hintText: '******',
                                      hintStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      labelStyle: const TextStyle(
                                          color: AppColors.white),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                        borderSide: BorderSide(width: 1,color: Colors.white),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                        borderSide: BorderSide(width: 1,color: Colors.white),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                        borderSide: BorderSide(width: 1,color: Colors.white),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    obscureText: passwordVisible,
                                    keyboardType: TextInputType.visiblePassword,
                                    style: const TextStyle(color: Colors.white),
                                    cursorColor: Colors.white,
                                  ),
                                ]))),
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: GeneralButton(
                          onPressed: () {
    if (_formKey.currentState!.validate()) {
      // _navigationService.navigateTo(verificationViewRoute);
      // model.verifyForgotPassword(VerifyForgotPassword(
      //     userId:_authentication.userId, password: passwordController.text, code: otpController.text));
    } },
                          buttonText: 'Verify',
                          splashColor: const Color(0xff8CD96B),
                          buttonTextColor: AppColors.white,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ));
        });
  }
}

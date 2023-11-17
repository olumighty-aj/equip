import 'package:equipro/core/model/LoginPayload.dart';
import 'package:equipro/ui/screens/login/view_model.dart';
import 'package:equipro/ui/screens/login/view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:equipro/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/notification_helper.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

import '../../../utils/text_styles.dart';
import '../register/register_view.dart';
import 'forgt_password/forgot_password.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewLoginViewModel>.reactive(
        viewModelBuilder: () => NewLoginViewModel(),
        onViewModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return NewLogin();
          //   Scaffold(
          //     body: SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       Stack(
          //         children: [
          //           Container(
          //               width: Responsive.width(context),
          //               height: Responsive.height(context) / 2,
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   image: AssetImage(
          //                       "assets/images/login_background.png"),
          //                   fit: BoxFit.fill,
          //                   colorFilter: ColorFilter.mode(
          //                       AppColors.black.withOpacity(0.3),
          //                       BlendMode.darken),
          //                 ),
          //               )),
          //           Align(
          //               alignment: Alignment.bottomCenter,
          //               child: LoginContainer()),
          //         ],
          //       ),
          //     ],
          //   ),
          // ));
        });
  }
}

class NewLogin extends StatelessWidget {
  const NewLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.green,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/login_background.png"),
                            fit: BoxFit.cover)),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Container(
                        //   color: Colors.red,
                        //   height: 150,
                        // ),
                        Expanded(child: SizedBox()),
                        LoginContainer(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginContainer extends ViewModelWidget<NewLoginViewModel> {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        // Gap(200),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Gap(30),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Log In To ',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                    Text('Account',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 24,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600)),
                  ]),
              Gap(40),
              Form(
                  key: model.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email Address",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey.shade400)),
                        TextFormField(
                          validator: Validators().isEmpty,
                          controller: model.emailController,
                          // maxLength: 11,
                          decoration: InputDecoration(
                            hintText: 'deo@gmail.com',
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelStyle: const TextStyle(color: AppColors.black),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: Colors.black,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Password",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey.shade400)),
                            Gap(5),
                            TextFormField(
                              validator: Validators().isEmpty,
                              controller: model.passwordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      model.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: model.togglePassword),
                                hintText: '******',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              obscureText: model.passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(color: Colors.black),
                              cursorColor: Colors.black,
                            ),
                          ],
                        ),
                        Gap(30),
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordPage())),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                                Text(''),
                              ],
                            )),
                      ])),
              Gap(30),
              BaseButton(
                isBusy: model.busy("Login"),
                onPressed: () => model.newSignIn(context),
                label: 'Log In',
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account? "),
                  InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register())),
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline))),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

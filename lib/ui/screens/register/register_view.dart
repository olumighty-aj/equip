import 'package:country_pickers/country.dart';
import 'package:equipro/core/model/SignUpModel.dart';
import 'package:equipro/ui/screens/register/register_view_model.dart';
import 'package:equipro/ui/widget/phonenoTextInput.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/notification_helper.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Register> {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool passwordVisible;
  String countryCode = "234";

  late bool active = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              body: SingleChildScrollView(
              child:Column(
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
                          image: AssetImage("assets/images/reg_background.png"),
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
                          padding: EdgeInsets.all(30),
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
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'Create An ',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Account',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'For ',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Free',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              Form(
                                  key: _formKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Full Name",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            TextFormField(
                                              validator: Validators().isEmpty,
                                              controller: fullNameController,
                                              // maxLength: 11,
                                              decoration: InputDecoration(
                                                hintText: 'John Deo',
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                labelStyle: const TextStyle(
                                                    color: AppColors.black),
                                              ),
                                              onChanged: (v) {
                                                setState(() {});
                                              },
                                              keyboardType: TextInputType.name,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                            ),
                                            const SizedBox(
                                              height: 30,
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
                                            Text(
                                              "Phone Number",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            PhoneNoTextInput(
                                              onCountryChange:
                                                  (Country country) {
                                                setState(() {
                                                  countryCode =
                                                      country.phoneCode;
                                                });

                                                print("$countryCode}");
                                              },
                                              onSaved: (phoneNum) {
                                            setState(() {
                                              print("$countryCode");
                                              model.setPhoneNumber(
                                                  phoneNumber: "+" +
                                                      countryCode +
                                                      model
                                                          .sanitizePhoneNumberInput(
                                                          phoneNum));
                                            });

                                              },
                                            ),
                                            const SizedBox(
                                              height: 30,
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
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ]))),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  padding: const EdgeInsets.all(20),
                                  child: GeneralButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        model.signUp(SignUpModel(
                                            fullname: fullNameController.text,
                                            email: emailController.text,
                                            phoneNumber: "+2348169545791",
                                            password: passwordController.text));
                                      }
                                    },
                                    buttonText: 'Register',
                                    splashColor: AppColors.primaryColor,
                                    buttonTextColor: AppColors.white,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account? "),
                                  InkWell(
                                      onTap: () {
                                        _navigationService
                                            .navigateTo(loginRoute);
                                      },
                                      child: Text(" Log In",
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              decoration:
                                                  TextDecoration.underline))),
                                ],
                              )
                            ],
                          ))),
                    ],
                  ),
                ],
              ),
            ],
          )));
        });
  }
}

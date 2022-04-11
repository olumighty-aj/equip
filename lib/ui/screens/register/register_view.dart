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
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
            backgroundColor: AppColors.white,
              body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 60,
                ),
                Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      const Text(
                        'Welcome to equipro',
                        style: TextStyle(
                            fontSize: 25,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Create your account',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.black,
                        ),
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
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: Validators().isEmpty,
                                controller: fullNameController,
                                // maxLength: 11,
                                decoration: InputDecoration(
                                  hintText: 'John Doe',
                                  label: Text(
                                    "Full Name",
                                    style: TextStyle(color: AppColors.lowGrey),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: AppColors.lowGrey,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: AppColors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                onChanged: (v) {
                                  setState(() {});
                                },
                                keyboardType: TextInputType.name,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: Validators().isEmpty,
                                controller: userNameController,
                                // maxLength: 11,
                                decoration: InputDecoration(
                                  hintText: 'joe',
                                  label: Text(
                                    "Username",
                                    style: TextStyle(color: AppColors.lowGrey),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: AppColors.lowGrey,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: AppColors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                onChanged: (v) {
                                  setState(() {});
                                },
                                keyboardType: TextInputType.name,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: Validators().isEmpty,
                                controller: emailController,
                                // maxLength: 11,
                                decoration: InputDecoration(
                                  hintText: 'deo@gmail.com',
                                  label: Text(
                                    "Email",
                                    style: TextStyle(color: AppColors.lowGrey),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: AppColors.lowGrey,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: AppColors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                onChanged: (v) {
                                  setState(() {});
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: Validators().isEmpty,
                                controller: phoneNumberController,
                                // maxLength: 11,
                                decoration: InputDecoration(
                                  hintText: '+2348100000000',
                                  label: Text(
                                    "Phone Number",
                                    style: TextStyle(color: AppColors.lowGrey),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: AppColors.lowGrey,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: AppColors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                onChanged: (v) {
                                  setState(() {});
                                },
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: Validators().isEmpty,
                                controller: tagController,
                                // maxLength: 11,
                                decoration: InputDecoration(
                                  hintText: 'UI/UX Designer',
                                  label: Text(
                                    "Tag",
                                    style: TextStyle(color: AppColors.lowGrey),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: AppColors.lowGrey,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: AppColors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                onChanged: (v) {
                                  setState(() {});
                                },
                                keyboardType: TextInputType.name,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                              ),
                              const SizedBox(
                                height: 20,
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
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                  hintText: '******',
                                  label: Text(
                                    "Password",
                                    style: TextStyle(color: AppColors.lowGrey),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: AppColors.lowGrey,
                                  ),
                                  labelStyle:
                                      const TextStyle(color: AppColors.lowGrey),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.lowGrey),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                onChanged: (v) {
                                  setState(() {});
                                },
                                obscureText: passwordVisible,
                                keyboardType: TextInputType.visiblePassword,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                            ]))),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: GeneralButton(
                      active: emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty
                          ? true
                          : false,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // _navigationService.navigateTo(bookDeliveryRoute);
                          // model.signIn(LoginPayload(
                          //     email: emailController.text, password: passwordController.text, userToken: fcmToken));
                        }
                      },
                      buttonText: 'Sign In',
                      splashColor: AppColors.primaryColor,
                      buttonTextColor: AppColors.white,
                    )),
                const SizedBox(
                  height: 10,
                ),

                Center(
                  child: InkWell(
                      onTap: () {
                        _navigationService.navigateTo(loginRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Already a member? ',
                            style:
                                TextStyle(fontSize: 15, color: AppColors.black),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),

              ],
            ),
          ));
        });
  }
}

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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController emailController = TextEditingController();
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
                  height: 120,
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
                        'Login to your account',
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
                                controller: emailController,
                                // maxLength: 11,
                                decoration: InputDecoration(
                                  hintText: 'deo@gmail.com',
                                  label: Text(
                                    "Phone, Email or Username",
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
                                onChanged: (v){
                                  setState(() {

                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
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
                                onChanged: (v){
                                  setState(() {

                                  });
                                },
                                obscureText: passwordVisible,
                                keyboardType: TextInputType.visiblePassword,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    _navigationService
                                        .navigateTo(forgotPasswordRoute);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(''),
                                      InkWell(
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.primaryColor),
                                        ),
                                      ),
                                    ],
                                  )),
                            ]))),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: GeneralButton(
                      active: emailController.text.isNotEmpty && passwordController.text.isNotEmpty? true:false,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                           _navigationService.pushAndRemoveUntil(bottomNavigationRoute);
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
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Responsive.width(context) / 2.5,
                      color: AppColors.lowGrey,
                      height: 1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.lowGrey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: Responsive.width(context) / 2.5,
                      color: AppColors.lowGrey,
                      height: 1,
                    ),
                  ],
                )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: GeneralButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // _navigationService.navigateTo(bookDeliveryRoute);
                          // model.signIn(LoginPayload(
                          //     email: emailController.text, password: passwordController.text, userToken: fcmToken));
                        }
                      },
                      buttonText: 'Sign In with Google',
                      splashColor: AppColors.white,
                      borderColor: AppColors.primaryColor,
                      buttonTextColor: AppColors.primaryColor,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                      onTap: () {
                        _navigationService.navigateTo(registerRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text(
                            'Not a member?',
                            style:
                                TextStyle(fontSize: 15, color: AppColors.black),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: (){
                              _navigationService.navigateTo(registerRoute);
                            },
                            child:
                          Text(
                            'Register now',
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ) ),
                        ],
                      )),
                ),
              ],
            ),
          ));
        });
  }
}

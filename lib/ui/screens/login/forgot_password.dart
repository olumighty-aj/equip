import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController emailController = TextEditingController();
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
                      children:  [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                                child: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: Colors.black,
                            ) )),
                        Text('')
                      ],
                    ),
                    Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Forgot password',
                            style: TextStyle(
                                fontSize: 28,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),

                          const SizedBox(
                            height: 60,
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
                                    'Please enter your email',
                                    style: TextStyle(
                                        fontSize: 15, color: AppColors.black),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    validator: Validators().isEmail,
                                    controller: emailController,
                                    decoration: InputDecoration(
//
                                      hintText: 'doe@gmail.com',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                        borderSide: BorderSide(width: 1,color:  AppColors.lowGrey),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                        borderSide: BorderSide(width: 1,color:  AppColors.lowGrey),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                        borderSide: BorderSide(width: 1,color:  AppColors.lowGrey),
                                      ),
                                      labelStyle: const TextStyle(
                                          color: AppColors.green),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),

                                ]))),
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: GeneralButton(
                          onPressed: () {
    if (_formKey.currentState!.validate()) {
      //  _navigationService.navigateTo(verifyForgotPasswordRoute);
    //  model.forgotPassword(ForgotPassword(email: emailController.text));
    }  },
                          buttonText: 'Send OTP',
                        )),
                    const SizedBox(height: 20,),

                  ],
                ),
              ));
        });
  }
}

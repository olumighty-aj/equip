import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:equipro/core/model/SignUpModel.dart';
import 'package:equipro/ui/screens/login/login_view.dart';
import 'package:equipro/ui/screens/register/register_view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  // final NavService _navigationService = locator<NavService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool passwordVisible;
  String countryCode = "234";
  TextEditingController controller = TextEditingController();
  int maxLength = 10;
  String initialSelection = '+234';

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("${country.isoCode} (+${country.phoneCode})"),
          ],
        ),
      );
  Widget _buildSelectedItem(Country country) => Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+(${country.phoneCode})"),
          ],
        ),
      );
  late bool active = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        maxLength = controller.text.startsWith('0') ? 11 : 10;
      });
    });
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
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
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/reg_background.png"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              AppColors.black.withOpacity(0.3),
                              BlendMode.darken),
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                            ),
                            height: MediaQuery.of(context).size.height * 0.65,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                keyboardType:
                                                    TextInputType.name,
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
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: TextFormField(
                                                    controller: controller,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    onChanged: (v) {
                                                      print(v);
                                                      model.setPhoneNumber(
                                                          phoneNumber: "+" +
                                                              countryCode +
                                                              model
                                                                  .sanitizePhoneNumberInput(
                                                                      v));
                                                    },
                                                    maxLength: maxLength,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: widthSizer(
                                                            16.0, context)),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  heightSizer(1,
                                                                      context),
                                                              horizontal:
                                                                  widthSizer(14,
                                                                      context)),

                                                      filled: true,
                                                      isDense: true,
                                                      //contentPadding: EdgeInsets.zero,
                                                      fillColor: Colors.white,
                                                      hintText: '8100000000',
                                                      errorMaxLines: 2,
                                                      counterText: "",
                                                      hintStyle: TextStyle(
                                                          height: 1.5,
                                                          color: AppColors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: widthSizer(
                                                              20, context)),
                                                      prefixIcon: Padding(
                                                          padding: EdgeInsets.only(
                                                              top: heightSizer(
                                                                  3, context),
                                                              bottom:
                                                                  heightSizer(3,
                                                                      context),
                                                              left: widthSizer(
                                                                  5, context),
                                                              right: widthSizer(
                                                                  5, context)),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              // showCountryPickerDialog(),
                                                              // showCountryPicker(
                                                              //   context: context,
                                                              //   countryFilter: <String>['CD', 'CG', 'KE', 'UG'], // only specific countries
                                                              //   onSelect: (){....},
                                                              // )
                                                              Container(
                                                                child:
                                                                    CountryPickerDropdown(
                                                                        itemFilter: (c) =>
                                                                            [
                                                                              'NG',
                                                                              'GB',
                                                                            ].contains(c
                                                                                .isoCode),
                                                                        initialValue:
                                                                            'NG',
                                                                        itemBuilder:
                                                                            _buildDropdownItem,
                                                                        selectedItemBuilder:
                                                                            _buildSelectedItem,
                                                                        priorityList: [
                                                                          CountryPickerUtils.getCountryByIsoCode(
                                                                              'NG'),
                                                                        ],
                                                                        sortComparator: (Country a, Country b) => a
                                                                            .isoCode
                                                                            .compareTo(b
                                                                                .isoCode),
                                                                        onValuePicked:
                                                                            (f) {
                                                                          setState(
                                                                              () {
                                                                            countryCode =
                                                                                f.phoneCode;
                                                                          });
                                                                          model.setPhoneNumber(
                                                                              phoneNumber: "+" + countryCode + model.sanitizePhoneNumberInput(controller.text));
                                                                        }),
                                                              ),
                                                            ],
                                                          )),
                                                      //  filled: true,
                                                    ),
                                                    validator: (val) {
                                                      if (val!.length == 0) {
                                                        return 'Phone number' +
                                                            " is required";
                                                      } else if (val.length ==
                                                              10 &&
                                                          controller.text
                                                              .startsWith(
                                                                  '0')) {
                                                        return 'Enter a valid phone number';
                                                      } else if (val.length !=
                                                              11 &&
                                                          controller.text
                                                              .startsWith(
                                                                  '0')) {
                                                        return 'Enter a valid phone number';
                                                      } else if (val.length <
                                                          10) {
                                                        return 'Enter a valid phone number';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                  )),
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
                                                          : Icons
                                                              .visibility_off,
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
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                cursorColor: Colors.black,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                validator: (val) {
                                                  if (val !=
                                                      passwordController.text) {
                                                    return 'Passwords do not match';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                controller:
                                                    confirmPasswordController,
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      passwordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
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
                                                obscureText: passwordVisible,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                cursorColor: Colors.black,
                                              ),
                                            ]))),
                                const SizedBox(
                                  height: 10,
                                ),
                                BaseButton(
                                  isBusy: model.busy("Register"),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        passwordController.text ==
                                            confirmPasswordController.text) {
                                      model.newSignUp(
                                          SignUpModel(
                                              fullname: fullNameController.text,
                                              email: emailController.text,
                                              phoneNumber: model.phoneNumber,
                                              password:
                                                  passwordController.text),
                                          context);
                                    }
                                  },
                                  label: 'Register',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have an account? "),
                                    GestureDetector(
                                        onTap: () => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login())),
                                        child: Text(" Log In",
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    AppColors.primaryColor))),
                                  ],
                                )
                              ],
                            ))),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )));
        });
  }
}

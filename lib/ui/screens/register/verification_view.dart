import 'dart:async';

import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/register/register_view_model.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/ui/widget/pin_text_input.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';

class VerificationView extends StatefulWidget {
  final String phoneNumber;

  const VerificationView({required this.phoneNumber, Key? key})
      : super(key: key);

  @override
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final NavService _navigationService = locator<NavService>();
  final Authentication _authentication = locator<Authentication>();
  final RegisterViewModel model = RegisterViewModel();
  int time = 60;
  late Timer _timer;
  String phoneNumber = '';

  String verification = '';
  final TextEditingController _pinEditingController = TextEditingController();

  @override
  void initState() {
    startTimer();
    phoneNumber = widget.phoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pinEditingController.dispose();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == 0) {
          setState(() {
            _timer.cancel();
          });
        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  Container line = Container(color: const Color(0xffb5b5b5), height: 0.5);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        //onModelReady: (model) => model.phoneNumber(),
        builder: (context, model, child) => SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Verify your number',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 67,
                            ),
                            const Text(
                              'We sent a verification code to ',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  phoneNumber,
                                  //"09000000",
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () {
                                          // model.navigateToWelcome();
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.red,
                                        ))),
                              ],
                            ),
                            const SizedBox(height: 29),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Center(
                                child: PinTextInput(
                                  pinEditingController: _pinEditingController,
                                  onChanged: (text) {
                                    print(text);
                                    setState(() {
                                      verification = text;
                                    });
                                  },
                                  onSaved: () {},
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 74,
                            ),
                            Container(
                                padding: EdgeInsets.all(20),
                                child: GeneralButton(
                                  buttonText: 'Verify',
                                  onPressed: () {
                                    // _navigationService.navigateTo(registerRoute);
                                    if (_pinEditingController.text.length ==
                                        5) {
                                      // model.verifyOTP(
                                      //     VerifyPayload(
                                      //       userId: _authentication.userId,
                                      //       code:  _pinEditingController.text,
                                      //       username: phoneNumber,
                                      //       actionType: 1
                                      //     ));
                                    }
                                  },
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Didn\'t receive code?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                resendCodeTimer(),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ))));
  }

  Widget resendCodeTimer() {
    return AnimatedCrossFade(
        firstChild: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Resend in ',
              style: const TextStyle(color: AppColors.grey, fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                  text: time.toString(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                const TextSpan(
                  text: ' secs',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ]),
        ),
        secondChild: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () async {
                  //   model.resendVerifyOTP(
                  // phoneNumber);
                  setState(() {
                    time = 60;
                  });
                  return startTimer();
                },
                child: const Text('Resend Code',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)))),
        crossFadeState:
            time > 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 100));
  }
}

import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:equipro/utils/colors.dart';

class PinTextInput extends StatelessWidget {
  final Function onChanged;
  final Function onSaved;
  final TextEditingController pinEditingController;
  const PinTextInput(
      {Key? key,
      required this.onChanged,
      required this.onSaved,
      required this.pinEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinInputTextFormField(
      //        key: _formKey,

      pinLength: 5,
      decoration: BoxLooseDecoration(
          strokeColorBuilder:
              PinListenColorBuilder(AppColors.grey, AppColors.grey),
          bgColorBuilder: PinListenColorBuilder(Colors.white, Colors.white),
          obscureStyle: ObscureStyle(
            isTextObscure: false,
            obscureText: '-',
          ),
          hintText: '*****',
          hintTextStyle: const TextStyle(
            color: Color(0xffE6E9ED),
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          textStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 30,
          )),
      controller: pinEditingController,
      textInputAction: TextInputAction.go,
      enabled: true,
      keyboardType: TextInputType.number,
      // onSubmit: (pin) {
      //   if (_formKey.currentState.validate()) {
      //     _formKey.currentState.save();
      //   }
      // },
      //onChanged:  onChanged,
      onSaved: (pin) {
        debugPrint('onSaved pin:$pin');
      },
      // validator: (pin) {
      //   if (pin.isEmpty) {
      //     setState(() {
      //       _hasError = true;
      //     });
      //     return 'Pin cannot empty.';
      //   }
      //   setState(() {
      //     _hasError = false;
      //   });
      //   return null;
      // },
      cursor: Cursor(
        height: 2,
        width: 20,
        color: AppColors.primaryColor,
        radius: const Radius.circular(1),
        enabled: true,
      ),
    );
  }
}

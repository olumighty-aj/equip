import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';

class PhoneNoTextInput extends StatefulWidget {
  final String? hintText;
  final Function? onSaved;
  final Function(Country)? onCountryChange;
  const PhoneNoTextInput(
      {Key? key, this.hintText, this.onSaved, this.onCountryChange})
      : super(key: key);

  @override
  _PhoneNoTextInputState createState() => _PhoneNoTextInputState();
}

class _PhoneNoTextInputState extends State<PhoneNoTextInput> {
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
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        maxLength = controller.text.startsWith('0') ? 11 : 10;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.center,
          onSaved: (d) {
            widget.onSaved!;
            print(   widget.onSaved!);
          },
          maxLength: maxLength,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: widthSizer(16.0, context)),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: heightSizer(1, context),
                horizontal: widthSizer(14, context)),

            filled: true,
            isDense: true,
            //contentPadding: EdgeInsets.zero,
            fillColor: Colors.white,
            hintText: widget.hintText ?? '8100000000',
            errorMaxLines: 2,
            counterText: "",
            hintStyle: TextStyle(
                height: 1.5,
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
                fontSize: widthSizer(20, context)),

            // focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10),
            //   borderSide: BorderSide(
            //     width: 0.5,
            //     color: redColor,
            //   ),
            // ),

            prefixIcon: Padding(
                padding: EdgeInsets.only(
                    top: heightSizer(3, context),
                    bottom: heightSizer(3, context),
                    left: widthSizer(5, context),
                    right: widthSizer(5, context)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      //width: widthSizer(120, context),
                      //height: heightSizer(16, context),
                      child: CountryPickerDropdown(
                          initialValue: 'NG',
                          itemBuilder: _buildDropdownItem,
                          selectedItemBuilder: _buildSelectedItem,
                          priorityList: [
                            CountryPickerUtils.getCountryByIsoCode('NG'),
                          ],
                          sortComparator: (Country a, Country b) =>
                              a.isoCode.compareTo(b.isoCode),
                          onValuePicked: (f) {
                            widget.onCountryChange;
                          }),
                    ),
                  ],
                )),
            //  filled: true,
          ),
          validator: (val) {
            if (val!.length == 0) {
              return widget.hintText ?? 'Phone number' + " is required";
            } else if (val.length == 10 && controller.text.startsWith('0')) {
              return 'Enter a valid phone number';
            } else if (val.length != 11 && controller.text.startsWith('0')) {
              return 'Enter a valid phone number';
            } else if (val.length < 10) {
              return 'Enter a valid phone number';
            } else {
              return null;
            }
          },
        ));
  }
}

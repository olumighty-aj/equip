import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../utils/colors.dart';

class LoadingDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const LoadingDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 70,
                width: 70,
                child: const CircularProgressIndicator(
                  strokeWidth: 4,
                  backgroundColor: AppColors.primaryColor,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                width: 60,
                height: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

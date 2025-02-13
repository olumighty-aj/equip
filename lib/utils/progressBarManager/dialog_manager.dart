import 'package:equipro/utils/busy_dialog.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/progressBarManager/dialog_models.dart';
import 'package:equipro/utils/progressBarManager/dialog_service.dart';
import 'package:flutter/material.dart';

class ProgressManager extends StatefulWidget {
  final Widget child;
  const ProgressManager({required this.child});

  _ProgressManagerState createState() => _ProgressManagerState();
}

class _ProgressManagerState extends State<ProgressManager> {
  final ProgressService _progressService = locator<ProgressService>();

  @override
  void initState() {
    super.initState();
    _progressService.registerProgressListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
  // Future getFuture() {
  //   return Future(() async {
  //     await Future.delayed(const Duration(seconds: 10));
  //     return 'Hello, Future Progress Dialog!';
  //   });
  // }

  //
  void _showDialog(ProgressRequest request) async {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        dismissable: false,
        // backgroundColor: const Color(0x33000000),
        animationDuration: const Duration(milliseconds: 500),
        loadingWidget: Material(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                const Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 60,
                  height: 60,
                ),
              ],
            ),
          ),
        ));

    progressDialog.show(); // show dialog
    //progressDialog.dismiss();
    print('show');
  }
}

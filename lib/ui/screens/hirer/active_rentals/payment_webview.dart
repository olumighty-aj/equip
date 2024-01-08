import 'package:equipro/app/app_setup.router.dart';
import 'package:equipro/core/enums/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../app/app_setup.locator.dart';
import '../../../../app/app_setup.logger.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  final String amount;
  // final String owner;
  const PaymentWebView({Key? key, required this.url, required this.amount})
      : super(key: key);

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  WebViewController? _controller;

  @override
  void initState() {
    _controller = WebViewController();
    // TODO: implement initState
    initControllerDetails();
    // _controller.platform = PlatformWebViewController.
    super.initState();
  }

  void initControllerDetails() {
    _controller!.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller!.loadRequest(Uri.parse(widget.url));
    _controller!.setNavigationDelegate(NavigationDelegate(
        //   onPageFinished: (url) {

        onNavigationRequest: (url) {
      getLogger("WebView").i("Url: ${url.url}");
      if (url.url.contains("success")) {
        // Navigator.pop(context);
        locator<DialogService>().showCustomDialog(
            variant: DialogType.paymentSuccessful,
            data: {"amount": widget.amount});
        Future.delayed(Duration(seconds: 3)).then((value) =>
            locator<NavigationService>().clearTillFirstAndShow(Routes.rentals));
      }
      return NavigationDecision.navigate;
    }
        // }
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Payment"),
        ),
        body: WebViewWidget(
          controller: _controller!,
        ));
  }
}

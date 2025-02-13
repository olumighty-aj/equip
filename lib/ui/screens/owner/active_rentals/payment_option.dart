import 'package:equipro/core/model/ActiveRentalsModel.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rentals_view_model.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/model/active_rentals/active_rentals.dart';
import '../../../../utils/app_svgs.dart';

class PaymentOptionScreen extends StatelessWidget {
  final ActiveRentalsModel feed;
  const PaymentOptionScreen({Key? key, required this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Select Payment"),
        ),
        body: ViewModelBuilder<RentalsViewModel>.reactive(
            viewModelBuilder: () => RentalsViewModel(),
            builder: (context, model, _) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (!model.isNigerian)
                      ListTile(
                        onTap: () {
                          var totalAmount =
                              double.parse(feed.equip_order!.service_charge!) +
                                  double.parse(feed.equip_order!.total_amount!);
                          model.initPayment(
                              feed.equip_order_id!,
                              totalAmount.toString(),
                              "paypal",
                              "gbp",
                              PaymentType.paypal);
                        },
                        leading: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: SvgPicture.asset(AppSvgs.paypal),
                        ),
                        title: Text("Paypal"),
                        trailing: model.busy("PaypalInitPayment")
                            ? SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 2,
                                ))
                            : null,
                      ),
                    Divider(color: Colors.grey),
                    ListTile(
                      onTap: () {
                        var totalAmount =
                            double.parse(feed.equip_order!.service_charge!) +
                                double.parse(feed.equip_order!.total_amount!);
                        model.initPayment(
                            feed.equip_order_id!,
                            totalAmount.toString(),
                            "stripe",
                            model.isNigerian ? "ngn" : "gbp",
                            PaymentType.stripe);
                      },

                      leading: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(AppSvgs.stripe),
                      ),

                      // CircleAvatar(
                      //   backgroundColor: Colors.white,

                      // ),
                      title: Text("Stripe"),
                      trailing: model.busy("StripeInitPayment")
                          ? SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                                strokeWidth: 2,
                              ))
                          : null,
                    ),
                    Divider(color: Colors.grey)
                  ],
                ),
              );
            }));
  }
}

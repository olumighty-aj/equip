import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/ui/screens/chat/chat.dart';
import 'package:equipro/ui/screens/chat/chats_widget/chat_details.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/active_rentals.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rating.dart';
import 'package:equipro/ui/screens/hirer/active_rentals/rentals_details.dart';
import 'package:equipro/ui/screens/hirer/book/equip_details.dart';
import 'package:equipro/ui/screens/hirer/book/place_booking.dart';
import 'package:equipro/ui/screens/hirer/home/home_view.dart';
import 'package:equipro/ui/screens/login/verify_forgot_otp.dart';
import 'package:equipro/ui/screens/notification/notification.dart';
import 'package:equipro/ui/screens/owner/earnings/earning_page.dart';
import 'package:equipro/ui/screens/owner/earnings/withdraw.dart';
import 'package:equipro/ui/screens/owner/home_owner/booking_details.dart';
import 'package:equipro/ui/screens/owner/home_owner/edit_equipment.dart';
import 'package:equipro/ui/screens/owner/home_owner/equip_owner_details.dart';
import 'package:equipro/ui/screens/owner/home_owner/hirer_profile.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_owner.dart';
import 'package:equipro/ui/screens/owner/home_owner/post_equipment.dart';
import 'package:equipro/ui/screens/owner/home_owner/post_equipment_final.dart';
import 'package:equipro/ui/screens/owner/setup_owner.dart';
import 'package:equipro/ui/screens/profile/edit_profile.dart';
import 'package:equipro/ui/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:equipro/ui/screens/login/login_view.dart';
import 'package:equipro/ui/screens/login/forgot_password.dart';
import 'package:equipro/ui/screens/onboarding/onboardingscreen_view.dart';
import 'package:equipro/ui/screens/register/register_view.dart';
import 'package:equipro/ui/screens/register/verification_view.dart';
import 'package:equipro/utils/router/route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Login(),
      );
    case registerRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Register(),
      );

    case verificationViewRoute:
      String phoneNumber = settings.arguments as String;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: VerificationView(
          phoneNumber: phoneNumber,
        ),
      );

    case forgotPasswordRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ForgotPasswordPage(),
      );
    case VerifyForgotPasswordPageRoute:
      var email = settings.arguments as String;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: VerifyForgotPasswordPage(
          email: email,
        ),
      );

    case OnBoardingScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: OnboardingScreen(),
      );

    case homeRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Home(),
      );
    case EquipDetailsRoute:
      EquipmentModel model = settings.arguments as EquipmentModel;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: EquipDetails(model: model,),
      );
    case PlaceBookingRoute:
      EquipmentModel model = settings.arguments as EquipmentModel;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: PlaceBooking(model: model,),
      );
    case chatDetailsPageRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ChatDetailsPage(),
      );

    case chatRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Chat(),
      );

    case ProfileRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Profile(),
      );

    case EditProfileRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: EditProfile(),
      );

    case NotificationRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: NotificationPage(),
      );

    case RentalsRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Rentals(),
      );
    case RentalDetailsRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: RentalDetails(),
      );

    case RatingRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Rating(),
      );

    case SetupOwnerRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SetupOwner(),
      );

    case HomeOwnerRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: HomeOwner(),
      );
    case PostEquipmentRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: PostEquipment(),
      );
    case PostEquipmentFinalRoute:
      Map<String, dynamic> argss = settings.arguments as Map<String, dynamic>;
      String equipName = argss['equipName'];
      List images = argss['images'];
      String description = argss['description'];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: PostEquipmentFinal(
          equipName: equipName,
          images: images,
          description: description,
        ),
      );
    case EquipOwnerDetailsRoute:
      EquipmentModel model = settings.arguments as EquipmentModel;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: EquipOwnerDetails(model: model),
      );
    case BookingDetailsRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: BookingDetails(),
      );

    case HirerProfileRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: HirerProfile(),
      );

    case EditEquipmentRoute:
      EquipmentModel model = settings.arguments as EquipmentModel;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: EditEquipment(model: model,),
      );
    case EarningPageRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: EarningPage(),
      );

    case WithdrawRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: Withdraw(),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute(
    {required String routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

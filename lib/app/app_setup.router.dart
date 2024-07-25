// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:equipro/core/model/equipments/equipments.dart' as _i19;
import 'package:equipro/ui/screens/hirer/active_rentals/active_rentals.dart'
    as _i11;
import 'package:equipro/ui/screens/hirer/active_rentals/payment_webview.dart'
    as _i14;
import 'package:equipro/ui/screens/hirer/book/equip_details.dart' as _i9;
import 'package:equipro/ui/screens/hirer/home/home_view.dart' as _i8;
import 'package:equipro/ui/screens/login/forgt_password/forgot_password.dart'
    as _i6;
import 'package:equipro/ui/screens/login/forgt_password/verify_forgot_otp.dart'
    as _i5;
import 'package:equipro/ui/screens/login/login_view.dart' as _i4;
import 'package:equipro/ui/screens/onboarding/onboardingscreen_view.dart'
    as _i2;
import 'package:equipro/ui/screens/owner/home_owner/booking_details.dart'
    as _i12;
import 'package:equipro/ui/screens/owner/home_owner/equip_owner_details.dart'
    as _i13;
import 'package:equipro/ui/screens/owner/home_owner/home_owner.dart' as _i7;
import 'package:equipro/ui/screens/profile/edit_profile.dart' as _i15;
import 'package:equipro/ui/screens/profile/profile.dart' as _i16;
import 'package:equipro/ui/screens/splashscreen.dart' as _i3;
import 'package:flutter/foundation.dart' as _i18;
import 'package:flutter/material.dart' as _i17;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i20;
import 'package:place_picker/entities/localization_item.dart' as _i21;
import 'package:place_picker/widgets/place_picker.dart' as _i10;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i22;

class Routes {
  static const onboardingScreen = '/onboarding-screen';

  static const animatedSplashScreen = '/animated-splash-screen';

  static const login = '/Login';

  static const verifyForgotPasswordPage = '/verify-forgot-password-page';

  static const forgotPasswordPage = '/forgot-password-page';

  static const homeOwner = '/home-owner';

  static const home = '/Home';

  static const equipDetails = '/equip-details';

  static const placePicker = '/place-picker';

  static const rentals = '/Rentals';

  static const bookingDetails = '/booking-details';

  static const equipOwnerDetails = '/equip-owner-details';

  static const paymentWebView = '/payment-web-view';

  static const editProfile = '/edit-profile';

  static const profile = '/Profile';

  static const all = <String>{
    onboardingScreen,
    animatedSplashScreen,
    login,
    verifyForgotPasswordPage,
    forgotPasswordPage,
    homeOwner,
    home,
    equipDetails,
    placePicker,
    rentals,
    bookingDetails,
    equipOwnerDetails,
    paymentWebView,
    editProfile,
    profile,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.onboardingScreen,
      page: _i2.OnboardingScreen,
    ),
    _i1.RouteDef(
      Routes.animatedSplashScreen,
      page: _i3.AnimatedSplashScreen,
    ),
    _i1.RouteDef(
      Routes.login,
      page: _i4.Login,
    ),
    _i1.RouteDef(
      Routes.verifyForgotPasswordPage,
      page: _i5.VerifyForgotPasswordPage,
    ),
    _i1.RouteDef(
      Routes.forgotPasswordPage,
      page: _i6.ForgotPasswordPage,
    ),
    _i1.RouteDef(
      Routes.homeOwner,
      page: _i7.HomeOwner,
    ),
    _i1.RouteDef(
      Routes.home,
      page: _i8.Home,
    ),
    _i1.RouteDef(
      Routes.equipDetails,
      page: _i9.EquipDetails,
    ),
    _i1.RouteDef(
      Routes.placePicker,
      page: _i10.PlacePicker,
    ),
    _i1.RouteDef(
      Routes.rentals,
      page: _i11.Rentals,
    ),
    _i1.RouteDef(
      Routes.bookingDetails,
      page: _i12.BookingDetails,
    ),
    _i1.RouteDef(
      Routes.equipOwnerDetails,
      page: _i13.EquipOwnerDetails,
    ),
    _i1.RouteDef(
      Routes.paymentWebView,
      page: _i14.PaymentWebView,
    ),
    _i1.RouteDef(
      Routes.editProfile,
      page: _i15.EditProfile,
    ),
    _i1.RouteDef(
      Routes.profile,
      page: _i16.Profile,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.OnboardingScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.OnboardingScreen(),
        settings: data,
      );
    },
    _i3.AnimatedSplashScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.AnimatedSplashScreen(),
        settings: data,
      );
    },
    _i4.Login: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.Login(),
        settings: data,
      );
    },
    _i5.VerifyForgotPasswordPage: (data) {
      final args =
          data.getArgs<VerifyForgotPasswordPageArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.VerifyForgotPasswordPage(key: args.key, email: args.email),
        settings: data,
      );
    },
    _i6.ForgotPasswordPage: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ForgotPasswordPage(),
        settings: data,
      );
    },
    _i7.HomeOwner: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.HomeOwner(),
        settings: data,
      );
    },
    _i8.Home: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.Home(),
        settings: data,
      );
    },
    _i9.EquipDetails: (data) {
      final args = data.getArgs<EquipDetailsArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i9.EquipDetails(key: args.key, model: args.model),
        settings: data,
      );
    },
    _i10.PlacePicker: (data) {
      final args = data.getArgs<PlacePickerArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.PlacePicker(args.apiKey,
            displayLocation: args.displayLocation,
            localizationItem: args.localizationItem),
        settings: data,
      );
    },
    _i11.Rentals: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.Rentals(),
        settings: data,
      );
    },
    _i12.BookingDetails: (data) {
      final args = data.getArgs<BookingDetailsArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.BookingDetails(
            key: args.key, feed: args.feed, model: args.model),
        settings: data,
      );
    },
    _i13.EquipOwnerDetails: (data) {
      final args = data.getArgs<EquipOwnerDetailsArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i13.EquipOwnerDetails(key: args.key, model: args.model),
        settings: data,
      );
    },
    _i14.PaymentWebView: (data) {
      final args = data.getArgs<PaymentWebViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.PaymentWebView(
            key: args.key, url: args.url, amount: args.amount),
        settings: data,
      );
    },
    _i15.EditProfile: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.EditProfile(),
        settings: data,
      );
    },
    _i16.Profile: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.Profile(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class VerifyForgotPasswordPageArguments {
  const VerifyForgotPasswordPageArguments({
    this.key,
    required this.email,
  });

  final _i18.Key? key;

  final String email;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email"}';
  }

  @override
  bool operator ==(covariant VerifyForgotPasswordPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.email == email;
  }

  @override
  int get hashCode {
    return key.hashCode ^ email.hashCode;
  }
}

class EquipDetailsArguments {
  const EquipDetailsArguments({
    this.key,
    required this.model,
  });

  final _i18.Key? key;

  final _i19.EquipmentModel model;

  @override
  String toString() {
    return '{"key": "$key", "model": "$model"}';
  }

  @override
  bool operator ==(covariant EquipDetailsArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.model == model;
  }

  @override
  int get hashCode {
    return key.hashCode ^ model.hashCode;
  }
}

class PlacePickerArguments {
  const PlacePickerArguments({
    required this.apiKey,
    this.displayLocation,
    this.localizationItem,
  });

  final String apiKey;

  final _i20.LatLng? displayLocation;

  final _i21.LocalizationItem? localizationItem;

  @override
  String toString() {
    return '{"apiKey": "$apiKey", "displayLocation": "$displayLocation", "localizationItem": "$localizationItem"}';
  }

  @override
  bool operator ==(covariant PlacePickerArguments other) {
    if (identical(this, other)) return true;
    return other.apiKey == apiKey &&
        other.displayLocation == displayLocation &&
        other.localizationItem == localizationItem;
  }

  @override
  int get hashCode {
    return apiKey.hashCode ^
        displayLocation.hashCode ^
        localizationItem.hashCode;
  }
}

class BookingDetailsArguments {
  const BookingDetailsArguments({
    this.key,
    required this.feed,
    required this.model,
  });

  final _i18.Key? key;

  final Map<String, dynamic> feed;

  final _i19.EquipmentModel model;

  @override
  String toString() {
    return '{"key": "$key", "feed": "$feed", "model": "$model"}';
  }

  @override
  bool operator ==(covariant BookingDetailsArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.feed == feed && other.model == model;
  }

  @override
  int get hashCode {
    return key.hashCode ^ feed.hashCode ^ model.hashCode;
  }
}

class EquipOwnerDetailsArguments {
  const EquipOwnerDetailsArguments({
    this.key,
    required this.model,
  });

  final _i18.Key? key;

  final _i19.EquipmentModel model;

  @override
  String toString() {
    return '{"key": "$key", "model": "$model"}';
  }

  @override
  bool operator ==(covariant EquipOwnerDetailsArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.model == model;
  }

  @override
  int get hashCode {
    return key.hashCode ^ model.hashCode;
  }
}

class PaymentWebViewArguments {
  const PaymentWebViewArguments({
    this.key,
    required this.url,
    required this.amount,
  });

  final _i18.Key? key;

  final String url;

  final String amount;

  @override
  String toString() {
    return '{"key": "$key", "url": "$url", "amount": "$amount"}';
  }

  @override
  bool operator ==(covariant PaymentWebViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.url == url && other.amount == amount;
  }

  @override
  int get hashCode {
    return key.hashCode ^ url.hashCode ^ amount.hashCode;
  }
}

extension NavigatorStateExtension on _i22.NavigationService {
  Future<dynamic> navigateToOnboardingScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAnimatedSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.animatedSplashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLogin([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.login,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerifyForgotPasswordPage({
    _i18.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.verifyForgotPasswordPage,
        arguments: VerifyForgotPasswordPageArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotPasswordPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forgotPasswordPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeOwner([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeOwner,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHome([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.home,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEquipDetails({
    _i18.Key? key,
    required _i19.EquipmentModel model,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.equipDetails,
        arguments: EquipDetailsArguments(key: key, model: model),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPlacePicker({
    required String apiKey,
    _i20.LatLng? displayLocation,
    _i21.LocalizationItem? localizationItem,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.placePicker,
        arguments: PlacePickerArguments(
            apiKey: apiKey,
            displayLocation: displayLocation,
            localizationItem: localizationItem),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRentals([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.rentals,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBookingDetails({
    _i18.Key? key,
    required Map<String, dynamic> feed,
    required _i19.EquipmentModel model,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bookingDetails,
        arguments: BookingDetailsArguments(key: key, feed: feed, model: model),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEquipOwnerDetails({
    _i18.Key? key,
    required _i19.EquipmentModel model,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.equipOwnerDetails,
        arguments: EquipOwnerDetailsArguments(key: key, model: model),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPaymentWebView({
    _i18.Key? key,
    required String url,
    required String amount,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.paymentWebView,
        arguments: PaymentWebViewArguments(key: key, url: url, amount: amount),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditProfile([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editProfile,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfile([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profile,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAnimatedSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.animatedSplashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLogin([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.login,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVerifyForgotPasswordPage({
    _i18.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.verifyForgotPasswordPage,
        arguments: VerifyForgotPasswordPageArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgotPasswordPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.forgotPasswordPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeOwner([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeOwner,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHome([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.home,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEquipDetails({
    _i18.Key? key,
    required _i19.EquipmentModel model,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.equipDetails,
        arguments: EquipDetailsArguments(key: key, model: model),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPlacePicker({
    required String apiKey,
    _i20.LatLng? displayLocation,
    _i21.LocalizationItem? localizationItem,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.placePicker,
        arguments: PlacePickerArguments(
            apiKey: apiKey,
            displayLocation: displayLocation,
            localizationItem: localizationItem),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRentals([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.rentals,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBookingDetails({
    _i18.Key? key,
    required Map<String, dynamic> feed,
    required _i19.EquipmentModel model,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bookingDetails,
        arguments: BookingDetailsArguments(key: key, feed: feed, model: model),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEquipOwnerDetails({
    _i18.Key? key,
    required _i19.EquipmentModel model,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.equipOwnerDetails,
        arguments: EquipOwnerDetailsArguments(key: key, model: model),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPaymentWebView({
    _i18.Key? key,
    required String url,
    required String amount,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.paymentWebView,
        arguments: PaymentWebViewArguments(key: key, url: url, amount: amount),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditProfile([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editProfile,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfile([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profile,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}

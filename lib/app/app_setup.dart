import 'package:equipro/core/model/VerifyForgotPassword.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/core/services/payment_services.dart';
import 'package:equipro/ui/screens/hirer/home/home_view.dart';
import 'package:equipro/utils/progressBarManager/dialog_service.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../core/api/dio_service.dart';
import '../ui/screens/hirer/book/equip_details.dart';
import '../ui/screens/login/forgt_password/forgot_password.dart';
import '../ui/screens/login/forgt_password/verify_forgot_otp.dart';
import '../ui/screens/login/login_view.dart';
import '../ui/screens/onboarding/onboardingscreen_view.dart';
import '../ui/screens/owner/home_owner/booking_details.dart';
import '../ui/screens/owner/home_owner/equip_owner_details.dart';
import '../ui/screens/owner/home_owner/home_owner.dart';
import '../ui/screens/splashscreen.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: OnboardingScreen),
    MaterialRoute(page: AnimatedSplashScreen),
    MaterialRoute(
      page: Login,
    ),
    MaterialRoute(
      page: VerifyForgotPasswordPage,
    ),
    MaterialRoute(
      page: ForgotPasswordPage,
    ),
    MaterialRoute(
      page: HomeOwner,
    ),
    MaterialRoute(
      page: EquipOwnerDetails,
    ),
    MaterialRoute(
      page: Home,
    ),
    MaterialRoute(
      page: EquipDetails,
    ),
    MaterialRoute(
      page: PlacePicker,
    ),
    MaterialRoute(
      page: BookingDetails,
    ),
    MaterialRoute(
      page: EquipOwnerDetails,
    ),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: NavService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: Activities),
    LazySingleton(classType: Authentication),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: ProgressService),
    LazySingleton(classType: PaymentService),
  ],
  logger: StackedLogger(),
)
class $AppSetup {}

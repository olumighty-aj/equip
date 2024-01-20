import 'dart:async';
import 'dart:convert';

import 'package:equipro/app/app.dart';
import 'package:equipro/core/api/api_constants.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/core/services/shared_prefs.dart';
import 'package:equipro/ui/screens/login/login_view.dart';
import 'package:equipro/ui/screens/notification/notification.dart';
import 'package:equipro/ui/screens/onboarding/onboardingscreen_view.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/theme_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:equipro/ui/screens/splashscreen.dart';
import 'package:equipro/utils/progressBarManager/dialog_manager.dart';
import 'package:equipro/utils/progressBarManager/dialog_service.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'app/app_setup.router.dart';

late BuildContext contextB;
void main() async {
  await App.initialize();
  bool userExists = await App.checkIfUserIsNew();
  runApp(MyApp(
    isNewUser: !userExists,
  ));
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  final bool isNewUser;
  const MyApp({Key? key, required this.isNewUser}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _rootTimer;

  void initializeTimer() {
    var time = const Duration(minutes: 31);
    _rootTimer = Timer(time, () async {
      logOutUser();
    });
  }

  void initState() {
    // checkIfUserIsNew();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new DarwinInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: onSelectNotification
    );
    // TODO: implement initState
  }

  void logOutUser() async {
    // Log out the user if they're logged in, then cancel the timer.
    await locator<Authentication>().logout().then((value) {
      if (value == true) {
        _rootTimer?.cancel();
        SharedPrefsClient.deleteData("loginDetails");
        locator<NavigationService>().clearStackAndShow(Routes.login);
      }
    });
  }

  void handleUserInteraction([_]) {
    if (_rootTimer != null && !_rootTimer!.isActive) {
      // This means the user has been logged out
      return;
    }
    print(_rootTimer?.tick);
    _rootTimer?.cancel();
    initializeTimer();
  }

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //     providers: [
    //     ChangeNotifierProvider(create: (context) => AppStateProvider()),
    // ],
    // child:
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: handleUserInteraction,
      onPointerMove: handleUserInteraction,
      onPointerUp: handleUserInteraction,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Equippro',
        navigatorKey: StackedService.navigatorKey,
        home: AnimatedSplashScreen(),
        // initialRoute: initialRoute,
        onGenerateRoute: (settings) {
          print("Route: ${settings.name}");
          return StackedRouter().onGenerateRoute(settings);
        },
        theme: ThemeNotifier().lightTheme,
      ),
    );
  }
}

// void generalPushNotification(String title, String body, String json) {
//   var data = jsonDecode(json);
//   NotificationEntity notificationEntity = NotificationEntity.fromJson(data);
//   if (notificationEntity.active == ActiveStatus.active) {
//     Repository.getInstance().saveNotifications([notificationEntity]);
//     pushNotification(title, body);
//   } else
//     Repository.getInstance().deleteNotice(notificationEntity);
// }
Future<void> messageHandler(RemoteMessage message) async {
  //await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  print('Handling a background message ${message.messageId}');
  print('background message ${message.notification?.body}');
  pushNotification(
      message.notification?.title ?? "", message.notification?.body ?? "");
}

FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    "Equippro", 'Notification',
    channelDescription: 'This is Equippro notification center',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true);
var iOSPlatformChannelSpecifics =
    new DarwinNotificationDetails(presentBadge: true, presentAlert: true);
var platformChannelSpecifics = new NotificationDetails(
    android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

void pushNotification(String title, String body) {
  _flutterLocalNotificationsPlugin.show(
      0, title, body, platformChannelSpecifics);
}

// void selectNotification(String? payload) async {
//   if (payload != null) {
//     debugPrint('notification payload: $payload');
//   }
//   await Navigator.push(
//     context,
//     MaterialPageRoute<void>(builder: (context) => NotificationPage()),
//   );
// }

// var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//     "Equippro", 'Notification',
//     channelDescription: 'This is Equippro notification center',
//     importance: Importance.max,
//     priority: Priority.high,
//     playSound: false,
//     enableVibration: true);
// var iOSPlatformChannelSpecifics =
//     new IOSNotificationDetails(presentBadge: true, presentSound: true);
//
// get platformChannelSpecifics => new NotificationDetails(
//     android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

import 'package:equipro/ui/screens/notification/notification.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:equipro/ui/screens/splashscreen.dart';
import 'package:equipro/utils/progressBarManager/dialog_manager.dart';
import 'package:equipro/utils/progressBarManager/dialog_service.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

late BuildContext contextB;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  Stripe.publishableKey =
    'pk_live_51NEXPyGOYHh4f2GJ0KXCJJQQbWJRfXN1hCQzdrNuAzXOgFZ3bzMzYdMHB8qO8r2ekXUgFy18QlSzNiJ3bLdJxRkW00xzECKDuM';
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  late FirebaseMessaging messaging;

  late AndroidNotificationChannel channel;

  displayDialog(String title, String body) {
    return
    
      showTopSnackBar(
        contextB,
        CustomSnackBar.info(
          backgroundColor: AppColors.primaryColor,
          message:
          "$title\n$body",
        ),
      );
  }
  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => NotificationPage()),
    );
  }

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void registerNotification() async {

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings();
    final MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    // var initializationSettings = InitializationSettings();
    // channel = const AndroidNotificationChannel(
    //   'high_importance_channel', // id
    //   'High Importance Notifications', // title
    //   //'This channel is used for important notifications.', // description
    //   importance: Importance.high,
    // );
    //
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification?.body);
      displayDialog(
          '${event.notification?.title}', '${event.notification?.body}');

      // Get.snackbar('${event.notification.body}', '${event.notification.title}',
      //     backgroundColor: AppColors.secondaryColor);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    //await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
    print('Handling a background message ${message.messageId}');
    print('background message ${message.notification?.body}');
  }

  void initState() {
    // TODO: implement initState
    registerNotification();
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //     providers: [
    //     ChangeNotifierProvider(create: (context) => AppStateProvider()),
    // ],
    // child:
    return
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equipro',
      builder: (context, child) => Navigator(
        key: locator<ProgressService>().progressNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
          return ProgressManager(child: child!);
        }),
      ),
      theme: ThemeData(
backgroundColor: AppColors.backgroundColor,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      home: const AnimatedSplashScreen(),
      onGenerateRoute: generateRoute,
    );
  }
}

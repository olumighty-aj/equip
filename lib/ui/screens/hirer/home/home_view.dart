import 'package:equipro/core/enums/dialog_type.dart';
import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/core/model/enums.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/hirer/home/home_view_model.dart';
import 'package:equipro/ui/screens/notification/notification.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/loader_widget.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:equipro/utils/screensize.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final NavService _navigationService = locator<NavService>();

  late FirebaseMessaging messaging;

  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String searchWord = "";

  LocationData? locationData;

  Location location = Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  Future<LocationData> getUserLocation() async {
    print("ajdjdj");
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        // return null;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print(_permissionGranted);
        //  return null;
      }
      print(_permissionGranted);
    }

    var locationData2 = await location.getLocation();
    print("Location");
    print(locationData);
    //setState(() {
    locationData = locationData2;
    // });
    return locationData!;
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

    displayDialog(String title, String body) {
      return showTopSnackBar(
        context,
        CustomSnackBar.info(
          backgroundColor: AppColors.primaryColor,
          message: "$title\n$body",
        ),
      );
    }

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

  @override
  void initState() {
    super.initState();
    registerNotification();
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        onViewModelReady: (v) async {
          getUserLocation();
        },
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () async {
              var res = await locator<DialogService>()
                  .showCustomDialog(variant: DialogType.exit);
              if (res != null && res.confirmed) {
                return true;
              } else {
                return false;
              }
            },
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () => _scaffoldKey.currentState!.openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "assets/images/hamburger.svg",
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: AnimationLimiter(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: AnimationConfiguration.toStaggeredList(
                                  duration: const Duration(milliseconds: 200),
                                  childAnimationBuilder: (widget) =>
                                      SlideAnimation(
                                        horizontalOffset:
                                            -MediaQuery.of(context).size.width /
                                                4,
                                        child: FadeInAnimation(
                                            curve: Curves.fastOutSlowIn,
                                            child: widget),
                                      ),
                                  children: [
                                    // const SizedBox(
                                    //   height: 60,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     InkWell(
                                    //       onTap: () {
                                    //         _scaffoldKey.currentState!
                                    //             .openDrawer();
                                    //       },
                                    //       child: SvgPicture.asset(
                                    //         "assets/images/hamburger.svg",
                                    //       ),
                                    //     ),
                                    //     const Text(
                                    //       '',
                                    //       style: TextStyle(
                                    //           fontSize: 20,
                                    //           color: AppColors.black,
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 30,
                                    // ),
                                    Row(
                                      children: [
                                        Text(
                                          "Find an ",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "equipment",
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "quickly!",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width:
                                                Responsive.width(context) / 1.3,
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.search_outlined,
                                                  color: AppColors.grey,
                                                  size: 30,
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 20.0),
                                                hintText:
                                                    "Search by location, name of equipment, etc",
                                                hintStyle: TextStyle(
                                                  color: Color(0XFF818181),
                                                  fontSize: 12,
                                                ),
                                                // fillColor: Colors.white,
                                                // filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(30.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(30.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  searchWord = value;
                                                  print(searchWord);
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NotificationPage())),
                                              child: Badge(
                                                label: Text(
                                                  "0",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                child: SvgPicture.asset(
                                                    "assets/images/notification.svg"),
                                              ))
                                        ]),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "EQUIPMENTS LISTING NEAR YOU",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    searchWord.isEmpty
                                        ? Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6,
                                            child: ViewModelBuilder<
                                                    HomeViewModel>.reactive(
                                                viewModelBuilder: () =>
                                                    HomeViewModel(),
                                                onViewModelReady: (vm) {
                                                  vm.getEquipment(
                                                      locationData != null
                                                          ? locationData!
                                                              .latitude
                                                              .toString()
                                                          : "6.4478",
                                                      locationData != null
                                                          ? locationData!
                                                              .longitude
                                                              .toString()
                                                          : "3.4723");
                                                  vm.controller =
                                                      new ScrollController()
                                                        ..addListener(() {
                                                          vm.getEquipmentMore(
                                                              //  "6.4478", "3.4723"
                                                              locationData!
                                                                  .latitude
                                                                  .toString(),
                                                              locationData!
                                                                  .longitude
                                                                  .toString());
                                                        });
                                                },
                                                builder: (context, v, child) {
                                                  if (v.fetchState ==
                                                      LoadingState.loading) {
                                                    return Container(
                                                        height: 400,
                                                        padding: EdgeInsets.all(
                                                            20.0),
                                                        child: Center(
                                                          child: Shimmer
                                                              .fromColors(
                                                                  direction:
                                                                      ShimmerDirection
                                                                          .ltr,
                                                                  period: Duration(
                                                                      seconds:
                                                                          2),
                                                                  child:
                                                                      ListView(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    // shrinkWrap: true,
                                                                    children: [
                                                                      0,
                                                                      1,
                                                                      2,
                                                                      3
                                                                    ]
                                                                        .map((_) =>
                                                                            LoaderWidget())
                                                                        .toList(),
                                                                  ),
                                                                  baseColor:
                                                                      AppColors
                                                                          .white,
                                                                  highlightColor:
                                                                      AppColors
                                                                          .grey),
                                                        ));
                                                  } else if (v.fetchState ==
                                                      LoadingState.done) {
                                                    if (v.packageList
                                                        .isNotEmpty) {
                                                      return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          controller:
                                                              v.controller,
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          // shrinkWrap: true,
                                                          child: Column(
                                                            children: [
                                                              Column(
                                                                  children: v
                                                                      .packageList
                                                                      .map((feed) =>
                                                                          EquipTiles(
                                                                              model: feed))
                                                                      .toList()),
                                                              SizedBox(
                                                                  height: 20),
                                                              v.loadingState ==
                                                                      LoadingState
                                                                          .loading
                                                                  ? Container(
                                                                      height:
                                                                          400,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              20.0),
                                                                      child:
                                                                          Center(
                                                                        child: Shimmer.fromColors(
                                                                            direction: ShimmerDirection.ltr,
                                                                            period: Duration(seconds: 2),
                                                                            child: ListView(
                                                                              scrollDirection: Axis.vertical,
                                                                              // shrinkWrap: true,
                                                                              children: [
                                                                                0,
                                                                                1,
                                                                              ].map((_) => LoaderWidget()).toList(),
                                                                            ),
                                                                            baseColor: AppColors.white,
                                                                            highlightColor: AppColors.grey),
                                                                      ))
                                                                  : SizedBox(
                                                                      height: 1)
                                                            ],
                                                          ));
                                                    } else {
                                                      return Center(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "No equipment near you yet",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .primaryColor),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "Kindly check later",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .primaryColor),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                        ],
                                                      ));
                                                    }
                                                  } else {
                                                    return Center(
                                                        child: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 100,
                                                        ),
                                                        Text(
                                                          'Network error',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text('Network error'),
                                                        SizedBox(
                                                          height: 100,
                                                        ),
                                                      ],
                                                    ));
                                                  }
                                                }),
                                          )
                                        : Container(
                                            height:
                                                Responsive.height(context) / 2,
                                            child: FutureBuilder<
                                                    List<EquipmentModel>>(
                                                future: model.searchEquipments(
                                                    searchWord),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return Container(
                                                        height: 400,
                                                        padding: EdgeInsets.all(
                                                            20.0),
                                                        child: Center(
                                                          child: Shimmer
                                                              .fromColors(
                                                                  direction:
                                                                      ShimmerDirection
                                                                          .ltr,
                                                                  period: Duration(
                                                                      seconds:
                                                                          2),
                                                                  child:
                                                                      ListView(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    // shrinkWrap: true,
                                                                    children: [
                                                                      0,
                                                                      1,
                                                                      2,
                                                                      3
                                                                    ]
                                                                        .map((_) =>
                                                                            LoaderWidget())
                                                                        .toList(),
                                                                  ),
                                                                  baseColor:
                                                                      AppColors
                                                                          .white,
                                                                  highlightColor:
                                                                      AppColors
                                                                          .grey),
                                                        ));
                                                  } else if (snapshot
                                                      .data!.isNotEmpty) {
                                                    return ListView(
                                                        children: snapshot.data!
                                                            .map((feed) => Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: EquipTiles(
                                                                    model:
                                                                        feed)))
                                                            .toList());
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                        child: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'Network error',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                                  } else {
                                                    return Center(
                                                        child: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'Equipment not found',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'Equipment not found',
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ));
                                                  }
                                                }),
                                          ),
                                  ]))))),
              drawer: CollapsingNavigationDrawer(),
            ),
          );
        });
  }
}

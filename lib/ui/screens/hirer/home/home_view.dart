import 'dart:async';
import 'dart:io';

import 'package:equipro/core/enums/dialog_type.dart';
import 'package:equipro/core/model/enums.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/hirer/home/home_view_model.dart';
import 'package:equipro/ui/screens/notification/notification.dart';
import 'package:equipro/ui/widget/equip_tiles.dart';
import 'package:equipro/ui/widget/input_fields/custom_text_field.dart';
import 'package:equipro/ui/widget/loader_widget.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/enums/bottom_sheet_type.dart';
import '../../../../main.dart';
import '../../../../utils/app_svgs.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeNotif() async {
    NotificationSettings permission =
        await _firebaseMessaging.requestPermission(
            sound: true, badge: true, alert: true, provisional: false);
    if (permission.authorizationStatus == AuthorizationStatus.authorized) {
      _firebaseMessaging.subscribeToTopic("equippro_general");
      if (Platform.isAndroid) {
        _firebaseMessaging.subscribeToTopic("equippro_android");
      } else {
        _firebaseMessaging.subscribeToTopic("equippro_ios");
      }
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        messageHandler(message);
      });
    }
  }

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
        showLocationBottomSheet();
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
    print("Getting location");
    var locationData2 = await location.getLocation();
    print("Location");
    print(locationData);
    //setState(() {
    locationData = locationData2;
    // });
    return locationData!;
  }

  void showLocationBottomSheet() async {
    SheetResponse? res = await locator<BottomSheetService>().showCustomSheet(
        variant: BottomSheetType.location, barrierDismissible: false);
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

//   void registerNotification() async {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings();
//     final MacOSInitializationSettings initializationSettingsMacOS =
//         MacOSInitializationSettings();
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS,
//             macOS: initializationSettingsMacOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: selectNotification);
//     // var initializationSettings = InitializationSettings();
//     // channel = const AndroidNotificationChannel(
//     //   'high_importance_channel', // id
//     //   'High Importance Notifications', // title
//     //   //'This channel is used for important notifications.', // description
//     //   importance: Importance.high,
//     // );
//     //
//     // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     // flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     // await flutterLocalNotificationsPlugin
//     //     .resolvePlatformSpecificImplementation<
//     //         AndroidFlutterLocalNotificationsPlugin>()
//     //     ?.createNotificationChannel(channel);
//
//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     displayDialog(String title, String body) {
//       print("Notification from display: $title, $body");
//       return showTopSnackBar(
//         context,
//         CustomSnackBar.info(
//           backgroundColor: AppColors.primaryColor,
//           message: "$title\n$body",
//         ),
//       );
//     }
//
//     // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
//     //   print("message recieved");
//     //   print("I am message");
//     //   print("Notif: ${event.data}");
//     //   // print("Notification: ${event.data}");
//     //   // displayDialog('${event.notification?.title}', '${event.data}');
//     //   pushNotification(
//     //       event.notification?.title ?? "", event.notification?.body ?? "");
//     //
//     //   // Get.snackbar('${event.notification.body}', '${event.notification.title}',
//     //   //     backgroundColor: AppColors.secondaryColor);
//     // });
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {});
//   }

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
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics);

  @override
  void initState() {
    super.initState();
    // registerNotification();
    initializeNotif();
    // FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        onViewModelReady: (v) async {
          await getUserLocation();
          v.init(locationData!.latitude.toString(),
              locationData!.longitude.toString(), context);
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
              body: Padding(
                padding: EdgeInsets.all(14),
                child: RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: () async {
                    try {
                      await model.refresh(locationData!.latitude.toString(),
                          locationData!.longitude.toString(), context);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 200),
                            childAnimationBuilder: (widget) => SlideAnimation(
                                  horizontalOffset:
                                      -MediaQuery.of(context).size.width / 4,
                                  child: FadeInAnimation(
                                      curve: Curves.fastOutSlowIn,
                                      child: widget),
                                ),
                            children: [
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
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Gap(
                                30,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CustomSearchField(
                                        hintText:
                                            "Search by location, name of...",
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NotificationPage())),
                                        child: SvgPicture.asset(
                                            "assets/images/notification.svg"))
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
                              Gap(
                                30,
                              ),
                              NewEquipListBuilderHirer(
                                model: model,
                                locationData: locationData,
                              )
                              // searchWord.isEmpty
                              //     ? Container(
                              //         height:
                              //             MediaQuery.of(context).size.height *
                              //                 0.6,
                              //         child: ViewModelBuilder<
                              //                 HomeViewModel>.reactive(
                              //             viewModelBuilder: () =>
                              //                 HomeViewModel(),
                              //             onViewModelReady: (vm) {
                              //               vm.newGetEquipments(
                              //                   locationData != null
                              //                       ? locationData!.latitude
                              //                           .toString()
                              //                       : "6.4478",
                              //                   locationData != null
                              //                       ? locationData!.longitude
                              //                           .toString()
                              //                       : "3.4723");
                              //               vm.controller =
                              //                   new ScrollController()
                              //                     ..addListener(() {
                              //                       vm.getEquipmentMore(
                              //                           //  "6.4478", "3.4723"
                              //                           locationData!.latitude
                              //                               .toString(),
                              //                           locationData!.longitude
                              //                               .toString());
                              //                     });
                              //             },
                              //             builder: (context, v, child) {
                              //               if (v.fetchState ==
                              //                   LoadingState.loading) {
                              //                 return Container(
                              //                     height: 400,
                              //                     padding: EdgeInsets.all(20.0),
                              //                     child: Center(
                              //                       child: Shimmer.fromColors(
                              //                           direction:
                              //                               ShimmerDirection
                              //                                   .ltr,
                              //                           period: Duration(
                              //                               seconds: 2),
                              //                           child: ListView(
                              //                             scrollDirection:
                              //                                 Axis.vertical,
                              //                             // shrinkWrap: true,
                              //                             children: [0, 1, 2, 3]
                              //                                 .map((_) =>
                              //                                     LoaderWidget())
                              //                                 .toList(),
                              //                           ),
                              //                           baseColor:
                              //                               AppColors.white,
                              //                           highlightColor:
                              //                               AppColors.grey),
                              //                     ));
                              //               } else if (v.fetchState ==
                              //                   LoadingState.done) {
                              //                 if (v.packageList.isNotEmpty) {
                              //                   return SingleChildScrollView(
                              //                       scrollDirection:
                              //                           Axis.vertical,
                              //                       controller: v.controller,
                              //                       physics:
                              //                           BouncingScrollPhysics(),
                              //                       // shrinkWrap: true,
                              //                       child: Column(
                              //                         children: [
                              //                           Column(
                              //                               children: v
                              //                                   .packageList
                              //                                   .map((feed) =>
                              //                                       EquipTiles(
                              //                                           model:
                              //                                               feed))
                              //                                   .toList()),
                              //                           SizedBox(height: 20),
                              //                           v.loadingState ==
                              //                                   LoadingState
                              //                                       .loading
                              //                               ? Container(
                              //                                   height: 400,
                              //                                   padding:
                              //                                       EdgeInsets
                              //                                           .all(
                              //                                               20.0),
                              //                                   child: Center(
                              //                                     child: Shimmer
                              //                                         .fromColors(
                              //                                             direction: ShimmerDirection
                              //                                                 .ltr,
                              //                                             period: Duration(
                              //                                                 seconds:
                              //                                                     2),
                              //                                             child:
                              //                                                 ListView(
                              //                                               scrollDirection:
                              //                                                   Axis.vertical,
                              //                                               // shrinkWrap: true,
                              //                                               children:
                              //                                                   [
                              //                                                 0,
                              //                                                 1,
                              //                                               ].map((_) => LoaderWidget()).toList(),
                              //                                             ),
                              //                                             baseColor: AppColors
                              //                                                 .white,
                              //                                             highlightColor:
                              //                                                 AppColors.grey),
                              //                                   ))
                              //                               : SizedBox(
                              //                                   height: 1)
                              //                         ],
                              //                       ));
                              //                 } else {
                              //                   return Center(
                              //                       child: Column(
                              //                     // mainAxisAlignment:
                              //                     //     MainAxisAlignment
                              //                     //         .center,
                              //                     children: [
                              //                       Gap(100),
                              //                       SvgPicture.asset(
                              //                           AppSvgs.emptyRental),
                              //                       Gap(30),
                              //                       Text(
                              //                         "No available equipments near you",
                              //                         style: Theme.of(context)
                              //                             .textTheme
                              //                             .bodyMedium
                              //                             ?.copyWith(
                              //                                 fontSize: 15,
                              //                                 fontWeight:
                              //                                     FontWeight
                              //                                         .w600,
                              //                                 color:
                              //                                     Colors.grey),
                              //                         textAlign:
                              //                             TextAlign.center,
                              //                       ),
                              //                       // SizedBox(
                              //                       //   height: 30,
                              //                       // ),
                              //                     ],
                              //                   ));
                              //                 }
                              //               } else {
                              //                 return Center(
                              //                     child: Column(
                              //                   children: <Widget>[
                              //                     SizedBox(
                              //                       height: 100,
                              //                     ),
                              //                     Text(
                              //                       'Network error',
                              //                       style: TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         fontSize: 20,
                              //                       ),
                              //                     ),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Text('Network error'),
                              //                     SizedBox(
                              //                       height: 100,
                              //                     ),
                              //                   ],
                              //                 ));
                              //               }
                              //             }),
                              //       )
                              //     : Container(
                              //         height: Responsive.height(context) / 2,
                              //         child: FutureBuilder<
                              //                 List<EquipmentModel>>(
                              //             future: model
                              //                 .searchEquipments(searchWord),
                              //             builder: (context, snapshot) {
                              //               if (model.packageList.isEmpty) {
                              //                 return Container(
                              //                     height: 400,
                              //                     padding: EdgeInsets.all(20.0),
                              //                     child: Center(
                              //                       child: Shimmer.fromColors(
                              //                           direction:
                              //                               ShimmerDirection
                              //                                   .ltr,
                              //                           period: Duration(
                              //                               seconds: 2),
                              //                           child: ListView(
                              //                             scrollDirection:
                              //                                 Axis.vertical,
                              //                             // shrinkWrap: true,
                              //                             children: [0, 1, 2, 3]
                              //                                 .map((_) =>
                              //                                     LoaderWidget())
                              //                                 .toList(),
                              //                           ),
                              //                           baseColor:
                              //                               AppColors.white,
                              //                           highlightColor:
                              //                               AppColors.grey),
                              //                     ));
                              //               } else if (model
                              //                   .packageList.isNotEmpty) {
                              //                 return ListView(
                              //                     children: model.packageList
                              //                         .map((feed) => Padding(
                              //                             padding:
                              //                                 EdgeInsets.all(
                              //                                     10),
                              //                             child: EquipTiles(
                              //                                 model: feed)))
                              //                         .toList());
                              //               } else if (snapshot.hasError) {
                              //                 return Center(
                              //                     child: Column(
                              //                   children: <Widget>[
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Text(
                              //                       'Network error',
                              //                       style: TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         fontSize: 20,
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ));
                              //               } else {
                              //                 return Center(
                              //                     child: Column(
                              //                   children: <Widget>[
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Text(
                              //                       'Equipment not found',
                              //                       style: TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         fontSize: 20,
                              //                       ),
                              //                     ),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Text(
                              //                       'Equipment not found',
                              //                     ),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                   ],
                              //                 ));
                              //               }
                              //             }),
                              //       ),
                            ])),
                  ),
                ),
              ),
              drawer: CollapsingNavigationDrawer(),
            ),
          );
        });
  }
}

class NewEquipListBuilderHirer extends StatelessWidget {
  final HomeViewModel model;
  final dynamic locationData;
  const NewEquipListBuilderHirer(
      {Key? key, required this.model, this.locationData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (model.fetchState == LoadingState.loading) {
        return Container(
            height: 400,
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: Duration(seconds: 2),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    // shrinkWrap: true,
                    children: [0, 1, 2, 3].map((_) => LoaderWidget()).toList(),
                  ),
                  baseColor: AppColors.white,
                  highlightColor: AppColors.grey),
            ));
      } else if (model.fetchState == LoadingState.done &&
          model.packageList.isNotEmpty) {
        return Column(
            children: List.generate(model.packageList.length,
                (index) => EquipTiles(model: model.packageList[index])));

        // model.packageList
        //     .map((feed) => OwnerEquipTiles(model: feed))
        //     .toList()),
        // ;
      } else if (model.fetchState == LoadingState.done &&
          model.packageList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(100),
              SvgPicture.asset(AppSvgs.emptyRental),
              Gap(5),
              Text("No available equipments near you")
            ],
          ),
        );
      } else if (locationData == null) {
        return Center(
            child: Column(
          children: [
            Gap(100),
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 3,
              ),
            ),
          ],
        ));
      } else {
        return Center(
            child: Column(
          children: [
            Gap(100),
            Text("Network Error"),
          ],
        ));
      }
    });
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHelper {
  late String _token;
  late Stream<String> tokenStream;
  late String gToken;

  setToken(String token) {
    print('FCM Token: $token');

    _token = token;
  }

  static getFcmToken() async {
    // String deviceToken =  await firebaseMessaging.getToken();
    var deviceToken = FirebaseMessaging.instance.getToken();
    //  Stream<String>  tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    //  tokenStream.listen((String token) {
    //    print('FCM Token: $token');
    //
    //      gToken = token;
    //  });
    // //print('print device token $deviceToken');
    return deviceToken;
  }
}

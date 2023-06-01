// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class NotificationsService {
  final log = Logger();
  final _fcm = FirebaseMessaging.instance;
  String? fcmToken;

  ///
  ///Initializing Notification services that includes FLN, ANDROID NOTIFICATION CHANNEL setting
  ///FCM NOTIFICATION SETTINGS, and also listeners for OnMessage and for onMessageOpenedApp
  ///
  initConfigure() async {
    log.d("@initFCMConfigure/started");

//now finally get the token from
    await _fcm.getToken().then((token) {
      log.d("FCM TOKEN IS =======-======>$token");
      fcmToken = token;
    });

    fcmToken = await getFcmToken();

    ///
    ///now initializing the listeners
    ///
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

    // ignore: unused_local_variable
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  // print('User granted permission: ${settings.authorizationStatus}');

  onNotificationClick(String payload) {
    log.d('Payload / notification data message is ====>  $payload');
    // Get.to(() => NotificationScreen2(hostUserId));
  }

  Future<String?> getFcmToken() async {
    return await _fcm.getToken();
  }
}

///
///received notification model class for ios didNotificationReceived callback
///
class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _notificationService =
  NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = "1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidNotificationDetails =
  AndroidNotificationDetails(
    channelId,
    "cashmore",
    channelDescription:
    "This channel is responsible for all the local notifications",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
    styleInformation: DefaultStyleInformation(true, true),
  );

  static const IOSNotificationDetails _iOSNotificationDetails =
  IOSNotificationDetails();

  final NotificationDetails notificationDetails = const NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iOSNotificationDetails,
  );

  // var androidPlatformChannelSpecifics =
  // AndroidNotificationDetails(
  //   'Notification Channel ID',
  //   'Channel Name',
  //   importance: Importance.max,
  //   priority: Priority.high,
  // );
  //
  // var iOSPlatformChannelSpecifics =
  // IOSNotificationDetails();

  // var platformChannelSpecifics =
  // NotificationDetails(
  //     android: _androidNotificationDetails,
  //     iOS: _iOSNotificationDetails
  // );

  Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("notification_icon");

    final IOSInitializationSettings iOSInitializationSettings =
    IOSInitializationSettings(
      defaultPresentAlert: false,
      defaultPresentBadge: false,
      defaultPresentSound: false,

      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );


    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    // *** Initialize timezone here ***

    // if (Platform.isAndroid) {
    //   await flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<
    //       AndroidFlutterLocalNotificationsPlugin>()
    //       .createNotificationChannel(androidPlatformChannelSpecifics);
    // }
    // if (Platform.isIOS) {
    //   await flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<
    //       IOSFlutterLocalNotificationsPlugin>()
    //       .requestPermissions(
    //     alert: true,
    //     badge: true,
    //     sound: true,
    //   );
    // }

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    CupertinoAlertDialog(
      title: Text(title!),
      content: Text(body!),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () async {
            // Navigator.of(context, rootNavigator: true).pop();
            print('Payload:: $payload');

          },
        )
      ],
    );
  }

  // void onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload, BuildContext ctx) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   showDialog(
  //     context: ctx,
  //     builder: (BuildContext context) =>
  //         CupertinoAlertDialog(
  //           title: Text(title),
  //           content: Text(body),
  //           actions: [
  //             CupertinoDialogAction(
  //               isDefaultAction: true,
  //               child: Text('Ok'),
  //               onPressed: () async {
  //                 Navigator.of(context, rootNavigator: true).pop();
  //                 print('Payload:: $payload');
  //                 // await Navigator.push(
  //                 //   context,
  //                 //   MaterialPageRoute(
  //                 //     builder: (context) => printSecondScreen(payload),
  //                 //   ),
  //                 // );
  //               },
  //             )
  //           ],
  //         ),
  //   );
  // }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> showNotification(
      int id, String? title, String? body, String payload) async {
    print('Notify 0000::: $title');
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }


  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future<void> onSelectNotification(String? payload) async {
  // await navigatorKey.currentState
  //     ?.push(MaterialPageRoute(builder: (_) => DetailsPage(payload: payload)));
}
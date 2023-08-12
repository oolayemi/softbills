import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

class NotificationRemindersServiceImpl extends NotificationService {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  NotificationRemindersServiceImpl() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  @override
  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  @override
  void initNotifications() {
    // Sets icon to be displayed with notification (android).
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    // Intialization requires two arguments, for IOS and Android. IOS requires more , but that hasn't been set yet.
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, 
      iOS: initializationSettingsIOS
    );

    flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification
    );
  }

  @override
  dynamic pendingNotificationRequests() async => await flutterLocalNotificationsPlugin!.pendingNotificationRequests();


  // void sendNotificationDaily({int id, String title, String body, int hour, int minute}) async {
  //   var time = new Time(hour, minute, 0);

  //   await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body, time, getPlatformChannelSpecifics(id));

  //   print('Notification Succesfully Scheduled for ${time.toString()} with id of $id');
  // }

  // void sendNotificationOnce(int id, String title, String body, DateTime time) async {
  //   await flutterLocalNotificationsPlugin.schedule(id, title, body, time, getPlatformChannelSpecifics(id));

  //   print('Notification Succesfully Scheduled for ${time.toString()} with id of $id');
  // }

  @override
  void sendNotificationNow(int id, String title, String body, String payload) async {
    await flutterLocalNotificationsPlugin!.show(id, title, body, getPlatformChannelSpecifics(id), payload: payload);
  }

  @override
  getPlatformChannelSpecifics(int id) {
    // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //   env('NOTIFICATION_CHANNEL_ID'),
    //   env('NOTIFICATION_CHANNEL_NAME'),
    //   // 'description',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   ticker: 'ticker'
    // );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      // android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
    );

    return platformChannelSpecifics;
  }

  @override
  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    return Future.value(1);
  }

  @override
  Future onSelectNotification(String? payload) async {
    print('Notification clicked');
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.pushNamed(context,
    // screen name goes here
    // );
  }

  @override
  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin!.cancel(notificationId);
    print('Notification with id: $notificationId been removed successfully');
  }
}
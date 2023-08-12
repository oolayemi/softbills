/// An abstract class for local notification service
/// 
/// Inspired by Abbie (-_-)
abstract class NotificationService {
  /// Get the instance from the notification package
  getNotificationInstance();

  /// initialise the plugin.
  void initNotifications();

  dynamic pendingNotificationRequests();

  /// Function to schedule a reminder at a specific time daily
  // void sendNotificationDaily({int id, String title, String body, int hour, int minute});

  /// Function to schedule reminder on a specific date but just once
  // void sendNotificationOnce(int id, String title, String body, DateTime time);

  ///Function to show notification immediately
  void sendNotificationNow(int id, String title, String body, String payload);

  /// This as the function name states, sets given properties to the notification.
  getPlatformChannelSpecifics(int id);

  /// Configuration for IOS
  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload);

  /// To navigate to a certain screen on click of notification for devices notification panel
  Future onSelectNotification(String payload);

  /// Function to remove reminder, in the case where well, the data was deleted. So user won't receive notification still.
  void removeReminder(int notificationId);
}
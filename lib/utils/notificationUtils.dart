//
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_m_chat/utils/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationUtils {
  static Future<void> firebaseBackgroundMessage(
      RemoteMessage remoteMessage) async {
    print(remoteMessage.data);
    if (remoteMessage.notification == null) {
      createLocalNotification(dimissable: true, message: remoteMessage);
    }
  }

  static Future<void> initializeAwesomeNotification() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: notificationChannelKey,
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        vibrationPattern: highVibrationPattern,
      ),
      NotificationChannel(
        channelKey: callNotificationChannelKey,
        channelName: 'Call notifications',
        channelDescription: 'Notification channel for video call notification',
        importance: NotificationImportance.High,
        vibrationPattern: highVibrationPattern,
      )
    ]);
  }

  static void initNotification() async {
    print("Init notifications");

    //Need to call this in order to get foreground notificaiton
    //this is ongoing issue for more info this visit : https://github.com/FirebaseExtended/flutterfire/issues/6011
    await FirebaseMessaging.instance.getToken();
    //Forground message listener
    FirebaseMessaging.onMessage.listen((message) {
      print(message.data);

      createLocalNotification(dimissable: false, message: message);
    });

    //This callback will fire when user open the app by tapping on notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Tapcalled");
    });

    //Background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);
  }

  static Future<bool> isLocalNotificationAllowed() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  //initlocal notification stream callbacks when user tap on notification
  static void initLocalNoticationStream() {
    AwesomeNotifications().actionStream.listen((actionData) {
      print(actionData.title);
      print(actionData.payload);
    });
  }

  static Future<void> createLocalNotification(
      {required bool dimissable, required RemoteMessage message}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        autoDismissible: dimissable,
        title: message.data['title'] + "Thi can be control",
        body: message.data['body'],
        id: 1,
        showWhen: true,
        locked: !dimissable,
        payload: {"notificationType": message.data['notificationType'] ?? ""},
        channelKey: callNotificationChannelKey,
      ),
    );
  }
}

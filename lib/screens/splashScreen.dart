import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_m_chat/screens/homeScreen.dart';
import 'package:chat_m_chat/utils/notificationUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void showNotificataionRequestDialog() {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Allow us to send notifications"),
        actions: [
          CupertinoButton(
            onPressed: () {
              AwesomeNotifications().requestPermissionToSendNotifications();
              Navigator.pop(context);
            },
            child: Text("Allow"),
          ),
          CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Deny"),
          )
        ],
      ),
    );
  }

  void initLocalNotification() async {
    bool isAllowed = await NotificationUtils.isLocalNotificationAllowed();
    if (!isAllowed) {
      showNotificataionRequestDialog();
      NotificationUtils.initLocalNoticationStream();
    } else {
      NotificationUtils.initLocalNoticationStream();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initLocalNotification();
    });
    navigateToNextPage();
  }

  Future<void> navigateToNextPage() async {
    await Future.delayed(Duration(
      seconds: 3,
    ));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}

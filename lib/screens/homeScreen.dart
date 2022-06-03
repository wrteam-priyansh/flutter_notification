import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_m_chat/utils/notificationUtils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    AwesomeNotifications().dispose();
    super.dispose();
  }

  @override
  void initState() {
    NotificationUtils.initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: TextButton(
                onPressed: () {
                  AwesomeNotifications().dismissAllNotifications();
                },
                child: Text("Dismiss")),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        FirebaseMessaging.instance.getToken().then((value) => print(value));
      }),
      appBar: AppBar(
        title: Text("Home"),
      ),
    );
  }
}

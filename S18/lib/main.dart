import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:myapp/notification_controller.dart';



void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: MyApp.navigatorKey,


      home: MyWidget(),
      //home:  MyHomePage(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  late AwesomeNotifications notifications;
  @override
  void initState() {

    notifications = AwesomeNotifications();
    var channel =  NotificationChannel(
        channelKey: 'main_channel2',
        channelName: 'Flutter Main notification ',
        channelDescription: 'Notification channel description',
        playSound: false,

        defaultColor: Colors.blueAccent);

    AwesomeNotifications().initialize(
        null,
        [
          channel
        ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'channel_group1',
          channelGroupName: 'Channel group name')
    ],
    debug: true
    );

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(onPressed: ()async{

                AwesomeNotifications().isNotificationAllowed().then((value) {
                  if(!value){
                    AwesomeNotifications().requestPermissionToSendNotifications();
                    print("Permission: false");
                  }else{


                    notifications.createNotification(
                      content: NotificationContent(
                          id: 2,
                          channelKey: 'main_channel2',
                      title: 'Notification example',
                      bigPicture: 'asset://assets/top.jpg',
                      locked: false,
                      notificationLayout: NotificationLayout.BigText,
                      actionType: ActionType.Default,
                      payload: {'data':'Hello'},

                      body: 'this is a notification from your app.....',)
                    );
                  }
                });
              },
                  child: Text("SHow notification")
              ),
              TextButton(onPressed: (){
                notifications.dismiss(2);
              },
                  child: Text("Cancel"))
            ],
          ),
        )
    );
  }
}

import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> ShowNotification(
    {required AwesomeNotifications notification,required String title,required String body,
    String? url})async{


  print("--------------- URL: $url");
  AwesomeNotifications().isNotificationAllowed().then((value) {


    if(!value){
      AwesomeNotifications().requestPermissionToSendNotifications();
      print("Without permission-----");
    }else{


      notification.createNotification(

        actionButtons: url!=null?[
          NotificationActionButton(key: "key", label: "مشاهده لینک")
        ]
          :null,
        content: NotificationContent(id: 2, channelKey: "main_channel",
        title: title,
          body: body,

          notificationLayout: NotificationLayout.BigText,
          wakeUpScreen: true,

            actionType: ActionType.KeepOnTop,
            payload: {"data":url}

        )
      );

    }
  },);



}
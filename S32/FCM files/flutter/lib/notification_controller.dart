import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationController {

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
    print("-------dismiss----");
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {


    print("----${receivedAction.payload.toString()}");


    var _data = receivedAction.payload?["data"];

    if(_data!=null){
      // open link
      OpenLink(_data);
    }

  }

 static OpenLink(String url) async{

   try{
     if(!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)){
       throw Exception("Browser not working");
     }
   }catch(e){
     print("Could not launch url");
   }
  }



}
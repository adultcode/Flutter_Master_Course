import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:push/notification_controller.dart';
import 'firebase_options.dart';
import 'notifi_builder.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

late AwesomeNotifications notifications;
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  /*
  init awesome notification
   */


  notifications = AwesomeNotifications();
  var channel = NotificationChannel(
      channelKey: "main_channel",
      channelName: "Main channel FCM",
      importance: NotificationImportance.High,
      channelDescription: "Notification from Firebase",
      playSound:  true);



  /*
  init fcm
   */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      criticalAlert: false,
      sound: true
  );

  /*
  get token
   */
  print("Token: ${await messaging.getToken()}");
  AwesomeNotifications().initialize(
      null,
      [
        channel
      ],
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: "channel_group", channelGroupName: "Main group")
      ],
      debug:  true
  );

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
  );
/*
fcm background
 */


  await FirebaseMessaging.instance.subscribeToTopic("test");


  FirebaseMessaging.onBackgroundMessage(_firebaseMessageinBackground);
  /*
  fcm listen
   */

  FirebaseMessaging.onMessage.listen((RemoteMessage event) async{

    print("------Message stream: ${event.data}");

    if(event.notification!=null){


      // create a notification
      ShowNotification(notification: notifications,title: event.notification!.title!,
          body: event.notification!.body!,url: event.data["url"]);
    }else{
      notifications = AwesomeNotifications();

      await ShowNotification(notification: notifications,
          title:event.data["title"],
          body: "this is body",url: event.data["url"]);

    }
  },);

  runApp( MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessageinBackground(RemoteMessage message) async{
  print("------Message: from background ${message.data['url']}");
  notifications = AwesomeNotifications();
  if(message.notification!=null){
    print("------------- NOT null");

    // create a notification
    await ShowNotification(notification: notifications,title: message.notification!.title!,
        body: message.notification!.body!,url: message.data["url"]);
  }else{


    await ShowNotification(notification: notifications,
        title:message.data["title"],
        body: "this is body",url: message.data["url"]);

  }
}

class MyApp extends StatelessWidget {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var status = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  void SignUp() async{


    try{

      /*
      email and password
       */
      // UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: "test@gmail.com",
      //     password: "123456");

      /*
      google signin
       */

      final GoogleSignInAccount? googleSignInAccount = await  GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);


      getData();
    }catch(e){

      setState(() {
        status = e.toString();
      });
    }


  }

  void SignIn() async{


    try{

      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: "test@gmail.com",
          password: "123456");
      getData();
    }catch(e){

      setState(() {
        print("----Error: "+e.toString());
        status = e.toString();
      });
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async{



    setState(() {
      auth.currentUser==null?
          status  = "User not found":
          status = "Welcome: ${auth.currentUser?.email}";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            Text(
              '$status',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: ()async {

            await  auth.signOut();
              getData();
            }, child: Text("Sign out"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: SignUp,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

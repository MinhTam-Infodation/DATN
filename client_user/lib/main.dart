import 'package:client_user/repository/auth_repository/auth_repository.dart';
import 'package:client_user/screens/home/screen_home.dart';
import 'package:client_user/screens/init_firebase/screen_err404.dart';
import 'package:client_user/screens/init_firebase/screen_inprogress.dart';
import 'package:client_user/screens/welcome/screen_welcome.dart';
import 'package:client_user/shared/connect_firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirebaseConnect(
        builder: (context) {
          return const GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "GetX Firebase App",
            home: ScreenWelcome(),
            transitionDuration: Duration(milliseconds: 500),
          );
        },
        builderConnect: (BuildContext context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "GetX Firebase App",
            home: ScreenInprogress(),
          );
        },
        builderError: (context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "GetX Firebase App",
            home: ScreenErr404(),
          );
        },
      ),
    );
  }
}

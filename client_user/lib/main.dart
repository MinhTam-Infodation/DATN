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
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository));
  await GetStorage.init();
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        final _orderId = remoteMessage.notification?.titleLocKey != null
            ? int.parse(remoteMessage.notification!.titleLocKey!)
            : null;
      }
      await HelperNotification
    }
  } catch (e) {}
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

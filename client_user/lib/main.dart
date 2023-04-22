import 'package:client_user/screens/init_firebase/screen_err404.dart';
import 'package:client_user/screens/init_firebase/screen_inprogress.dart';
import 'package:client_user/screens/login/screen_login.dart';
import 'package:client_user/screens/signup/screen_signup.dart';
import 'package:client_user/screens/splash/screen_splash.dart';
import 'package:client_user/screens/welcome/screen_welcome.dart';
import 'package:client_user/shared/connect_firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
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

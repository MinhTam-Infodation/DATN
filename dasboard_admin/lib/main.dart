import 'package:dasboard_admin/connect/firebase_connection.dart';
import 'package:dasboard_admin/screens/login/screen_login.dart';
import 'package:dasboard_admin/screens/panigator/main_panigator_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_const_constructors
      home: MyFirebaseConnect(
        errorMessage: "Not Connect",
        connectingMessage: "In Progress",
        builder: (context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "GetX Firebase App",
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}

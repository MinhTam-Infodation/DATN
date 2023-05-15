import 'package:dasboard_admin/controllers/waltinguser_controller.dart';
import 'package:dasboard_admin/screens/dashboard/screen_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? newUser = userCredential.user;
      if (newUser != null) {
        user.value = newUser;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      if (email != "" && password != "") {
        // Check Login
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // ignore: unnecessary_null_comparison
        if (userCredential != null) {
          Get.to(() => const ScreenDashboard());
          Get.snackbar('Suceess', "Login To Success",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.greenAccent.withOpacity(0.1),
              colorText: Colors.black);
        }
      } else {
        Get.snackbar('Error', "Data Invalid",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.black);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.black);
    }
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // ignore: avoid_print
      print("ID: " + currentUser.uid);
    }
  }

  void logout() async {
    await _auth.signOut();
    user.value = null;
  }
}


// Hiển thị tháng
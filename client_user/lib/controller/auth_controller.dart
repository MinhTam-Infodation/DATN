// ignore_for_file: avoid_print, unused_field

import 'dart:convert';

import 'package:client_user/screens/home/screen_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> register(
      String email, String password, String username, String phone) async {
    try {
      // Check Create Account
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .whenComplete(() => Get.snackbar('Success', "Create Account Success",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.greenAccent.withOpacity(0.1),
              colorText: Colors.white));

      // Lưu vào GetStorage() để sử dụng sau này
      box.write('idCredential', userCredential.user!.uid);

      // Thực hiện Add Collection Data dự vào credential
      final timestampObject = Timestamp.now();
      final timestampNumber = timestampObject.toDate().millisecondsSinceEpoch;

      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "Id": userCredential.user!.uid,
        'Name': username,
        'Email': email,
        "Paassword": password,
        'Phone': phone,
        'Address': "",
        'Avatar': "",
        'PackageType': "",
        'Status': false,
        'ActiveAt': 0,
        'CreatedAt': timestampNumber,
      }).whenComplete(() => Get.snackbar('Success', "Create Profile Success",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.greenAccent.withOpacity(0.1),
          colorText: Colors.white));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Password is not strong enough', e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.black);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Email already used for another account', e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.black);
      } else {
        Get.snackbar('Registration failed', e.toString(),
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
  }

  // Gửi email để reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Gửi email thành công');
    } catch (e) {
      print('Lỗi khi gửi email: $e');
      rethrow;
    }
  }

  // Xác nhận mã xác nhận và thiết lập mật khẩu mới
  Future<void> confirmPasswordReset(String code, String newPassword) async {
    try {
      await _auth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      print('Thiết lập mật khẩu mới thành công');
    } catch (e) {
      print('Lỗi khi thiết lập mật khẩu mới: $e');
      rethrow;
    }
  }

  /* Update InfoMation User */
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      final userRef = _firestore.collection('Wailting').doc(userId);
      await userRef.update(data);
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> updateUserv2(
      String userId, List<Map<String, dynamic>> updates) async {
    try {
      final userRef = _firestore.collection('Users').doc(userId);
      // ignore: prefer_collection_literals
      final dataToUpdate = Map<String, dynamic>();
      for (final update in updates) {
        dataToUpdate.addAll(update);
      }
      // ignore: void_checks
      await userRef.update(dataToUpdate).whenComplete(() {
        Get.to(() => const ScreenHome());
        Get.snackbar('Update', "Update Success",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.greenAccent.withOpacity(0.1),
            colorText: Colors.white);
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.greenAccent.withOpacity(0.1),
          colorText: Colors.white);
    }
  }

  Future sendEmail(
      String subject, String obj, String mess, String userEmail) async {
    print("EMAIL");
    String username = "tam.hm.61cntt@ntu.edu.vn";
    String password = "hoangminhtam123pro";

    final stmpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your name $userEmail')
      ..recipients.add(userEmail)
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(const Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, stmpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent. $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}

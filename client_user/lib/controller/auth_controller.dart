import 'package:client_user/modal/users.dart';
import 'package:client_user/screens/home/screen_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
          .whenComplete(() => {
                Get.snackbar('Success', "Create Account Success",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.greenAccent.withOpacity(0.1),
                    colorText: Colors.white)
              });

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
      }).whenComplete(() => {
            Get.snackbar('Success', "Create Profile Success",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.greenAccent.withOpacity(0.1),
                colorText: Colors.white)
          });
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

  /* Login */
  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .whenComplete(() => {Get.to(() => const ScreenHome())});
      box.write('email', email);
      box.write('idCredential', userCredential.user!.uid);

      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('Users');
      QuerySnapshot querySnapshot =
          await usersRef.where('Id', isEqualTo: box.read("idCredential")).get();
      if (querySnapshot.docs.isEmpty) {
        querySnapshot = await usersRef.get();
        Get.snackbar('Error', "No Data To User Query",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.black);
      } else {
        querySnapshot = await usersRef.get();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.black);
    }
  }

  /* Sign In With Google */
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Thực hiện đăng nhập vào Firebase với credential của Google
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Lấy thông tin user từ UserCredential và lưu vào collection
      final userc = userCredential.user;
      final newUser = Users(
        Id: userc!.uid,
        Name: userc.displayName,
        Email: userc.email,
        Avatar: userc.photoURL,
        Status: false,
        CreateAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _firestore.collection('users').doc(userc.uid).set(newUser.toJson());
    } catch (e) {
      // Handle lỗi nếu có
      // ignore: avoid_print
      print(e);
    }
  }

  // Gửi email để reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // ignore: avoid_print
      print('Gửi email thành công');
    } catch (e) {
      // ignore: avoid_print
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
      // ignore: avoid_print
      print('Thiết lập mật khẩu mới thành công');
    } catch (e) {
      // ignore: avoid_print
      print('Lỗi khi thiết lập mật khẩu mới: $e');
      rethrow;
    }
  }

  /*
    User user = User(
      Name: 'Nguyen Van A',
      Email: 'nguyenvana@example.com',
      Password: 'password123',
    );

    await AuthController().sendPasswordResetEmail(user.Email);

    await AuthController()
    .confirmPasswordReset(code, newPassword);

  */

  /* Update InfoMation User */
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      final userRef = _firestore.collection('Wailting').doc(userId);
      await userRef.update(data);
    } catch (e) {
      // ignore: avoid_print
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

  /*
    final data = {'status': 'active'};
    await updateUser(userId, data);
  */
}

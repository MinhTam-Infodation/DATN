import 'package:client_user/repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // Input variable
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  // Call this Fun
  void registerUser(String email, String password) {
    Get.put(AuthenticationRepository());
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }
}

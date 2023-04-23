import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_button.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/controller/signup_controller.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.fullName,
                decoration: InputDecoration(
                    label: Text(
                      tInputFullname,
                      style: textSmallQuicksan,
                    ),
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: bgBlack,
                    ),
                    labelStyle: TextStyle(color: bgBlack),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: bgBlack)),
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: sButtonHeight,
              ),
              TextFormField(
                controller: controller.email,
                decoration: InputDecoration(
                    label: Text(
                      tEmail,
                      style: textSmallQuicksan,
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: bgBlack,
                    ),
                    labelStyle: TextStyle(color: bgBlack),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: bgBlack)),
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: sButtonHeight,
              ),
              TextFormField(
                controller: controller.phoneNo,
                decoration: InputDecoration(
                    label: Text(
                      tInputPhone,
                      style: textSmallQuicksan,
                    ),
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: bgBlack,
                    ),
                    labelStyle: TextStyle(color: bgBlack),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: bgBlack)),
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: sButtonHeight,
              ),
              TextFormField(
                controller: controller.password,
                decoration: InputDecoration(
                    label: Text(
                      tPassword,
                      style: textSmallQuicksan,
                    ),
                    prefixIcon: Icon(
                      Icons.fingerprint,
                      color: bgBlack,
                    ),
                    labelStyle: TextStyle(color: bgBlack),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: bgBlack)),
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: sButtonHeight,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: bgBlack, width: 5.0),
                        ),
                        foregroundColor: bgWhite,
                        backgroundColor: bgBlack,
                        padding: const EdgeInsets.symmetric(
                            vertical: sButtonHeight)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SignUpController.instance.registerUser(
                            controller.email.text.trim(),
                            controller.password.text.trim());
                      }
                    },
                    child: Text(
                      tSignUp.toUpperCase(),
                      style: textSmallQuicksanWhite,
                    )),
              )
            ],
          )),
    );
  }
}

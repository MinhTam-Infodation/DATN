import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_button.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/controller/login_controller.dart';
import 'package:client_user/screens/forget_password/forget_password_options/forget_password_modal_bottom_sheet.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.email,
                decoration: InputDecoration(
                    labelStyle: textSmallQuicksan,
                    prefixIcon: const Icon(Icons.person_outline_outlined),
                    labelText: tEmail,
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: sButtonHeight,
              ),
              TextFormField(
                controller: controller.password,
                decoration: InputDecoration(
                    labelStyle: textSmallQuicksan,
                    prefixIcon: const Icon(Icons.fingerprint),
                    labelText: tPassword,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye_sharp))),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      ForgetPasswordScreen.buildShowModalBottomSheet(context);
                    },
                    child: Text(
                      tForgot,
                      style: textSmallQuicksanLink,
                    )),
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
                      LoginController.instance.loginUser(
                          controller.email.text.trim(),
                          controller.password.text.trim());
                      controller.email.text = "";
                      controller.password.text = "";
                    },
                    child: Text(
                      tButtonLogin.toUpperCase(),
                      style: textSmallQuicksanWhite,
                    )),
              )
            ],
          ),
        ));
  }
}

import 'package:client_user/common/form/form_header_widget.dart';
import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_button.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/constants/string_img.dart';
import 'package:client_user/screens/signup/components/signup_form_widget.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

class ScreenSignup extends StatefulWidget {
  const ScreenSignup({super.key});

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgWhite,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Section 1
                const FormHeaderWidget(
                    title: tTitleSignup, image: iSignup, subTitle: tDesSignup),
                // Section 2
                const SignupFormWidget(),

                // Section 3
                Column(
                  children: [
                    Text(
                      "OR",
                      style: textSmallQuicksan,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: bgBlack, width: 5.0),
                            ),
                            foregroundColor: bgBlack,
                            backgroundColor: bgWhite,
                            padding: const EdgeInsets.symmetric(
                                vertical: sButtonHeight),
                          ),
                          onPressed: () {},
                          icon: Image.asset(
                            iLoginGG,
                            width: 20.0,
                          ),
                          label: Text(
                            tButtonSigninGG,
                            style: textSmallQuicksan,
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text.rich(TextSpan(
                        text: tAlreadySignup,
                        style: textSmallQuicksan,
                        children: [
                          TextSpan(
                              text: tButtonLogin.toUpperCase(),
                              style: textSmallQuicksanLink)
                        ])))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

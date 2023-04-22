import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_button.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/constants/string_img.dart';
import 'package:client_user/screens/login/screen_login.dart';
import 'package:client_user/screens/signup/screen_signup.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenWelcome extends StatefulWidget {
  const ScreenWelcome({super.key});

  @override
  State<ScreenWelcome> createState() => _ScreenWelcomeState();
}

class _ScreenWelcomeState extends State<ScreenWelcome> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage(iWelcom3),
                  height: height * 0.5,
                ),
                Column(
                  children: [
                    Text(
                      tTitleWelcome,
                      style: textBigKanit,
                    ),
                    Text(
                      tDesWelcome,
                      style: textNormalQuicksan,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => ScreenLogin());
                      },
                      child: Text(tButtonLogin),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(),
                          foregroundColor: bgWhite,
                          backgroundColor: bgBlack,
                          padding:
                              EdgeInsets.symmetric(vertical: sButtonHeight)),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => ScreenSignup());
                      },
                      child: Text(
                        tButtonSignUp,
                      ),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          foregroundColor: bgBlack,
                          side: BorderSide(color: bgBlack),
                          padding:
                              EdgeInsets.symmetric(vertical: sButtonHeight)),
                    ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}

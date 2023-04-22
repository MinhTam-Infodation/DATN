import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_button.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/constants/string_img.dart';
import 'package:client_user/screens/login/components/login_form_widget.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage(iLogin5),
                      height: size.height * 0.2,
                    ),
                    Text(
                      tTitleLogin,
                      style: textBigKanit,
                    ),
                    Text(tDesLogin, style: textNormalQuicksan),
                  ],
                ),

                // Section 2
                LoginForm(),

                // Section 3
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("OR"),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(),
                            foregroundColor: bgBlack,
                            backgroundColor: bgWhite,
                            padding:
                                EdgeInsets.symmetric(vertical: sButtonHeight),
                          ),
                          icon: Image(
                            image: AssetImage(iLoginGG),
                            width: 20.0,
                          ),
                          onPressed: () {},
                          label: Text(tButtonSigninGG)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text.rich(TextSpan(
                            text: tAlready,
                            style: textSmallQuicksan,
                            children: [
                              TextSpan(
                                  text: tSignUp, style: textSmallQuicksanLink)
                            ])))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

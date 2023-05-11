import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/constants/string_img.dart';
import 'package:client_user/screens/login/screen_login.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenFobident extends StatelessWidget {
  const ScreenFobident({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              iForbident,
              width: 400,
            ),
            SizedBox(
              child: Column(
                children: [
                  Text(
                    tForbidentTitle,
                    style: textBigKanit,
                  ),
                  Text(
                    tForbidentDes,
                    style: textNormalQuicksan,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: size.width - 80,
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => const ScreenLogin()),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const StadiumBorder(),
                            foregroundColor: bgBlack,
                            backgroundColor: padua,
                            padding: const EdgeInsets.symmetric(
                                vertical: sDashboardPadding)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.arrow_back),
                            Text(
                              tButtonFor,
                              style: textXLQuicksanBold,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Text(
              tForbidentTimming,
              style: textNormalQuicksan,
            )
          ],
        ),
      ),
    ));
  }
}

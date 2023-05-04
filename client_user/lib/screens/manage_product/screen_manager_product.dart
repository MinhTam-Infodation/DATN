import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/constants/string_img.dart';
import 'package:client_user/controller/home_controller.dart';
import 'package:client_user/screens/manage_product/components/test_multi_file.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenManagerProduct extends StatefulWidget {
  const ScreenManagerProduct({super.key});

  @override
  State<ScreenManagerProduct> createState() => _ScreenManagerProductState();
}

class _ScreenManagerProductState extends State<ScreenManagerProduct> {
  var userId = "";

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    } else {
      userId = "";
    }
    final homeController = Get.put(HomeController());
    homeController.checkTotalProduct(userId);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
          title: Text(
            tProductTitle,
            style: textAppKanit,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20, top: 7),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt),
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => Column(
                  children: [
                    if (homeController.totalProduct.toInt() == 0)
                      SizedBox(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      iHomeNoData,
                                      width: 200,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: sDashboardPadding,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => const TestMultiPicker());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: const StadiumBorder(),
                                    foregroundColor: bgBlack,
                                    backgroundColor: padua,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                  ),
                                  child: SizedBox(
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Add Product".toUpperCase()),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        const Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    else
                      Container(
                        child: Text("No Data"),
                      )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

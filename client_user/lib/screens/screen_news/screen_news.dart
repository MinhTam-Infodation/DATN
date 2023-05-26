import 'package:client_user/constants/string_context.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenNews extends StatefulWidget {
  const ScreenNews({super.key});

  @override
  State<ScreenNews> createState() => _ScreenNewsState();
}

class _ScreenNewsState extends State<ScreenNews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            title: Text(
              tProfileTitle,
              style: textAppKanit,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Mark all as read",
                    style: textNormalQuicksanBold,
                  )),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  color: Colors.black,
                ),
              ),
            ]),
        body: const Center(
          child: Text("News"),
        ),
      ),
    );
  }
}

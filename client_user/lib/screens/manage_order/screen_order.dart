import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/modal/tables.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({super.key, required this.table});
  final Tables table;

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close, color: Colors.black)),
        title: Text(
          widget.table.Name!,
          style: textAppKanit,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5, top: 7),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text("Hello"),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: bgBlack, width: 5.0),
                      ),
                      foregroundColor: bgBlack,
                      backgroundColor: bgWhite,
                      padding:
                          const EdgeInsets.symmetric(vertical: sButtonHeight)),
                  onPressed: () {},
                  child: Text(
                    "Add Again",
                    style: textNormalQuicksanBold,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: bgBlack, width: 5.0),
                      ),
                      foregroundColor: bgWhite,
                      backgroundColor: bgBlack,
                      padding:
                          const EdgeInsets.symmetric(vertical: sButtonHeight)),
                  onPressed: () {},
                  child: Text(
                    "Add to Order",
                    style: textNormalQuicksanWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

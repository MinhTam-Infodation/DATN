import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/controller/manage_orderv3controller.dart';
import 'package:client_user/modal/tables.dart';
import 'package:client_user/screens/manage_order/components/cart_item_db.dart';
import 'package:client_user/screens/manage_order/components/cart_order.dart';
import 'package:client_user/screens/manage_order/screen_order.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key, required this.table});
  final Tables table;

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final OrderV2sController orderController = Get.put(OrderV2sController());
  var userId = "";

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    } else {
      userId = "";
    }

    orderController.fetchOrderDataFromFirestore(userId, widget.table.Id!);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close, color: Colors.black)),
        title: Text(
          "Order Detail",
          style: textAppKanit,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5, top: 7),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {
                Get.to(() => ScreenOrder(table: widget.table));
              },
              icon: const Icon(Icons.add),
              color: Colors.black,
            ),
          ),
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
      body: Column(
        children: [
          Obx(() {
            final order = orderController.order;
            if (order != null) {
              return CartOrder(order: order);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
          Container(
            height: 300,
            padding: const EdgeInsets.all(20),
            child: Obx(() {
              final orderDetailList = orderController.orderDetailList;
              if (orderDetailList.isNotEmpty) {
                return SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderDetailList.length,
                    itemBuilder: (context, index) {
                      final orderDetail = orderDetailList[index];
                      return CartItemDb(order: orderDetail);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // ignore: sized_box_for_whitespace
        child: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() {
                    final order = orderController.order;
                    if (order != null) {
                      return Text(
                        "Total: ${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(order.Total)}VND",
                        style: textAppKanit,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                ],
              ),
              Row(
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
                          padding: const EdgeInsets.symmetric(
                              vertical: sButtonHeight)),
                      onPressed: () => Get.back(),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: sButtonHeight)),
                      onPressed: () {},
                      child: Text(
                        "Create Order",
                        style: textNormalQuicksanWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

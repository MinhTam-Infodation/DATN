// ignore_for_file: avoid_print

import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/controller/getorderdbcontroller.dart';
import 'package:client_user/controller/manage_product.dart';
import 'package:client_user/controller/manager_order.dart';
import 'package:client_user/controller/order_local.dart';
import 'package:client_user/controller/order_second_main.dart';
import 'package:client_user/modal/order.dart';
import 'package:client_user/modal/tables.dart';
import 'package:client_user/screens/manage_order/components/cart_item_db.dart';
import 'package:client_user/screens/manage_order/components/cart_item_order.dart';
import 'package:client_user/screens/manage_order/components/modal_bottom_payment.dart';
import 'package:client_user/screens/manage_order/components/view_order_product.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({super.key, required this.table});
  final Tables table;

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder> {
  final productController = Get.put(ManageProductsController());
  final orderController = Get.put(OrderLocalController());
  final managerController = Get.put(ManagerOrderController());
  final orderFbController = Get.put(OrderSecondController());
  var userId = "";
  late final Orders order;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    } else {
      userId = "";
    }
    final size = MediaQuery.of(context).size;
    managerController.getListOrder(userId);
    orderController.getTotalQuantityOrder();
    final controller = Get.put(GetOrderController(widget.table.Id!));
    if (widget.table.Status == "Walting") {
      controller.getOrderbyTableId(userId, widget.table.Id!);
    }

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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    color: Colors.black,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 5, top: 7),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (widget.table.Status != "Walting")
                      ListDataOrder(
                          size: size,
                          productController: productController,
                          widget: widget)
                    else
                      Obx(() =>
                          Text("No Data ${controller.order.value.order!.Id}"))
                    // Column(
                    //   children: [
                    //     Obx(() {
                    //       if (controller.order.value.order?.OrderDetails !=
                    //           null) {
                    //         return SizedBox(
                    //           height: 550,
                    //           child: ListView.builder(
                    //             itemCount: controller
                    //                 .order.value.order?.OrderDetails?.length,
                    //             itemBuilder:
                    //                 (BuildContext context, int index) {
                    //               return CartItemDb(
                    //                   order: controller.order.value.order!
                    //                       .OrderDetails![index]);
                    //             },
                    //           ),
                    //         );
                    //       } else {
                    //         return const CircularProgressIndicator();
                    //       }
                    //     })
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: widget.table.Status != "Walting"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
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
                            onPressed: () {
                              Get.to(() => ViewOrderProducts(
                                    table: widget.table,
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Go to Order",
                                  style: textNormalQuicksanWhite,
                                ),
                                Obx(() => Text(orderController.totalOrder.value
                                    .toString()))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                  : Container(
                      height: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  "Total: ${controller.order.value.order?.Total}",
                                  style: textNormalKanitBold,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color: bgBlack, width: 5.0),
                                      ),
                                      foregroundColor: bgBlack,
                                      backgroundColor: bgWhite,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: sButtonHeight)),
                                  onPressed: () async {},
                                  child: Text(
                                    "Export Invoid",
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color: bgBlack, width: 5.0),
                                      ),
                                      foregroundColor: bgWhite,
                                      backgroundColor: bgBlack,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: sButtonHeight)),
                                  onPressed: () => showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        topRight: Radius.circular(50.0),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => ModalBottomPayment(
                                        order: controller.order.value.order!),
                                  ),
                                  child: Text(
                                    "Payment",
                                    style: textNormalQuicksanWhite,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
            )));
  }
}

class ListDataOrder extends StatelessWidget {
  const ListDataOrder({
    super.key,
    required this.size,
    required this.productController,
    required this.widget,
  });

  final Size size;
  final ManageProductsController productController;
  final ScreenOrder widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height - 150,
      width: size.width - 40,
      child: Obx(
        () {
          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => CartItemOrder(
              product: productController.product[index].products!,
              tables: widget.table,
            ),
            // ignore: invalid_use_of_protected_member
            itemCount: productController.product.value.length,
            padding: const EdgeInsets.only(bottom: 50 + 16),
            separatorBuilder: (context, index) => const SizedBox(height: 0),
          );
        },
      ),
    );
  }
}

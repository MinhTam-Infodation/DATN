import 'package:client_user/controller/manage_orderv3controller.dart';
import 'package:client_user/modal/tables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: const Text('Example Screen'),
      ),
      body: Column(
        children: [
          Obx(() {
            final order = orderController.order;
            if (order != null) {
              return Text('Order: ${order.Id}');
            } else {
              return const CircularProgressIndicator();
            }
          }),
          Obx(() {
            final orderDetailList = orderController.orderDetailList;
            if (orderDetailList.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: orderDetailList.length,
                itemBuilder: (context, index) {
                  final orderDetail = orderDetailList[index];
                  return ListTile(
                    title: Text(orderDetail.NameProduct.toString()),
                    subtitle: Text('Quantity: ${orderDetail.Quantity}'),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ],
      ),
    );
  }
}

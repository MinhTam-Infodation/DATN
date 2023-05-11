import 'package:client_user/modal/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerOrderController extends GetxController {
  static ManagerOrderController get instance => Get.find();

  RxList<OrdersSnapshot> orderLists = RxList<OrdersSnapshot>();
  final totalOrder = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      getListOrder(FirebaseAuth.instance.currentUser!.uid);
      checkTotalProduct(FirebaseAuth.instance.currentUser!.uid);
    }
  }

  getListOrder(String id) async {
    orderLists.bindStream(OrdersSnapshot.getListOrder(id));
  }

  checkTotalProduct(id) async {
    if (id != "") {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print("Checl Product" + id);
      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('Users');
      DocumentReference userDocRef = usersRef.doc(id);
      CollectionReference productsRef = userDocRef.collection('Orders');
      productsRef.get().then((querySnapshot) {
        int numProducts = querySnapshot.docs.length;
        // ignore: avoid_print
        print('Số lượng order: $numProducts');
        totalOrder(numProducts);
      });
    }
  }

  void addOrderSeller(String idUser, Orders seller) {
    OrdersSnapshot.themMoiAutoId(seller, idUser)
        .then((_) => {
              Get.snackbar('Success', "Add Order Success",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.greenAccent.withOpacity(0.1),
                  colorText: Colors.black)
            })
        .catchError((err) => {
              Get.snackbar('Error', err.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.greenAccent.withOpacity(0.1),
                  colorText: Colors.black)
            });
  }

  void updateOrder(String idUser, Orders seller) {
    OrdersSnapshot.updateOrder(seller, idUser)
        .then((_) => {
              Get.snackbar('Success', "Update Order Success",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.greenAccent.withOpacity(0.1),
                  colorText: Colors.black)
            })
        .catchError((err) => {
              Get.snackbar('Error', err.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.greenAccent.withOpacity(0.1),
                  colorText: Colors.black)
            });
  }

  void deleteOrder(String idUser, Orders order) {
    OrdersSnapshot.deleteOrder(order, idUser)
        .then((_) => {
              Get.snackbar('Success', "Update Order Success",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.greenAccent.withOpacity(0.1),
                  colorText: Colors.black),
              // ignore: list_remove_unrelated_type
              orderLists.remove(order)
            })
        .catchError((err) => {
              Get.snackbar('Error', err.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.greenAccent.withOpacity(0.1),
                  colorText: Colors.black)
            });
  }
}

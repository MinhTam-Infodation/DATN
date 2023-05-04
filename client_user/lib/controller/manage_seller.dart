import 'package:client_user/controller/home_controller.dart';
import 'package:client_user/modal/sellers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageSellerController extends GetxController {
  RxList<SellerSnapshot> users = RxList<SellerSnapshot>();
  final CollectionReference tablesRef =
      FirebaseFirestore.instance.collection('Users');
  static ManageSellerController get instance => Get.find();

  // Input variable
  final name = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final salary = TextEditingController();
  final sex = TextEditingController();
  final age = TextEditingController();
  final birthday = TextEditingController();

  final homeController = Get.put(HomeController());

  getListSeller(String id) async {
    users.bindStream(SellerSnapshot.dsSellerTuFirebase(id));
  }

  void addNewSeller(String id, Seller seller) {
    SellerSnapshot.themMoiAutoId(seller, id)
        .then((_) => {
              Get.snackbar('Success', "Add Seller Success",
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

    homeController.checkTotalTable(id);
  }

  void deleteSeller(String id, String tableId) async {
    await tablesRef
        .doc(id)
        .collection("Sellers")
        .doc(tableId)
        .delete()
        .then((_) => {
              Get.snackbar('Success', "Remove Seller Success",
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
    homeController.checkTotalTable(id);
  }

  void editTable(String userid, Seller tables, String tableId) async {
    await tablesRef
        .doc(userid)
        .collection("Sellers")
        .doc(tableId)
        .update(tables.toJson())
        .then((_) => {
              Get.snackbar('Success', "Edit Seller Success",
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
    getListSeller(userid);
  }
}

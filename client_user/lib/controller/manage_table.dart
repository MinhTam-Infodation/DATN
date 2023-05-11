import 'package:client_user/controller/home_controller.dart';
import 'package:client_user/modal/tables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageTableController extends GetxController {
  RxList<TableSnapshot> users = RxList<TableSnapshot>();
  final CollectionReference tablesRef =
      FirebaseFirestore.instance.collection('Users');
  static ManageTableController get instance => Get.find();
  var userId = "";

  // Input variable
  final name = TextEditingController();
  final slot = TextEditingController();

  final homeController = Get.put(HomeController());

  void addNewTable(String id, Tables table) {
    TableSnapshot.themMoiAutoId(table, id)
        .then((_) => {
              Get.snackbar('Success', "Add Table Success",
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

  getListTable(String id) async {
    users.bindStream(TableSnapshot.dsUserTuFirebase(id));
  }

  void deleteTable(String id, String tableId) async {
    await tablesRef
        .doc(id)
        .collection("Tables")
        .doc(tableId)
        .delete()
        .then((_) => {
              Get.snackbar('Success', "Remove Table Success",
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

  void editTable(String userid, Tables tables, String tableId) async {
    await tablesRef
        .doc(userid)
        .collection("Tables")
        .doc(tableId)
        .update(tables.toJson())
        .then((_) => {
              Get.snackbar('Success', "Edit Table Success",
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
    getListTable(userid);
  }
}
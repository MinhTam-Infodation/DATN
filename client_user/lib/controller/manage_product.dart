import 'package:client_user/controller/home_controller.dart';
import 'package:client_user/modal/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageProductsController extends GetxController {
  RxList<ProductsSnapshot> product = RxList<ProductsSnapshot>();
  final CollectionReference productRef =
      FirebaseFirestore.instance.collection('Users');
  static ManageProductsController get instance => Get.find();

  // Input variable
  final name = TextEditingController();
  final description = TextEditingController();
  final type = TextEditingController();
  final price = TextEditingController();
  final priceSale = TextEditingController();
  final sale = TextEditingController();
  final unit = TextEditingController();

  final homeController = Get.put(HomeController());

  @override
  void onInit() {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      getListProduct(FirebaseAuth.instance.currentUser!.uid);
    }
  }

  // Fun
  getListProduct(String id) async {
    product.bindStream(ProductsSnapshot.dsUserTuFirebase(id));
  }

  void searchProducts(String keyword) {
    final dataSearch = FirebaseFirestore.instance
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: keyword)
        // ignore: prefer_interpolation_to_compose_strings
        .where('name', isLessThanOrEqualTo: keyword + '\uf8ff')
        .snapshots();
    dataSearch.listen((snapshot) {
      product.value = snapshot.docs
          .map((doc) => ProductsSnapshot.fromSnapshot(doc))
          .toList();
    });
  }

  void addNewProduct(String id, Products products) {
    ProductsSnapshot.themMoiAutoId(products, id)
        .then((_) => {
              Get.snackbar('Success', "Add Product Success",
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

    homeController.checkTotalProduct(id);
  }

  void editTable(String userid, Products tables, String tableId) async {
    await productRef
        .doc(userid)
        .collection("Products")
        .doc(tableId)
        .update(tables.toJson())
        .then((_) => {
              Get.snackbar('Success', "Edit Product Success",
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
    getListProduct(userid);
  }

  void deleteSeller(String id, String tableId) async {
    await productRef
        .doc(id)
        .collection("Products")
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
}

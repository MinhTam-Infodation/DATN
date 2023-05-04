import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final totalTable = 0.obs;
  final totalProduct = 0.obs;
  final totalSeller = 0.obs;

  checkTotalTable(id) async {
    if (id != "") {
      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('Users');
      DocumentReference userDocRef = usersRef.doc(id);
      CollectionReference productsRef = userDocRef.collection('Tables');
      productsRef.get().then((querySnapshot) {
        int numProducts = querySnapshot.docs.length;
        // ignore: avoid_print
        print('Số lượng sản phẩm: $numProducts');
        totalTable(numProducts);
      });
    }
  }

  checkTotalProduct(id) async {
    if (id != "") {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print("Checl Product" + id);
      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('Users');
      DocumentReference userDocRef = usersRef.doc(id);
      CollectionReference productsRef = userDocRef.collection('Products');
      productsRef.get().then((querySnapshot) {
        int numProducts = querySnapshot.docs.length;
        // ignore: avoid_print
        print('Số lượng sản phẩm: $numProducts');
        totalProduct(numProducts);
      });
    }
  }

  checkTotalSeller(id) async {
    if (id != "") {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('Users');
      DocumentReference userDoc = userCollection.doc(id);
      CollectionReference sellersCollection = userDoc.collection('Sellers');
      sellersCollection.get().then((querySnapshot) {
        int numProducts = querySnapshot.docs.length;
        // ignore: avoid_print
        print('Số lượng sản phẩm: $numProducts');
        totalSeller(numProducts);
      });
    }
  }
}

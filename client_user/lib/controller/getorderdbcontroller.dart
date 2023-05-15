import 'package:client_user/modal/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GetOrderController extends GetxController {
  static GetOrderController get instance => Get.find();
  Rx<OrdersSnapshot> order =
      Rx<OrdersSnapshot>(OrdersSnapshot(order: null, documentReference: null));
  final String tableId;
  GetOrderController(this.tableId);
  @override
  void onInit() {
    if (FirebaseAuth.instance.currentUser != null) {
      getOrderbyTableId(FirebaseAuth.instance.currentUser!.uid, tableId);
    }
    super.onInit();
  }

  getOrderbyTableId(String idUser, String idTable) {
    print("id" + idTable);
    order.bindStream(OrdersSnapshot.getOrderStream(idUser, idTable));
  }
}

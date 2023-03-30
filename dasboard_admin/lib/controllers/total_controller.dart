import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dasboard_admin/modals/users_modal.dart';
import 'package:get/get.dart';

class TotalController extends GetxController {
  static TotalController get find => Get.find();
  RxList<UserSnapshot>? list = RxList<UserSnapshot>([]);

  @override
  void onInit() {
    list?.bindStream(UserSnapshot.dsUserTuFirebase());
    super.onInit();
  }

  void getSinhviens() {
    UserSnapshot.dsUserTuFirebaseOneTime().then((value) {
      list?.value = value;
      list?.refresh();
    });
  }

  int countMyDocuments(RxList<UserSnapshot> documents) {
    return documents.length;
  }

  int countAdults(bool status) {
    return list!.where((snapshot) => snapshot.user!.Status == status).length;
  }
}

// ignore: camel_case_types
// class Binding_TotalController implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => TotalController(), tag: "dsuser");
//   }
// }

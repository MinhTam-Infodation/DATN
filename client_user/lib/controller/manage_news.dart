import 'package:client_user/modal/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManageSellerController extends GetxController {
  RxList<NewsSnapshot> news = RxList<NewsSnapshot>();
  final CollectionReference tablesRef =
      FirebaseFirestore.instance.collection('Admin');
  static ManageSellerController get instance => Get.find();
}

// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dasboard_admin/modals/users_modal.dart';
import 'package:get/get.dart';

class WaltingUserController extends GetxController {
  RxList<UserSnapshot> listUsers = RxList<UserSnapshot>();
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');

  final totalActive = 0.obs;
  final totalWalting = 0.obs;
  final totalAll = 0.obs;
  final userCountMonth1 = 0.obs;
  final userCountMonth2 = 0.obs;
  final userCountMonth3 = 0.obs;
  final userCountMonth4 = 0.obs;

  @override
  void onInit() {
    // Gọi phương thức lấy dữ liệu từ Firebase và gán cho biến users
    getListUser();
    countMyDocuments();
    countMyDocumentsWithStatusFalse();
    countMyDocumentsWithStatusTrue();
    countNewUsers();
    super.onInit();
  }

  void updateUserStatus(String userId) {
    usersRef.doc(userId).update({
      'Status': true,
    });
    countMyDocuments();
    countMyDocumentsWithStatusFalse();
    countMyDocumentsWithStatusTrue();
  }

  getListUser() async {
    listUsers.bindStream(UserSnapshot.dsUserTuFirebaseBool(false));
  }

  void countNewUsers() async {
    final currentDate = DateTime.now();
    final date4MonthsAgo =
        DateTime(currentDate.year, currentDate.month - 4, currentDate.day);
    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('CreatedAt',
            isGreaterThan: date4MonthsAgo.millisecondsSinceEpoch)
        .get();
    int Month1 = 0;
    int Month2 = 0;
    int Month3 = 0;
    int Month4 = 0;
    for (var doc in snapshot.docs) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(doc.data()['CreatedAt']);
      if (date.isAfter(currentDate.subtract(const Duration(days: 30)))) {
        Month1++;
      } else if (date.isAfter(currentDate.subtract(const Duration(days: 60)))) {
        Month2++;
      } else if (date.isAfter(currentDate.subtract(const Duration(days: 90)))) {
        Month3++;
      } else if (date
          .isAfter(currentDate.subtract(const Duration(days: 120)))) {
        Month4++;
      }
    }
    userCountMonth1(Month1);
    userCountMonth2(Month2);
    userCountMonth3(Month3);
    userCountMonth4(Month4);

    print("Month1 " +
        userCountMonth1.value.toString() +
        "Month2 " +
        userCountMonth2.value.toString() +
        "Month3 " +
        userCountMonth3.value.toString() +
        "Month4 " +
        userCountMonth4.value.toString());
  }

  void searchUser(String keyword) {
    final dataSearch = usersRef
        .where('Name', isGreaterThanOrEqualTo: keyword)
        // ignore: prefer_interpolation_to_compose_strings
        .where('Name', isLessThanOrEqualTo: keyword + '\uf8ff')
        .snapshots();
    dataSearch.listen((snapshot) {
      listUsers.value =
          snapshot.docs.map((doc) => UserSnapshot.fromSnapshot(doc)).toList();
    });
  }

  void countMyDocumentsWithStatusTrue() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('Status', isEqualTo: true)
        .get();
    totalActive(snapshot.docs.length);
    print("Active " + totalActive.value.toString());
  }

  void countMyDocumentsWithStatusFalse() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('Status', isEqualTo: false)
        .get();
    totalWalting(snapshot.docs.length);
    print("Walting " + totalWalting.value.toString());
  }

  void countMyDocuments() async {
    final snapshot = await FirebaseFirestore.instance.collection('Users').get();
    totalAll(snapshot.docs.length);
    // ignore: avoid_print
    print("All " + totalAll.value.toString());
  }
}

// ignore_for_file: non_constant_identifier_names, avoid_print

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
  final userCountByMonth = <int, RxInt>{};
  final numberOfMonths = 12;

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

  Future<void> countNewUsers() async {
    final currentDate = DateTime.now();
    final dateNMonthsAgo =
        currentDate.subtract(Duration(days: numberOfMonths * 30));

    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('CreatedAt', isGreaterThan: Timestamp.fromDate(dateNMonthsAgo))
        .get();

    // Khởi tạo số lượng người đăng ký cho từng tháng
    for (int i = 1; i <= numberOfMonths; i++) {
      userCountByMonth[i] = 0.obs;
    }

    for (var doc in snapshot.docs) {
      Timestamp createdAtTimestamp = doc.data()['CreatedAt'];
      DateTime createdAt = createdAtTimestamp.toDate();

      // Tính toán tháng và năm từ giá trị createdAt
      int monthDifference = currentDate.month - createdAt.month;
      int yearDifference = currentDate.year - createdAt.year;
      int monthIndex = numberOfMonths - (yearDifference * 12 + monthDifference);
      if (monthIndex >= 1 && monthIndex <= numberOfMonths) {
        userCountByMonth[monthIndex]?.value++;
      }
    }
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
    print("Active ${totalActive.value}");
  }

  void countMyDocumentsWithStatusFalse() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('Status', isEqualTo: false)
        .get();
    totalWalting(snapshot.docs.length);
    print("Walting ${totalWalting.value}");
  }

  void countMyDocuments() async {
    final snapshot = await FirebaseFirestore.instance.collection('Users').get();
    totalAll(snapshot.docs.length);
    print("All ${totalAll.value}");
  }
}

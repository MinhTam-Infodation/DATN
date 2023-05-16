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

  // void countNewUsers() async {
  //   final currentDate = DateTime.now();
  //   final date4MonthsAgo =
  //       DateTime(currentDate.year, currentDate.month - 4, currentDate.day);
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .where('CreatedAt',
  //           isGreaterThan: date4MonthsAgo.millisecondsSinceEpoch)
  //       .get();
  //   int Month1 = 0;
  //   int Month2 = 0;
  //   int Month3 = 0;
  //   int Month4 = 0;
  //   for (var doc in snapshot.docs) {
  //     DateTime date =
  //         DateTime.fromMillisecondsSinceEpoch(doc.data()['CreatedAt']);
  //     if (date.isAfter(currentDate.subtract(const Duration(days: 30)))) {
  //       Month1++;
  //     } else if (date.isAfter(currentDate.subtract(const Duration(days: 60)))) {
  //       Month2++;
  //     } else if (date.isAfter(currentDate.subtract(const Duration(days: 90)))) {
  //       Month3++;
  //     } else if (date
  //         .isAfter(currentDate.subtract(const Duration(days: 120)))) {
  //       Month4++;
  //     }
  //   }
  //   userCountMonth1(Month1);
  //   userCountMonth2(Month2);
  //   userCountMonth3(Month3);
  //   userCountMonth4(Month4);

  //   print(
  //       "Month1 ${userCountMonth1.value}Month2 ${userCountMonth2.value}Month3 ${userCountMonth3.value}Month4 ${userCountMonth4.value}");
  // }
  void countNewUsers() async {
    final currentDate = DateTime.now();
    final dateNMonthsAgo =
        currentDate.subtract(Duration(days: numberOfMonths * 30));

    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('CreatedAt',
            isGreaterThan: dateNMonthsAgo.millisecondsSinceEpoch)
        .get();

    // Khởi tạo số lượng người đăng ký cho từng tháng
    for (int i = 1; i <= numberOfMonths; i++) {
      userCountByMonth[i] = 0.obs;
    }

    for (var doc in snapshot.docs) {
      int createdAt = doc.data()['CreatedAt'];

      // Tính toán tháng và năm từ giá trị createdAt
      DateTime createdAtDateTime =
          DateTime.fromMillisecondsSinceEpoch(createdAt);
      int month = createdAtDateTime.month;
      int year = createdAtDateTime.year;

      // Tính toán tháng và tăng số lượng người đăng ký tương ứng
      int monthDifference = currentDate.month - month;
      int yearDifference = currentDate.year - year;
      int monthIndex = numberOfMonths - (yearDifference * 12 + monthDifference);
      if (monthIndex >= 1 && monthIndex <= numberOfMonths) {
        userCountByMonth[monthIndex]?.value++;
      }
    }

    // In ra kết quả
    for (int i = 1; i <= numberOfMonths; i++) {
      print('Month $i: ${userCountByMonth[i]?.value ?? 0}');
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

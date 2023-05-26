// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dasboard_admin/controllers/waltinguser_controller.dart';
import 'package:dasboard_admin/modals/users_modal.dart';
import 'package:get/get.dart';

class TotalController extends GetxController {
  RxList<UserSnapshot> users = RxList<UserSnapshot>();
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');
  final walt = Get.put(WaltingUserController());

  @override
  void onInit() {
    // Gọi phương thức lấy dữ liệu từ Firebase và gán cho biến users
    users.bindStream(UserSnapshot.dsUserTuFirebase());
    super.onInit();
  }

  void getSinhviens() async {
    final value = await UserSnapshot.dsUserTuFirebaseOneTime();
    users.value = value;
    users.refresh();
  }

  getListUser() async {
    users.bindStream(UserSnapshot.dsUserTuFirebase());
  }

  void searchUser(String keyword) {
    final dataSearch = usersRef
        .where('Name', isGreaterThanOrEqualTo: keyword)
        // ignore: prefer_interpolation_to_compose_strings
        .where('Name', isLessThanOrEqualTo: keyword + '\uf8ff')
        .snapshots();
    dataSearch.listen((snapshot) {
      users.value =
          snapshot.docs.map((doc) => UserSnapshot.fromSnapshot(doc)).toList();
    });
  }

  void sendNotificationToUser(String userToken, String notificationTitle,
      String notificationBody) async {
    const String serverKey =
        'AAAAAQaiVfI:APA91bGn_dXpSEwAU7qg4WXV54tdS15B_LcFRN5ubCnLkcijDOzXHJRVfcnO0GNs_kiSZahvjVuAe64VwT5rQQVK0GcJHhjq2RaegF7NXK-EUChoqIgPOe9_yPzEsSxsn9Z9CDmH1KOj';
    const String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

    Map<String, dynamic> notificationData = {
      'to': userToken,
      'notification': {
        'title': notificationTitle,
        'body': notificationBody,
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      },
    };
  }

  void searchProductByName(String productName) {
    List<UserSnapshot> searchedTables = users
        .where((table) =>
            table.user!.Name!.toLowerCase().contains(productName.toLowerCase()))
        .toList();
    users.value = searchedTables;
  }

  void updateUserStatus(String userId, bool status) {
    usersRef.doc(userId).update({
      'Status': status,
    });
    walt.countMyDocuments();
    walt.countMyDocumentsWithStatusFalse();
    walt.countMyDocumentsWithStatusTrue();
  }

  int countUsersByMonth(int month) {
    int count = 0;

    for (var user in users) {
      DateTime orderTime =
          DateTime.fromMillisecondsSinceEpoch(user.user!.CreatedAt!);
      if (orderTime.month == month) {
        count++;
      }
    }

    return count;
  }

  int countMyDocuments(RxList<UserSnapshot> documents) {
    return documents.length;
  }

  int countAdults(bool status) {
    return users.where((snapshot) => snapshot.user!.Status == status).length;
  }

  void searchUsers(List<Map<String, dynamic>> queries) async {
    try {
      Query<Object?> query = usersRef;
      for (var q in queries) {
        query = query.where(q['field'], isEqualTo: q['value']);
      }
      var snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        users.assignAll(snapshot.docs
            .map((doc) => UserSnapshot.fromSnapshot(doc))
            .toList());
      } else {
        users = ((await usersRef.get()) as RxList<UserSnapshot>?)!;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // Phương thức tìm kiếm theo tên
  List<UserSnapshot> searchByName(String name) {
    return users
        .where((user) =>
            user.user!.Name!.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  Future<void> addUser(User user) async {
    await usersRef.add(user.toJson());
  }

  Future<void> updateUser(String id, User user) async {
    await usersRef.doc(id).update(user.toJson());
  }

  Future<void> deleteUser(String id) async {
    await usersRef.doc(id).delete();
  }
}

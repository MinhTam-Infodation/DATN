// ignore_for_file: non_constant_identifier_names

import 'package:client_user/modal/order_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  int? CreateDate, Total;
  bool? Status;
  String? Seller, TableId, TableName, Id;
  late List<OrderDetail>? OrderDetails;

  Orders(
      {this.Id,
      this.TableId,
      this.TableName,
      this.CreateDate,
      this.Total,
      this.Status,
      this.Seller,
      this.OrderDetails});

  factory Orders.fromJson(Map<String, dynamic> map) {
    var orderDetailJson = map['Images'] as List<dynamic>;
    List<OrderDetail> orderDetail = orderDetailJson
        .map((imageJson) => OrderDetail.fromJson(imageJson))
        .toList();

    return Orders(
      Id: map['Id'],
      TableId: map['TableId'],
      TableName: map['TableName'],
      CreateDate: map['CreateDate'],
      Total: map['Total'],
      Status: map['Status'],
      Seller: map['Seller'],
      OrderDetails: orderDetail,
    );
  }

  Map<String, dynamic> toJson() {
    var oderDetailJson = OrderDetails!.map((image) => image.toJson()).toList();
    return {
      'Id': Id,
      'TableId': TableId,
      'TableName': TableName,
      'CreateDate': CreateDate,
      'Total': Total,
      'Status': Status,
      'Seller': Seller,
      'OrderDetails': oderDetailJson,
    };
  }
}

class OrdersSnapshot {
  Orders? order;
  DocumentReference? documentReference;

  OrdersSnapshot({
    required this.order,
    required this.documentReference,
  });

  factory OrdersSnapshot.fromSnapshot(DocumentSnapshot docSnapUser) {
    return OrdersSnapshot(
        order: Orders.fromJson(docSnapUser.data() as Map<String, dynamic>),
        documentReference: docSnapUser.reference);
  }

  Future<void> xoa() async {
    return documentReference!.delete();
  }

  static Future<void> deleteOrder(Orders order, String userId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(order.Id)
        .delete();
  }

  static Future<void> updateOrder(Orders order, String userId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(order.Id)
        .update(order.toJson());
  }

  static Future<DocumentReference> themMoi(Orders order, String idUser) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(idUser)
        .collection("Orders")
        .add(order.toJson());
  }

  static Future<void> themMoiAutoId(Orders order, String idUser) async {
    CollectionReference usersRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(idUser)
        .collection("Orders");
    DocumentReference newDocRef = usersRef.doc();
    order.Id = newDocRef.id;
    await newDocRef.set(order.toJson());
  }

  static Stream<List<OrdersSnapshot>> getListOrder(String idUser) {
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance
        .collection("Users")
        .doc(idUser)
        .collection("Orders")
        .snapshots();
    // ignore: unnecessary_null_comparison
    if (qs == null) return const Stream.empty();
    Stream<List<DocumentSnapshot>> listDocSnap =
        qs.map((querySn) => querySn.docs);
    return listDocSnap.map((listDocSnap) => listDocSnap
        .map((docSnap) => OrdersSnapshot.fromSnapshot(docSnap))
        .toList());
  }

  static Future<List<OrdersSnapshot>> dsUserTuFirebaseOneTime(
      String idUser) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("Users")
        .doc(idUser)
        .collection("Orders")
        .get();
    return qs.docs
        .map((docSnap) => OrdersSnapshot.fromSnapshot(docSnap))
        .toList();
  }
}

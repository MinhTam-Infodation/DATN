import 'dart:async';

import 'package:client_user/modal/order.dart';
import 'package:client_user/modal/order_detail.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderV2sController extends GetxController {
  final Rx<Orders?> _order = Rx<Orders?>(null);
  final RxList<OrderDetail> _orderDetailList = RxList<OrderDetail>([]);

  Orders? get order => _order.value;
  List<OrderDetail> get orderDetailList => _orderDetailList;

  void fetchOrderDataFromFirestore(String userId, String tableId) {
    final ordersRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Orders')
        .where('TableId', isEqualTo: tableId);

    final orderStream = ordersRef.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => Orders.fromJson(doc.data()))
              .firstWhere(
                // ignore: unnecessary_null_comparison
                (order) => order != null,
                orElse: () => Orders(),
              ),
        );

    _order.bindStream(orderStream);

    _orderDetailList.bindStream(_orderDetailStream(userId));
  }

  double get totalPrice => orderDetailList.fold(
      0, (sum, item) => sum + (item.Price! * item.Quantity!));

  Stream<List<OrderDetail>> _orderDetailStream(String userId) {
    return _order.map((order) {
      if (order != null) {
        final orderDetailsRef = FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('Orders')
            .doc(order.Id)
            .collection('OrderDetail');

        return orderDetailsRef.snapshots().map(
              (querySnapshot) => querySnapshot.docs
                  .map((doc) => OrderDetail.fromJson(doc.data()))
                  .toList(),
            );
      } else {
        return Stream.value([]);
      }
    }).transform(
      StreamTransformer.fromHandlers(
        handleData: (streamData, sink) {
          streamData.listen(sink.add as void Function(List event)?).onDone(() {
            sink.close();
          });
        },
      ),
    );
  }

  Future<void> addOrUpdateOrderDetailOnFirestore(
      OrderDetail orderDetail, String userId, String orderId) async {
    final orderDetailsRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Orders')
        .doc(orderId)
        .collection('OrderDetail');

    final existingOrderDetailsSnapshot = await orderDetailsRef
        .where('NameProduct', isEqualTo: orderDetail.NameProduct)
        .get();

    if (existingOrderDetailsSnapshot.docs.isNotEmpty) {
      // Nếu đã tồn tại orderDetail với NameProduct tương tự, thực hiện cập nhật Quantity
      final existingOrderDetailDoc = existingOrderDetailsSnapshot.docs.first;
      final existingQuantity = existingOrderDetailDoc.data()['Quantity'] as int;
      final newQuantity = existingQuantity + 1;

      await existingOrderDetailDoc.reference.update({'Quantity': newQuantity});
    } else {
      // Nếu không tồn tại orderDetail với NameProduct tương tự, thực hiện thêm mới
      OrderDetailSnapshot.themMoiAutoId(orderDetail, userId, orderId);
    }
  }

  void updateOrderDetail(
      OrderDetail orderDetail, String userId, String orderId) {
    // Update the existing order detail in the Firestore collection
    if (orderDetail.Quantity == 0) {
      deleteOrderDetail(orderDetail, userId, orderId);
    } else {
      final orderDetailsRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .doc(order!.Id)
          .collection('OrderDetail')
          .doc(orderDetail.Id);

      orderDetailsRef.update(orderDetail.toJson());
    }
  }

  void deleteOrderDetail(
      OrderDetail orderDetail, String idUser, String idOrder) {
    // Delete the order detail from the Firestore collection
    final orderDetailsRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(idUser)
        .collection('Orders')
        .doc(idOrder)
        .collection('OrderDetail')
        .doc(orderDetail.Id);

    orderDetailsRef.delete();
  }
}

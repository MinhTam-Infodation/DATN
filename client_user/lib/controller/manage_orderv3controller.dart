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
}

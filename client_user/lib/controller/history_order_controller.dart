import 'dart:async';

import 'package:client_user/modal/order_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryOrderV2Controller extends GetxController {
  final RxList<OrdersHistory> _orderDetailList = RxList<OrdersHistory>([]);

  void bindOrdersHistoryStream(id) {
    final collectionRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection('OrdersHistory');

    collectionRef.snapshots().listen((querySnapshot) {
      final List<OrdersHistory> historyList = querySnapshot.docs
          .map((doc) => OrdersHistory.fromJson(doc.data()))
          .toList();
      _orderDetailList.value = historyList;
    });
  }

  double get totalPayment {
    double total = 0.0;
    for (final orderHistory in _orderDetailList) {
      if (orderHistory.orderDetail != null) {
        for (final orderDetail in orderHistory.orderDetail!) {
          total += orderDetail.Price! * orderDetail.Quantity!;
        }
      }
    }
    return total;
  }

  double getTotalPaymentByMonth(int month, int year) {
    double total = 0.0;
    for (final orderHistory in _orderDetailList) {
      final createdAt = orderHistory.order!.CreateDate;
      final orderMonth = DateTime.fromMillisecondsSinceEpoch(createdAt!).month;
      final orderYear = DateTime.fromMillisecondsSinceEpoch(createdAt).year;

      if (orderMonth == month && orderYear == year) {
        if (orderHistory.orderDetail != null) {
          for (final orderDetail in orderHistory.orderDetail!) {
            total += orderDetail.Price! * orderDetail.Quantity!;
          }
        }
      }
    }
    return total;
  }
}


// import 'package:intl/intl.dart';

// class OrdersHistoryScreen extends StatelessWidget {
//   final OrdersHistoryController _controller = Get.put(OrdersHistoryController());
//   final DateTime now = DateTime.now();
//   final int month = DateTime.now().month;
//   final int year = DateTime.now().year;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Orders History'),
//       ),
//       body: Column(
//         children: [
//           Text(
//             'Total Payment for ${DateFormat('MMMM yyyy').format(now)}: \$${_controller.getTotalPaymentByMonth(month, year).toStringAsFixed(2)}',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10),
//           Obx(() {
//             final ordersHistoryList = _controller.ordersHistoryList;
//             if (ordersHistoryList.isEmpty) {
//               return Center(child: Text('No orders history available.'));
//             }
//             return Expanded(
//               child: ListView.builder(
//                 itemCount: ordersHistoryList.length,
//                 itemBuilder: (context, index) {
//                   final orderHistory = ordersHistoryList[index];
//                   // Hiển thị thông tin của orderHistory
//                   return ListTile(
//                     title: Text(orderHistory.orderName),
//                     subtitle: Text(orderHistory.orderStatus),
//                     // ...
//                   );
//                 },
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

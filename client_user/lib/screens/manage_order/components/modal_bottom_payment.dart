import 'package:client_user/constants/string_context.dart';
import 'package:client_user/controller/manage_history_order_controller.dart';
import 'package:client_user/modal/order.dart';
import 'package:client_user/modal/order_detail.dart';
import 'package:client_user/modal/order_history.dart';
import 'package:client_user/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ModalBottomPayment extends StatefulWidget {
  ModalBottomPayment({super.key, required this.order, required this.listOrder});

  Orders order;
  final List<OrderDetail> listOrder;

  @override
  State<ModalBottomPayment> createState() => _ModalBottomPaymentState();
}

class _ModalBottomPaymentState extends State<ModalBottomPayment> {
  var userId = "";

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    } else {
      userId = "";
    }
    final orderHistoryController = Get.put(ManageHistoryOrderController());

    return Container(
      height: 420,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tPaymentOrderTitle,
              style: textBigKanit,
            ),
            Text(
              tPaymentOrderDes,
              style: textNormalQuicksan,
            ),
            const SizedBox(
              height: 30,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.qr_code,
              title: tPaymentQRCodeOption,
              subTitle: tPaymentQRCodeOptionDes,
              onTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.payment,
              title: tPaymentCashOption,
              subTitle: tPaymentCashOptionDes,
              onTap: () {
                final order = OrdersHistory(
                    Id: "",
                    order: widget.order,
                    PaymentMenthod: "Cash",
                    orderDetail: widget.listOrder,
                    PaymentTime: convertInputDateTimetoNumber(DateTime.now()));
                orderHistoryController.addNewOrderHistory(userId, order);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.payments_outlined,
              title: tPaymentPayPalOption,
              subTitle: tPaymentPayPalOptionDes,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

convertInputDateTimetoNumber(DateTime tiem) {
  int timestamp = tiem.millisecondsSinceEpoch;
  return timestamp;
}

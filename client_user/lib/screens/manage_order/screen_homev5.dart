// ignore_for_file: deprecated_member_use, prefer_const_declarations

import 'dart:io';

import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/controller/manage_orderv3controller.dart';
import 'package:client_user/modal/order_detail.dart';
import 'package:client_user/modal/tables.dart';
import 'package:client_user/screens/manage_order/components/cart_item_db.dart';
import 'package:client_user/screens/manage_order/components/cart_order.dart';
import 'package:client_user/screens/manage_order/screen_order.dart';
import 'package:client_user/screens/manage_order/screen_update_order.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

// ignore: use_key_in_widget_constructors
class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key, required this.table});
  final Tables table;

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final OrderV2sController orderController = Get.put(OrderV2sController());
  var userId = "";

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    } else {
      userId = "";
    }

    orderController.fetchOrderDataFromFirestore(userId, widget.table.Id!);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close, color: Colors.black)),
          title: Text(
            "Order Detail",
            style: textAppKanit,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 5, top: 7),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {
                  exportInvoiceToPDF(orderController.orderDetailList);
                },
                icon: const Icon(Icons.import_export),
                color: Colors.black,
              ),
            )
          ]),
      body: Column(
        children: [
          Obx(() {
            final order = orderController.order;
            if (order != null) {
              return CartOrder(order: order);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
          Container(
            height: 330,
            padding: const EdgeInsets.all(20),
            child: Obx(() {
              final orderDetailList = orderController.orderDetailList;
              if (orderDetailList.isNotEmpty) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: 330,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderDetailList.length,
                      itemBuilder: (context, index) {
                        final orderDetail = orderDetailList[index];
                        return CartItemDb(order: orderDetail);
                      },
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // ignore: sized_box_for_whitespace
        child: Container(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: bgBlack, width: 5.0),
                          ),
                          foregroundColor: bgBlack,
                          backgroundColor: bgWhite,
                          padding: const EdgeInsets.symmetric(
                              vertical: sButtonHeight)),
                      onPressed: () {
                        if (orderController.orderDetailList.isNotEmpty &&
                            orderController.order != null) {
                          Get.to(() => ScreenUpdateOrder(
                                table: widget.table,
                                listOrder: orderController.orderDetailList,
                                order: orderController.order!,
                              ));
                        }
                      },
                      child: Text(
                        "Update Order",
                        style: textNormalQuicksanBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: bgBlack, width: 5.0),
                          ),
                          foregroundColor: bgWhite,
                          backgroundColor: bgBlack,
                          padding: const EdgeInsets.symmetric(
                              vertical: sButtonHeight)),
                      onPressed: () {},
                      child: Text(
                        "Payment",
                        style: textNormalQuicksanWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> exportInvoiceToPDF(List<OrderDetail> orderDetails) async {
    final robotoRegular =
        await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttfFont = pw.Font.ttf(robotoRegular);
    final pdf = pw.Document();

    // ignore: unused_local_variable
    final pageFormat = PdfPageFormat.a6;

    // Tạo danh sách các tiêu đề cột
    final headers = ['ID', 'Tên sản phẩm', 'Số lượng', 'Đơn giá'];

    // Tạo danh sách các dòng dữ liệu
    final data = orderDetails.map((detail) {
      return [
        detail.Id.toString(),
        detail.NameProduct,
        detail.Quantity.toString(),
        detail.Price.toString(),
      ];
    }).toList();

    // Tạo bảng và điền dữ liệu
    final table = pw.Table.fromTextArray(
      headers: headers,
      data: data,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttfFont),
      border: pw.TableBorder.all(),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      cellAlignments: {0: pw.Alignment.center},
    );

    // Thêm nội dung hóa đơn vào tài liệu PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Center(
              child: pw.Text('Nội dung hóa đơn',
                  style: pw.TextStyle(
                      font: ttfFont)), // Thay thế bằng nội dung hóa đơn thực tế
            ),
            table
          ]);
        },
      ),
    );

    // Xuất file PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/invoice.pdf');
    await file.writeAsBytes(await pdf.save());

    // Hiển thị file PDF
    // await Printing.sharePdf(
    //     bytes: await file.readAsBytes(), filename: 'invoice.pdf');
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}

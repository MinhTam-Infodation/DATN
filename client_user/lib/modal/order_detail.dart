// ignore_for_file: non_constant_identifier_names

import 'package:client_user/modal/products.dart';
import 'package:client_user/modal/tables.dart';
import 'package:get/get.dart';

class OrderDetail {
  String? Unit, IdProduct, NameProduct;
  int? Price, Quantity;

  OrderDetail(
      {this.IdProduct, this.NameProduct, this.Price, this.Quantity, this.Unit});

  // hàm tạo từ Json object
  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      Unit: json['Unit'],
      IdProduct: json['IdProduct'],
      NameProduct: json['NameProduct'],
      Price: json['Price'],
      Quantity: json['Quantity'],
    );
  }

  // chuyển đổi thành Json object
  Map<String, dynamic> toJson() {
    return {
      'Unit': Unit,
      'IdProduct': IdProduct,
      'NameProduct': NameProduct,
      'Price': Price,
      'Quantity': Quantity
    };
  }
}

class OrderDetailLocal {
  Products? products;
  RxInt Quantity;
  Tables? tables;

  OrderDetailLocal({this.products, int Quantity = 0, this.tables})
      : Quantity = Quantity.obs;
}

class OrderDetailFireBase {
  String? Unit, IdProduct, NameProduct;
  RxInt Quantity;
  int? Price;

  OrderDetailFireBase(
      {this.IdProduct,
      this.NameProduct,
      this.Price,
      int Quantity = 0,
      this.Unit})
      : Quantity = Quantity.obs;
}

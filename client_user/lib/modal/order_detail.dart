// ignore_for_file: non_constant_identifier_names

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

import 'package:client_user/constants/string_button.dart';
import 'package:client_user/controller/home_controller.dart';
import 'package:client_user/controller/manage_seller.dart';
import 'package:client_user/modal/sellers.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ModalBottomFunSeller extends StatefulWidget {
  ModalBottomFunSeller(
      {super.key, required this.seller, required this.viewMode});

  Seller seller;
  bool viewMode;

  @override
  State<ModalBottomFunSeller> createState() => _ModalBottomFunSellerState();
}

class _ModalBottomFunSellerState extends State<ModalBottomFunSeller> {
  // ignore: no_leading_underscores_for_local_identifiers, unused_field
  final _formKey = GlobalKey<FormState>();
  var userId = "";

  final sellerController = Get.put(ManageSellerController());
  final homeController = Get.put(HomeController());

  late TextEditingController txtName;
  late TextEditingController txtEmail;
  late TextEditingController txtAddress;
  late TextEditingController txtPhone;
  late TextEditingController txtSalary;
  late TextEditingController txtSex;
  late TextEditingController txtAge;
  late TextEditingController txtBirthday;

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtEmail = TextEditingController();
    txtAddress = TextEditingController();
    txtPhone = TextEditingController();
    txtSalary = TextEditingController();
    txtSex = TextEditingController();
    txtAge = TextEditingController();
    txtBirthday = TextEditingController();

    DateTime tsdate =
        DateTime.fromMillisecondsSinceEpoch(widget.seller.Birthday!);

    txtName.text = widget.seller.Name!;
    txtEmail.text = widget.seller.Email!;
    txtAddress.text = widget.seller.Address!;
    txtPhone.text = widget.seller.Phone!;
    txtSalary.text = widget.seller.Salary!;
    txtSex.text = widget.seller.Sex!;
    txtAge.text = widget.seller.Age!.toString();
    txtBirthday.text = DateFormat('yyyy-MM-dd').format(tsdate);
  }

  @override
  void dispose() {
    txtName.dispose();
    txtEmail.dispose();
    txtAddress.dispose();
    txtPhone.dispose();
    txtSalary.dispose();
    txtSex.dispose();
    txtAge.dispose();
    txtBirthday.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    } else {
      userId = "";
    }

    homeController.checkTotalSeller(userId);
    return Container(
      height: 500,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          child: Text(
                            widget.viewMode ? "Edit" : "Detail",
                            style: textAppKanit,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      weight: 900,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      enabled: widget.viewMode,
                      controller: txtName,
                      decoration: InputDecoration(
                          labelStyle: textSmallQuicksan,
                          prefixIcon: const Icon(Icons.abc),
                          labelText: tInputNameSeller,
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      enabled: widget.viewMode,
                      controller:
                          txtBirthday, //editing controller of this TextField
                      decoration: InputDecoration(
                          labelStyle: textSmallQuicksan,
                          prefixIcon: const Icon(Icons.abc),
                          labelText: tInputBirthdaySeller,
                          border: const OutlineInputBorder()),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          // ignore: avoid_print
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          // ignore: avoid_print
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            txtBirthday.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          // ignore: avoid_print
                          print("Date is not selected");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: widget.viewMode,
                      controller: txtAddress,
                      decoration: InputDecoration(
                          labelStyle: textSmallQuicksan,
                          prefixIcon: const Icon(Icons.numbers),
                          labelText: tInputAdressSeller,
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: widget.viewMode,
                      controller: txtEmail,
                      decoration: InputDecoration(
                          labelStyle: textSmallQuicksan,
                          prefixIcon: const Icon(Icons.email),
                          labelText: tInputEmailSeller,
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: widget.viewMode,
                      controller: txtPhone,
                      decoration: InputDecoration(
                          labelStyle: textSmallQuicksan,
                          prefixIcon: const Icon(Icons.phone),
                          labelText: tInputPhone,
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: widget.viewMode,
                      controller: txtSalary,
                      decoration: InputDecoration(
                          labelStyle: textSmallQuicksan,
                          prefixIcon: const Icon(Icons.money),
                          labelText: tInputSalarySeller,
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: widget.viewMode,
                      controller: txtSex,
                      decoration: InputDecoration(
                          labelStyle: textSmallQuicksan,
                          prefixIcon: const Icon(Icons.person),
                          labelText: tInputSexSeller,
                          border: const OutlineInputBorder()),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    // ignore: sized_box_for_whitespace
                    if (!widget.viewMode)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   tableController.deleteTable(
                            //       userId, widget.table.Id!);
                            //   // Back
                            //   Navigator.pop(context);
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const StadiumBorder(),
                            foregroundColor: bgBlack,
                            backgroundColor: Colors.redAccent.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                          ),
                          child: Text(
                            "Delete Seller",
                            style: textXLQuicksanBold,
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // // ignore: avoid_print
                            // print(widget.table.Id!);
                            // final table = Tables(
                            //     Id: widget.table.Id!,
                            //     Name: txtName.text,
                            //     Status: false,
                            //     Slot: int.parse(txtSlot.text));
                            // tableController.editTable(
                            //     userId, table, widget.table.Id!);
                            // // Back
                            // Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const StadiumBorder(),
                            foregroundColor: bgBlack,
                            backgroundColor: padua,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                          ),
                          child: Text(
                            "Edit Seller",
                            style: textXLQuicksanBold,
                          ),
                        ),
                      )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

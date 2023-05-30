// ignore: must_be_immutable
import 'package:dasboard_admin/controllers/total_controller.dart';
import 'package:dasboard_admin/modals/users_modal.dart';
import 'package:dasboard_admin/ulti/styles/main_styles.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

// ignore: must_be_immutable
class CustomModalBottomUser extends StatefulWidget {
  CustomModalBottomUser(
      {super.key, required this.user, required this.tranform});

  Users user;
  bool tranform;

  @override
  State<CustomModalBottomUser> createState() => _CustomModalBottomUserState();
}

class _CustomModalBottomUserState extends State<CustomModalBottomUser> {
  final cu = Get.put(TotalController());
  bool _imageChange = false;
  XFile? _xImage;

  late TextEditingController txtName;
  late TextEditingController txtAddress;
  late TextEditingController txtEmail;
  late TextEditingController txtPhone;
  late TextEditingController txtActiveDate;
  late TextEditingController txtCreateDate;

  @override
  void initState() {
    txtName = TextEditingController();
    txtAddress = TextEditingController();
    txtEmail = TextEditingController();
    txtPhone = TextEditingController();
    txtActiveDate = TextEditingController();
    txtCreateDate = TextEditingController();

    DateTime tsdate =
        DateTime.fromMillisecondsSinceEpoch(widget.user.ActiveAt ?? 0);

    DateTime tsdatecreate =
        DateTime.fromMillisecondsSinceEpoch(widget.user.CreatedAt ?? 0);

    txtName.text = widget.user.Name ?? "";
    txtAddress.text = widget.user.Address ?? "";
    txtEmail.text = widget.user.Email ?? "";
    txtPhone.text = widget.user.Phone ?? "";
    txtActiveDate.text = DateFormat('yyyy-MM-dd').format(tsdate);
    txtCreateDate.text = DateFormat('yyyy-MM-dd').format(tsdatecreate);
    super.initState();
  }

  @override
  void dispose() {
    txtName.dispose();
    txtAddress.dispose();
    txtEmail.dispose();
    txtPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          padding: const EdgeInsets.all(10),
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
                              widget.tranform ? "Edit" : "Detail",
                              style: textMonster,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          widget.tranform ? Icons.edit : Icons.reorder_sharp,
                          size: 30,
                        )
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
              if (!widget.tranform)
                Container(
                    width: 130,
                    height: 130,
                    padding: const EdgeInsets.all(
                        2), // thêm khoảng cách giữa viền và CircleAvatar
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Container(
                        color: Colors.greenAccent,
                      ),
                    ))
              else
                Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      padding: const EdgeInsets.all(
                          4), // thêm khoảng cách giữa viền và CircleAvatar
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      child: ClipOval(
                          child: _imageChange
                              ? Image.file(
                                  File(_xImage!.path),
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.greenAccent,
                                )),
                    ),
                    Positioned(
                        left: 105,
                        top: 105,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () => _pickerImage(context),
                              icon: const Icon(Icons.add_a_photo)),
                        ))
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: widget.tranform,
                controller: txtName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: widget.tranform,
                controller: txtAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: widget.tranform,
                controller: txtEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: widget.tranform,
                controller: txtPhone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                enabled: widget.tranform,
                controller:
                    txtActiveDate, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Active Date" //label text of field
                    ),
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
                      txtActiveDate.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    // ignore: avoid_print
                    print("Date is not selected");
                  }
                },
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                enabled: false,
                controller:
                    txtCreateDate, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Create Date" //label text of field
                    ),
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
                      txtCreateDate.text =
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
              if (widget.tranform)
                GetBuilder<TotalController>(
                  builder: (controller) => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: const BorderSide(
                                color: Colors.black, width: 5.0),
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                      onPressed: () {
                        // ignore: avoid_print
                        print(txtName.text);
                        // ignore: avoid_print
                        print(txtPhone.text);
                        // ignore: avoid_print
                        print(txtAddress.text);
                        // ignore: avoid_print
                        print(txtEmail.text);
                        // ignore: avoid_print
                        print(convertInputDateTimetoNumber(txtCreateDate.text));
                        // ignore: avoid_print
                        print(convertInputDateTimetoNumber(txtActiveDate.text));
                        // ignore: unused_local_variable
                        _updateUser(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Edit User",
                        style: textNormalQuicksanWhite,
                      ),
                    ),
                  ),
                )
              else if (widget.user.Status == true)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side:
                              const BorderSide(color: Colors.black, width: 5.0),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 20)),
                    onPressed: () {
                      cu.updateUserStatus(widget.user.Id!, false);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Lock User",
                      style: textNormalQuicksanWhite,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  _pickerImage(BuildContext context) async {
    _xImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_xImage != null) {
      setState(() {
        _imageChange = true;
      });
    }
  }

  _updateUser(BuildContext context) async {
    final cu = Get.put(TotalController());
    Users user = Users(
        Address: txtAddress.text,
        Avatar: widget.user.Avatar,
        Name: txtName.text,
        Email: txtEmail.text,
        PackageType: widget.user.PackageType,
        Phone: txtPhone.text,
        Password: widget.user.Password,
        Status: widget.user.Status,
        ActiveAt: convertInputDateTimetoNumber(txtActiveDate.text),
        Id: widget.user.Id,
        CreatedAt: convertInputDateTimetoNumber(txtCreateDate.text));
    if (_imageChange) {
      // ignore: no_leading_underscores_for_local_identifiers
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference =
          _storage.ref().child("images").child("anh_${widget.user.Id}");

      UploadTask uploadTask = await _uploadTask(reference, _xImage!);
      uploadTask.whenComplete(() async {
        user.Avatar = await reference.getDownloadURL();
        cu.updateUser(widget.user.Id!, user);
      });
    } else {
      cu.updateUser(widget.user.Id!, user);
    }
  }
}

convertInputDateTimetoNumber(String tiem) {
  String activeDate = tiem; // giá trị ngày tháng dưới dạng chuỗi
  DateTime dateTime =
      DateTime.parse(activeDate); // chuyển đổi thành đối tượng DateTime
  int timestamp = dateTime.millisecondsSinceEpoch; // chuyển đổi thành số
  return timestamp;
}

Future<UploadTask> _uploadTask(Reference reference, XFile xImage) async {
  final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': xImage.path});
  UploadTask uploadTask;
  if (kIsWeb) {
    uploadTask = reference.putData(await xImage.readAsBytes(), metadata);
  } else {
    uploadTask = reference.putFile(File(xImage.path), metadata);
  }
  return Future.value(uploadTask);
}

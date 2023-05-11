// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:io';

import 'package:client_user/constants/string_context.dart';
import 'package:client_user/controller/productimage_controller.dart';
import 'package:client_user/modal/product_image.dart';
import 'package:client_user/screens/manage_product/components/cart_item_productimage.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class TestMultiPicker extends StatefulWidget {
  TestMultiPicker({super.key, required this.pickMode});

  bool pickMode;

  @override
  State<TestMultiPicker> createState() => _TestMultiPickerState();
}

class _TestMultiPickerState extends State<TestMultiPicker> {
  final sellerController = Get.put(ProductImageController());
  // ignore: prefer_final_fields
  List<XFile> _imageList = [];

  Future<void> _pickImages() async {
    try {
      final pickedImages = await ImagePicker().pickMultiImage();
      if (pickedImages != null) {
        setState(() {
          _imageList.addAll(pickedImages);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // ignore: unused_element
  void _removeImage(int index) {
    setState(() {
      _imageList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
          title: Text(
            tUploadImageProductTitle,
            style: textAppKanit,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            widget.pickMode
                ? Expanded(
                    child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(_imageList.length, (index) {
                      return Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(_imageList[index].path)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _imageList.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ))
                : Expanded(
                    child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                        // ignore: invalid_use_of_protected_member
                        sellerController.product.value.length, (index) {
                      return Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    sellerController.product[index].image),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImages,
              child: const Text('Add Images'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                uploadImages(_imageList);
              },
              child: const Text('Upload Images'),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> uploadImages(List<XFile> imagesList) async {
//   final sellerController = Get.put(ProductImageController());
//   List<File> fileList = [];
//   List<ProductImage> productImage = [];
//   for (XFile image in imagesList) {
//     fileList.add(File(image.path));
//   }
//   for (File image in fileList) {
//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     String storagePath = 'images_product/$fileName.jpg';
//     await FirebaseStorage.instance.ref(storagePath).putFile(image);

//     String imageUrl =
//         await FirebaseStorage.instance.ref(storagePath).getDownloadURL();

//     final productItem = ProductImage(image: imageUrl, uploadAt: DateTime.now());
//     productImage.add(productItem);
//   }
//   sellerController.addListProductImage(productImage);
// }

Future<void> uploadImages(List<XFile> imagesList) async {
  final sellerController = Get.put(ProductImageController());
  final storageRefs = <Reference>[];
  final imageDatas = <Uint8List>[];
  final productImage = <ProductImage>[];

  // Tạo danh sách các tệp tin và dữ liệu ảnh
  for (XFile image in imagesList) {
    storageRefs.add(FirebaseStorage.instance
        .ref('images_product/${DateTime.now().millisecondsSinceEpoch}.jpg'));
    imageDatas.add(await image.readAsBytes());
  }

  // Tải lên các tệp tin và lưu trữ các UploadTask vào danh sách
  final uploadTasks = storageRefs
      .map((ref) => ref.putData(imageDatas[storageRefs.indexOf(ref)]));

  // Sử dụng Future.wait để đợi tất cả các UploadTask hoàn tất trước khi tiếp tục
  await Future.wait(uploadTasks);

  // Lấy đường dẫn URL của từng ảnh đã tải lên và tạo danh sách đối tượng ProductImage
  for (Reference ref in storageRefs) {
    final imageUrl = await ref.getDownloadURL();
    final productItem = ProductImage(image: imageUrl, uploadAt: DateTime.now());
    productImage.add(productItem);
  }
  sellerController.addListProductImage(productImage);
}

convertInputDateTimetoNumber(DateTime tiem) {
  int timestamp = tiem.millisecondsSinceEpoch;
  return timestamp;
}

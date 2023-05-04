import 'dart:io';

import 'package:client_user/constants/string_context.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TestMultiPicker extends StatefulWidget {
  const TestMultiPicker({super.key});

  @override
  State<TestMultiPicker> createState() => _TestMultiPickerState();
}

class _TestMultiPickerState extends State<TestMultiPicker> {
  final ImagePicker _imagePicker = ImagePicker();
  List<File> multiImages = [];

  multiImagePicker() async {
    final List<XFile> pickerImage = await _imagePicker.pickMultiImage();
    // ignore: unnecessary_null_comparison
    if (pickerImage.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      pickerImage.forEach((element) {
        multiImages.add(File(element.path));
      });
    }
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
            tProductTitle,
            style: textAppKanit,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20, top: 7),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt),
                color: Colors.black,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            multiImagePicker();
          },
          child: const Icon(Icons.image),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            crossAxisSpacing: 2.5,
            children: multiImages
                .map((e) => Image.file(
                      File(e.path),
                      fit: BoxFit.cover,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

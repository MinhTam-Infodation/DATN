import 'package:client_user/uilt/style/text_style/text_style.dart';

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefexIcon;
  final TextEditingController controller;

  const InputField({
    Key? key,
    this.prefexIcon,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textNormalQuicksanBoldGray,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefexIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

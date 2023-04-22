import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_button.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: sButtonHeight,
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: tEmail,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {}, icon: Icon(Icons.remove_red_eye_sharp))),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: () {}, child: Text(tForgot)),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(),
                    foregroundColor: bgWhite,
                    backgroundColor: bgBlack,
                    padding: EdgeInsets.symmetric(vertical: sButtonHeight)),
                onPressed: () {},
                child: Text(tButtonLogin.toUpperCase())),
          )
        ],
      ),
    ));
  }
}

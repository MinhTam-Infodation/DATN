import 'package:flutter/material.dart';

class ScreenUsersSetting extends StatefulWidget {
  const ScreenUsersSetting({super.key});

  @override
  State<ScreenUsersSetting> createState() => _ScreenUsersSettingState();
}

class _ScreenUsersSettingState extends State<ScreenUsersSetting> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Hello"),
        ),
      ),
    );
  }
}

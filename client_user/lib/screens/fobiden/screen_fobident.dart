import 'package:flutter/material.dart';

class ScreenFobident extends StatelessWidget {
  const ScreenFobident({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Text("Fobiddent"),
        ),
      ),
    ));
  }
}

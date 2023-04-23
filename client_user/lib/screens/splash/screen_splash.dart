import 'package:client_user/constants/string_img.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: const [
            Positioned(
                top: 0,
                left: 0,
                child: Image(
                  width: 300,
                  image: AssetImage(iSplash1),
                ))
          ],
        ),
      ),
    );
  }
}

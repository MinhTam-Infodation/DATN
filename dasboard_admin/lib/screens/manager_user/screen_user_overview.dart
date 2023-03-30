import 'package:flutter/material.dart';

class UserOverviewScreen extends StatefulWidget {
  const UserOverviewScreen({super.key});

  @override
  State<UserOverviewScreen> createState() => _UserOverviewScreenState();
}

class _UserOverviewScreenState extends State<UserOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Manager"),
        ),
      ),
    );
  }
}

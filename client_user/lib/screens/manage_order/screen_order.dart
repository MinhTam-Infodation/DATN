import 'package:client_user/modal/tables.dart';
import 'package:flutter/material.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({super.key, required this.table});
  final Tables table;

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.table.Name!),
      ),
    );
  }
}

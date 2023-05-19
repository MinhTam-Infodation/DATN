import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';

enum FlutterZaloPayStatus { processing, failed, success, cancelled }

class PaymentController extends GetxController {
  static const MethodChannel _channel =
      MethodChannel('flutter.native/channelPayOrder');

  static const EventChannel _eventChannel =
      EventChannel('flutter.native/eventPayOrder');

  static Stream<FlutterZaloPayStatus> payOrder(
      {required String zpToken}) async* {
    if (Platform.isIOS) {
      _eventChannel.receiveBroadcastStream().listen((event) {});
      await _channel.invokeMethod('payOrder', {"zptoken": zpToken});
      // ignore: no_leading_underscores_for_local_identifiers
      Stream<dynamic> _eventStream = _eventChannel.receiveBroadcastStream();
      await for (var event in _eventStream) {
        var res = Map<String, dynamic>.from(event);
        if (res["errorCode"] == 1) {
          yield FlutterZaloPayStatus.success;
        } else if (res["errorCode"] == 4) {
          yield FlutterZaloPayStatus.cancelled;
        } else {
          yield FlutterZaloPayStatus.failed;
        }
      }
    } else {
      final String result =
          await _channel.invokeMethod('payOrder', {"zptoken": zpToken});
      switch (result) {
        case "User hủy thanh toán":
          yield FlutterZaloPayStatus.cancelled;
          break;
        case "Thanh Toán Thành Công":
          yield FlutterZaloPayStatus.success;
          break;
        case "Giao dịch thất bại":
          yield FlutterZaloPayStatus.failed;
          break;
        default:
          yield FlutterZaloPayStatus.failed;
          break;
      }
    }
  }
}

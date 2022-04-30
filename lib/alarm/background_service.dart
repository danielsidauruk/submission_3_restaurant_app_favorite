import 'dart:ui';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:submission_3_restaurant_app/main.dart';
import 'package:submission_3_restaurant_app/data/api/service_api.dart';
import 'package:submission_3_restaurant_app/alarm/notification_helper.dart';


final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getRestaurant();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}

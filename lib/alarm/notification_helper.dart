import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:submission_3_restaurant_app/common/navigation.dart';
import 'package:submission_3_restaurant_app/data/model/restaurant.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'dart:math';
import 'package:rxdart/subjects.dart';


final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurantResult) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var random = restaurantResult
        .restaurants[Random().nextInt(restaurantResult.restaurants.length - 1)];

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Recommendation for you</b>";
    var titleRestaurant = "<b>${random.name}</b> |  Rating: ${random.rating.toString()}";
    await flutterLocalNotificationsPlugin.show(
        0,
        titleNotification,
        titleRestaurant,
        platformChannelSpecifics,
        payload: json.encode(restaurantResult.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantResult.fromJson(json.decode(payload));
        var restaurant = data.restaurants[0];
        Navigation.intentWithData(route, restaurant);
      },
    );
  }
}

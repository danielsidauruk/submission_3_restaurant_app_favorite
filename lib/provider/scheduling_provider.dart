import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:submission_3_restaurant_app/data/preferences/preferences_helper.dart';
import 'package:submission_3_restaurant_app/alarm/background_service.dart';
import 'package:submission_3_restaurant_app/alarm/date_time_helper.dart';
import 'package:flutter/material.dart';


class SchedulingProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  SchedulingProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreference();
  }

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  void _getDailyRestaurantPreference() async {
    _isScheduled = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    scheduledRestaurant(value);
    _getDailyRestaurantPreference();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    notifyListeners();
    if (_isScheduled) {
      debugPrint('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

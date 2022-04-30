import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:submission_3_restaurant_app/common/navigation.dart';
import 'package:submission_3_restaurant_app/data/preferences/preferences_helper.dart';
import 'package:submission_3_restaurant_app/data/api/service_api.dart';
import 'package:submission_3_restaurant_app/data/database/database_helper.dart';
import 'package:submission_3_restaurant_app/provider/restaurant_database.dart';
import 'package:submission_3_restaurant_app/provider/restaurant_provider.dart';
import 'package:submission_3_restaurant_app/provider/scheduling_provider.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_favorite_page.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_home_page.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_list_page.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_setting_page.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_search_page.dart';
import 'package:submission_3_restaurant_app/alarm/notification_helper.dart';
import 'package:submission_3_restaurant_app/alarm/background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(context, ApiService()),
        ),
        ChangeNotifierProvider<RestaurantFavoriteProvider>(
            create: (_) => RestaurantFavoriteProvider(databaseHelper: DatabaseHelper())),
        // ChangeNotifierProvider(
        //     create: (_) => RestaurantSearchProvider(apiService: ApiService())),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(
          preferencesHelper: PreferencesHelper(
            sharedPreferences: SharedPreferences.getInstance(),
          )),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Submission 3 : Restaurant App',
        initialRoute: RestaurantHomePage.routeName,
        routes: {
          RestaurantHomePage.routeName: (context) => const RestaurantHomePage(),
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
          RestaurantSettingPage.routeName: (context) => const RestaurantSettingPage(),
          RestaurantSearchPage.routeName: (context) => const RestaurantSearchPage(),
          RestaurantFavoritePage.routeName: (context) => const RestaurantFavoritePage()
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3_restaurant_app/data/api/service_api.dart';
import 'package:submission_3_restaurant_app/provider/restaurant_provider.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_list_page.dart';


class RestaurantHomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const RestaurantHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<RestaurantHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(context, ApiService()),
      child: const RestaurantListPage(),
    );
  }
}

import 'dart:async';
import 'package:submission_3_restaurant_app/data/api/service_api.dart';
import 'package:submission_3_restaurant_app/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:submission_3_restaurant_app/common/constant.dart';


class RestaurantProvider extends ChangeNotifier {
  final BuildContext context;
  late final ApiService apiService;

  String _message = '';
  String _query = '';
  late ResultState _state;
  late RestaurantResult _restaurantResult;

  String get message => _message;
  String get query => _query;
  ResultState get state => _state;
  RestaurantResult get result => _restaurantResult;


  RestaurantProvider(this.context, this.apiService) {
    _fetchRestaurantData();
  }

  void refresh() {
    _query = query;
    _fetchRestaurantData();
    notifyListeners();
  }

  void setQuery(String query) {
    _query = query;
    _fetchRestaurantData();
    notifyListeners();
  }

  Future<dynamic> _fetchRestaurantData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
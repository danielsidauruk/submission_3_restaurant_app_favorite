import 'dart:async';
import 'package:submission_3_restaurant_app/common/constant.dart';
import 'package:submission_3_restaurant_app/data/api/service_api.dart';
import 'package:submission_3_restaurant_app/data/model/restaurant_search.dart';
import 'package:flutter/material.dart';


class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  late final String query;

  RestaurantSearchProvider({required this.apiService, required this.query}) {
    _fetchAllRestaurant();
  }

  late RestaurantSearch _restaurantSearchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantSearch get result => _restaurantSearchResult;
  ResultState get state => _state;

  set updateQuery(String query) {
    this.query = query;
    notifyListeners();
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getSearchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Data tidak ditemukan";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return "Error : $e";
    }
  }
}
import 'dart:async';
import 'dart:io';
import 'package:submission_3_restaurant_app/data/api/service_api.dart';
import 'package:submission_3_restaurant_app/data/model/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:submission_3_restaurant_app/common/constant.dart';


class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  RestaurantDetailProvider({required this.id, required this.apiService}) {
    getDetailRestaurant(id);
  }

  String get message => _message;
  RestaurantDetail get result => _restaurantDetail;
  ResultState get state => _state;

  Future<dynamic> getDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.getRestaurantDetail(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = Constants.textEmptyData;
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = detailRestaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = Constants.textConnectionError;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}

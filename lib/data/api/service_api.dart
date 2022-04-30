import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:submission_3_restaurant_app/data/model/restaurant.dart';
import 'package:submission_3_restaurant_app/data/model/restaurant_search.dart';
import 'package:submission_3_restaurant_app/data/model/restaurant_detail.dart';


class ApiService {
  static const baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const list = baseUrl + 'list';
  static const detail = baseUrl + 'detail/';
  static const search = baseUrl + 'search?q=';
  static const smallImage = baseUrl + 'images/small/';
  static const mediumImage = baseUrl + 'images/medium/';
  static const largeImage = baseUrl + 'images/large/';

  Future<RestaurantResult> getRestaurant() async {
    final response = await http.get(Uri.parse(baseUrl + 'list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat Restaurant');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(baseUrl + 'detail/' + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Sepertinya kita gagal memuat Detail Restaurant');
    }
  }

  Future<RestaurantSearch> getSearchRestaurant(String query) async {
    final response = await http.get(Uri.parse(baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat Search Restaurant List');
    }
  }
}

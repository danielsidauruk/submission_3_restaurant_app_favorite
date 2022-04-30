import 'package:submission_3_restaurant_app/data/model/restaurant.dart';


class RestaurantSearch {
  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantList> restaurants;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) => RestaurantSearch(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<RestaurantList>.from(
        json["restaurants"].map((x) => RestaurantList.fromJson(x))),
  );
}

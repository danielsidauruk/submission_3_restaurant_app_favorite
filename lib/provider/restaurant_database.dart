import 'package:submission_3_restaurant_app/data/database/database_helper.dart';
import 'package:submission_3_restaurant_app/common/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:submission_3_restaurant_app/data/model/restaurant.dart';


class RestaurantFavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  RestaurantFavoriteProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantList> _favorites = [];
  List<RestaurantList> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorite();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = Constants.textEmptyData;
    }
    notifyListeners();
  }

  void addFavorite(RestaurantList restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3_restaurant_app/provider/restaurant_database.dart';
import 'package:submission_3_restaurant_app/common/constant.dart';
import 'package:submission_3_restaurant_app/widget/restaurant_card.dart';


class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({Key? key}) : super(key: key);
  static const routeName = '/favorite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Favorite Page',
          style: (TextStyle(fontFamily: 'RockWell')),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return RestaurantCard(
                restaurant: provider.favorites[index],
              );
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}

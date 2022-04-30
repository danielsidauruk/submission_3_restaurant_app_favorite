import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3_restaurant_app/common/constant.dart';
import 'package:submission_3_restaurant_app/provider/restaurant_provider.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_favorite_page.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_setting_page.dart';
import 'package:submission_3_restaurant_app/widget/restaurant_card.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_search_page.dart';


class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
            "Restaurant App",
            style: TextStyle(
                fontFamily: 'Rockwell',
                color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, RestaurantSearchPage.routeName),
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () => Navigator.pushNamed(context, RestaurantFavoritePage.routeName),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, RestaurantSettingPage.routeName),
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: const Text(
                  "Recommendation restaurant for you!",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              padding: const EdgeInsets.all(10.0),
            ),
            Expanded(
              child: Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.result.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.result.restaurants[index];
                        return RestaurantCard(restaurant: restaurant);
                      },
                    );
                  } else if (state.state == ResultState.noData) {
                    return Center(child: Text(state.message));
                  } else if (state.state == ResultState.error) {
                    return Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height/2,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                  children: const [
                                    Text("_INTERNET_DISCONNECTED"),
                                  ]),
                            )
                        )
                    );
                  } else {
                    return const Center(child: Text(''));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


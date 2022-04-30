import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3_restaurant_app/data/api/service_api.dart';
import 'package:submission_3_restaurant_app/data/model/restaurant.dart';
import 'package:submission_3_restaurant_app/provider/restaurant_database.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_detail_page.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantList restaurant;
  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantFavoriteProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isFavorite(restaurant.id),
            builder: (context, snapshot) {
              var isFav = snapshot.data ?? false;
              return Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                        arguments: restaurant.id);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                          children: [
                            Hero(
                              tag: Image.network(
                                ApiService.smallImage + restaurant.pictureId,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  ApiService.smallImage + restaurant.pictureId,
                                  height: 80.0,
                                  width: 80.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    restaurant.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.star_rate,
                                        color: Colors.yellow,
                                      ),
                                      Text(restaurant.rating.toStringAsFixed(2)),
                                    ]),
                                Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.redAccent,
                                      ),
                                      Text(restaurant.city)
                                    ]),
                                const SizedBox(height: 10.0,)
                              ],
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                icon: isFav
                                    ? IconButton(
                                  onPressed: () =>
                                      provider.removeFavorite(restaurant.id),
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                )
                                    : IconButton(
                                  onPressed: () =>
                                      provider.addFavorite(restaurant),
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              );
            },
          );
        }
    );
  }
}


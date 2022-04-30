import 'package:flutter/material.dart';
import 'package:submission_3_restaurant_app/data/api/service_api.dart';
import 'package:provider/provider.dart';
import 'package:submission_3_restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:submission_3_restaurant_app/common/constant.dart';


class RestaurantDetailPage extends StatefulWidget {
  static const routeName = "/detail_page";
  final String id;

  const RestaurantDetailPage({Key? key, required this.id})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: widget.id),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.deepOrange,
                    title: Text(
                        state.result.restaurants.name,
                        style: const TextStyle(fontFamily: 'Rockwell')
                    ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(ApiService.largeImage +
                                      state.result.restaurants.pictureId),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.redAccent),
                                        Text(state.result.restaurants.city),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                        children: [
                                          const Icon(Icons.star_rate,
                                              color: Colors.yellow),
                                          Text(state.result.restaurants.rating.toStringAsFixed(2))
                                        ]
                                    ),
                                  ),

                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Description",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    state.result.restaurants.description,
                                    style: const TextStyle(
                                        color: Colors.black
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Menu",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            children: [
                                              const Text(
                                                  'Foods',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold)
                                              ),
                                              Container(
                                                color: Colors.white,
                                                height: 200.0,
                                                child: SingleChildScrollView(
                                                  scrollDirection: Axis.vertical,
                                                  child: Column(
                                                    children: state.result.restaurants
                                                        .menus.foods.map((food) => Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Column(
                                                          children: [
                                                            Text(food.name),
                                                          ]),
                                                    )).toList(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                              children: [
                                                const Text(
                                                    'Drinks',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold)
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  height: 200.0,
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis.vertical,
                                                    child: Column(
                                                      children: state.result.restaurants
                                                          .menus.drinks.map((food) => Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: Column(
                                                            children: [
                                                              Text(food.name),
                                                            ]),
                                                      )).toList(),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ]),
                                ]),
                          ),
                        ),
                      ]),
                ),
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
    );
  }
}
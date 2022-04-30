import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3_restaurant_app/common/constant.dart';
import 'package:submission_3_restaurant_app/data/api/service_api.dart';
import 'package:submission_3_restaurant_app/data/model/restaurant.dart';
import 'package:submission_3_restaurant_app/provider/restaurant_search.dart';
import 'package:submission_3_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission_3_restaurant_app/widget/search_field.dart';


class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  _RestaurantSearchState createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearchPage> {
  final TextEditingController _controller = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
            'Telusuri Restaurant',
            style: TextStyle(fontFamily: 'Rockwell')
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _listBuild(context),
    );
  }

  Widget _searchList(BuildContext context, List<RestaurantList> restaurantList) {
    return Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: restaurantList.length,
              itemBuilder: (context, index) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RestaurantDetailPage.routeName,
                          arguments: restaurantList[index].id);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Hero(
                              tag: Image.network(
                                ApiService.smallImage + restaurantList[index].pictureId,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  ApiService.smallImage + restaurantList[index].pictureId,
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
                                    restaurantList[index].name,
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
                                      Text(restaurantList[index].rating.toStringAsFixed(2)),
                                    ]),
                                Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.redAccent,
                                      ),
                                      Text(restaurantList[index].city)
                                    ]),
                                const SizedBox(height: 10.0,)
                              ],
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ]);
  }

  Widget _listBuild(BuildContext context) {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(children: [
          SearchField(
              controller: _controller,
              autofocus: true),
          query.isNotEmpty
              ? ChangeNotifierProvider<RestaurantSearchProvider>.value(
            value: RestaurantSearchProvider(apiService: ApiService(), query: query),
            child: Consumer<RestaurantSearchProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const CircularProgressIndicator();
                  } else if (state.state == ResultState.noData) {
                    return const Center(
                      child: Text('Penelusuran Anda tidak cocok dengan Restaurant apa pun'),
                    );
                  } else if (state.state == ResultState.hasData) {
                    return _searchList(context, state.result.restaurants);
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
                    return const Text('');
                  }
                }),
          ) : SizedBox(width: MediaQuery.of(context).size.width,
          )
        ])
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        query = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
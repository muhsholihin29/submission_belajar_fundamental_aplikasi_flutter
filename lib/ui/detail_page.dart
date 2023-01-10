import 'package:flutter/material.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/model/restaurant_detail.dart';

import '../api/api_service.dart';
import '../model/restaurant.dart';
import 'item_menu_tile.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  @override
  State<StatefulWidget> createState() =>
      _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  late Future<RestaurantDetailResult> _restaurant;
  static const String urlImage = "https://restaurant-api.dicoding.dev/images/medium/";

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().detail(widget.restaurant.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Restaurant Detail",
              style: TextStyle(color: Color(0xffffffff))),
        ),
        body: FutureBuilder(
          future: _restaurant,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return _buildDetail(context, snapshot.data!.restaurant!);
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()),
                );
              } else {
                return const Material(child: Text(''));
              }
            }
          },
        )
    );
  }

  Widget _buildDetail(BuildContext context, RestaurantDetail restaurant) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(urlImage+(restaurant.pictureId ?? "")),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded),
                    const SizedBox(width: 12.0),
                    Text(restaurant.city ?? "")
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star_rounded),
                    const SizedBox(width: 12.0),
                    Text(restaurant.rating?.toString() ?? "")
                  ],
                ),
                const Divider(color: Colors.grey),
                const Text(
                  'Food',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 40.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.menus?.foods?.length,
                    itemBuilder: (context, index) {
                      final food = restaurant.menus?.foods?[index];
                      return ItemMenuTile(menu: food!.name!);
                    },
                  ),
                ),
                const Text(
                  'Drinks',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 40.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.menus?.drinks?.length,
                    itemBuilder: (context, index) {
                      final food = restaurant.menus?.drinks?[index];
                      return ItemMenuTile(menu: food!.name!);
                    },
                  ),
                ),
                const Divider(color: Colors.grey),
                const Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  restaurant.description ?? "",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

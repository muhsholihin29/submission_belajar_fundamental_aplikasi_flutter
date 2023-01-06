import 'package:flutter/material.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/model/restaurantss.dart';

import 'item_menu_tile.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;

  const DetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name,
          style: const TextStyle(color: Color(0xffffffff))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(restaurant.pictureId),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
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
                      Text(restaurant.city)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded),
                      const SizedBox(width: 12.0),
                      Text(restaurant.rating.toString())
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
                      itemCount: restaurant.menus.foods.length,
                      itemBuilder: (context, index) {
                        final food = restaurant.menus.foods[index];
                        return ItemMenuTile(menu: food.name);
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
                      itemCount: restaurant.menus.drinks.length,
                      itemBuilder: (context, index) {
                        final food = restaurant.menus.drinks[index];
                        return ItemMenuTile(menu: food.name);
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
                    restaurant.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

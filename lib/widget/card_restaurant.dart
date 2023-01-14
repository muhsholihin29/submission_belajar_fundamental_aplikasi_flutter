import 'package:flutter/material.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/model/restaurant.dart';

import '../ui/detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  static const String urlImage = "https://restaurant-api.dicoding.dev/images/small/";

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: urlImage+(restaurant.pictureId ?? ""),
          child: Image.network(
            urlImage+(restaurant.pictureId ?? ""),
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name ?? "",
        ),
        subtitle: Text(restaurant.city ?? ""),
        onTap: () => Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: restaurant,
        ),
      ),
    );
  }
}
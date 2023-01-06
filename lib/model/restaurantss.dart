import 'dart:convert';

class Restaurantss {
  late List<Restaurant> restaurants;

  Restaurantss(this.restaurants);

  factory Restaurantss.fromJson(Map<String, dynamic> json) =>
      Restaurantss(List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x))));
}

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Menu menus;

  Restaurant(this.id, this.name, this.description, this.pictureId, this.city,
      this.rating, this.menus);

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = (restaurant['rating'] as num).toDouble();
    menus = Menu.fromJson(restaurant['menus']);
  }
}

class Menu {
  late List<MenuName> foods;
  late List<MenuName> drinks;

  Menu(this.foods, this.drinks);

  Menu.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <MenuName>[];
      json['foods'].forEach((v) {
        foods.add(MenuName.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <MenuName>[];
      json['drinks'].forEach((v) {
        drinks.add(MenuName.fromJson(v));
      });
    }
  }
}

class MenuName {
  late String name;

  MenuName(this.name);

  MenuName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final Restaurantss parsed = Restaurantss.fromJson(jsonDecode(json));
  return parsed.restaurants;
}

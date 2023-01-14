import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:submission_belajar_fundamental_aplikasi_flutter/model/restaurant.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/model/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> list() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantResult> search(String query) async {
    String url = "${_baseUrl}search?q=$query";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantDetailResult> detail(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }
}
import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class HomePageProvider extends ChangeNotifier {
  final ApiService apiService;

  HomePageProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantResult _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResult get result => _restaurantResult;

  ResultState get state => _state;

  void search(String query) {
    _searchRestaurant(query);
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.list();
      if (restaurant.restaurants?.isEmpty == true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Terjadi kesalahan, silakan coba beberapa saat lagi dan pastikan internet stabil';
    }
  }

  Future<dynamic> _searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final RestaurantResult restaurant;
      if (query.isEmpty){
        restaurant = await apiService.list();
      } else {
        restaurant = await apiService.search(query);
      }
      if (restaurant.restaurants?.isEmpty == true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data tidak ditemukan, silakan gunakan kata kunci lain';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Terjadi kesalahan, silakan coba beberapa saat lagi dan pastikan internet stabil';
    }
  }
}
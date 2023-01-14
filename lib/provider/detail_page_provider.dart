import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error, nothing }

class DetailPageProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailPageProvider({required this.apiService});

  late RestaurantDetailResult _restaurantResult;
  late ResultState _state = ResultState.nothing;
  String _message = '';

  String get message => _message;

  RestaurantDetailResult get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detail(id);
      if (restaurant.restaurant == null) {
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
}
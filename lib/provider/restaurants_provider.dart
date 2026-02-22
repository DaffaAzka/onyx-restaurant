import 'package:flutter/material.dart';
import 'package:onyx_restaurant/core/api_state.dart';
import 'package:onyx_restaurant/data/api/api_service.dart';
import 'package:onyx_restaurant/data/models/responses/list_restaurant_response.dart';

class RestaurantsProvider extends ChangeNotifier {
  ApiState<ListRestaurantResponse> _state = ApiInitial();
  ApiState<ListRestaurantResponse> get getState => _state;

  Future<void> fetchRestaurants() async {
    _state = ApiLoading();
    notifyListeners();

    try {
      final response = await ApiService().getRestaurantListing();
      _state = ApiSuccess(response);
    } catch (e) {
      _state = ApiError(e.toString());
    }

    notifyListeners();
  }

  Future<void> searchRestaurants(String search) async {
    _state = ApiLoading();
    notifyListeners();

    try {
      final response = await ApiService().searchRestaurantListing(search);
      _state = ApiSuccess(
        ListRestaurantResponse(
          error: false,
          message: response.founded.toString(),
          restaurants: response.restaurants,
          count: response.restaurants.length,
        ),
      );
    } catch (e) {
      _state = ApiError(e.toString());
    }

    notifyListeners();
  }
}

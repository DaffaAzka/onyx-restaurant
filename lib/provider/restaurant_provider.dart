import 'package:flutter/material.dart';
import 'package:onyx_restaurant/core/api_state.dart';
import 'package:onyx_restaurant/data/api/api_service.dart';
import 'package:onyx_restaurant/data/models/responses/detail_restaurant_response.dart';

class RestaurantProvider extends ChangeNotifier {
  ApiState<DetailRestaurantResponse> _state = ApiInitial();
  ApiState<DetailRestaurantResponse> get getState => _state;

  Future<void> fetchRestaurant(String id) async {
    _state = ApiLoading();
    notifyListeners();

    try {
      final response = await ApiService().getRestaurantDetail(id);
      _state = ApiSuccess(response);
    } catch (e) {
      _state = ApiError("Something wrong while call the API");
    }

    notifyListeners();
  }
}

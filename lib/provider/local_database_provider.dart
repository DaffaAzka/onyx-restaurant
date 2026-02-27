import 'package:flutter/material.dart';
import 'package:onyx_restaurant/data/local_database_service.dart';
import 'package:onyx_restaurant/data/models/restaurant_list_item.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<RestaurantListItem>? _restaurants;
  List<RestaurantListItem>? get restaurants => _restaurants;

  RestaurantListItem? _restaurant;
  RestaurantListItem? get restaurant => _restaurant;

  Future<void> addRestaurant(RestaurantListItem restaurant) async {
    try {
      await _service.insertRestaurant(restaurant);
      _restaurants = await _service.getAllRestaurants();
      _message = "Added to favorites";
      notifyListeners();
    } catch (e) {
      _message = "Error adding to favorites: $e";
      notifyListeners();
    }
  }

  Future<void> loadRestaurants() async {
    try {
      _restaurants = await _service.getAllRestaurants();
      notifyListeners();
    } catch (e) {
      _message = "Error loading favorites: $e";
      notifyListeners();
    }
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _service.getRestaurantById(id);
      notifyListeners();
    } catch (e) {
      _message = "Error loading restaurant: $e";
      notifyListeners();
    }
  }

  Future<void> updateRestaurant(RestaurantListItem restaurant) async {
    try {
      await _service.updateRestaurant(restaurant);
      _message = "Updated restaurant";
      notifyListeners();
    } catch (e) {
      _message = "Error updating restaurant: $e";
      notifyListeners();
    }
  }

  Future<void> deleteRestaurant(String id) async {
    try {
      await _service.deleteRestaurant(id);
      _restaurants = await _service.getAllRestaurants();
      _restaurant = null;
      _message = "Deleted from favorites";
      notifyListeners();
    } catch (e) {
      _message = "Error deleting from favorites: $e";
      notifyListeners();
    }
  }

  bool checkIfFavorite(String id) {
    if (_restaurants == null) return false;
    return _restaurants!.any((restaurant) => restaurant.id == id);
  }

  bool isRestaurantBookmarked(String id) {
    return _restaurant?.id == id;
  }
}

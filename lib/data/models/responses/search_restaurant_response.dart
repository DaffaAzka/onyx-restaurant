// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:onyx_restaurant/data/models/restaurant_list_item.dart';

class SearchRestaurantResponse {
  final bool error;
  final int founded;
  final List<RestaurantListItem> restaurants;
  SearchRestaurantResponse({required this.error, required this.founded, required this.restaurants});

  SearchRestaurantResponse copyWith({bool? error, int? founded, List<RestaurantListItem>? restaurants}) {
    return SearchRestaurantResponse(
      error: error ?? this.error,
      founded: founded ?? this.founded,
      restaurants: restaurants ?? this.restaurants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'founded': founded,
      'restaurants': restaurants.map((x) => x.toMap()).toList(),
    };
  }

  factory SearchRestaurantResponse.fromMap(Map<String, dynamic> map) {
    return SearchRestaurantResponse(
      error: map['error'] as bool,
      founded: map['founded'] as int,
      restaurants: List<RestaurantListItem>.from(
        (map['restaurants'] as List<dynamic>).map<RestaurantListItem>(
          (x) => RestaurantListItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchRestaurantResponse.fromJson(String source) =>
      SearchRestaurantResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SearchRestaurantResponse(error: $error, founded: $founded, restaurants: $restaurants)';

  @override
  bool operator ==(covariant SearchRestaurantResponse other) {
    if (identical(this, other)) return true;

    return other.error == error && other.founded == founded && listEquals(other.restaurants, restaurants);
  }

  @override
  int get hashCode => error.hashCode ^ founded.hashCode ^ restaurants.hashCode;
}

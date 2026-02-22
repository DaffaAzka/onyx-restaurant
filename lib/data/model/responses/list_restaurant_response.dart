import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:onyx_restaurant/data/model/restaurant_list_item.dart';

class ListRestaurantResponse {
  final bool error;
  final String message;
  final List<RestaurantListItem> restaurants;
  final int count;
  ListRestaurantResponse({required this.error, required this.message, required this.restaurants, required this.count});

  ListRestaurantResponse copyWith({bool? error, String? message, List<RestaurantListItem>? restaurants, int? count}) {
    return ListRestaurantResponse(
      error: error ?? this.error,
      message: message ?? this.message,
      restaurants: restaurants ?? this.restaurants,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'message': message,
      'restaurants': restaurants.map((x) => x.toMap()).toList(),
      'count': count,
    };
  }

  factory ListRestaurantResponse.fromMap(Map<String, dynamic> map) {
    return ListRestaurantResponse(
      error: map['error'] as bool,
      message: map['message'] as String,
      restaurants: List<RestaurantListItem>.from(
        (map['restaurants'] as List<dynamic>).map<RestaurantListItem>(
          (x) => RestaurantListItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListRestaurantResponse.fromJson(String source) =>
      ListRestaurantResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ListRestaurantResponse(error: $error, message: $message, restaurants: $restaurants, count: $count)';
  }

  @override
  bool operator ==(covariant ListRestaurantResponse other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.error == error &&
        other.message == message &&
        listEquals(other.restaurants, restaurants) &&
        other.count == count;
  }

  @override
  int get hashCode {
    return error.hashCode ^ message.hashCode ^ restaurants.hashCode ^ count.hashCode;
  }
}

import 'dart:convert';

import '../restaurant.dart';

class DetailRestaurantResponse {
  final bool error;
  final String message;
  final Restaurant restaurant;
  DetailRestaurantResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  DetailRestaurantResponse copyWith({
    bool? error,
    String? message,
    Restaurant? restaurant,
  }) {
    return DetailRestaurantResponse(
      error: error ?? this.error,
      message: message ?? this.message,
      restaurant: restaurant ?? this.restaurant,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'message': message,
      'restaurant': restaurant.toMap(),
    };
  }

  factory DetailRestaurantResponse.fromMap(Map<String, dynamic> map) {
    return DetailRestaurantResponse(
      error: map['error'] as bool,
      message: map['message'] as String,
      restaurant: Restaurant.fromMap(map['restaurant'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailRestaurantResponse.fromJson(String source) =>
      DetailRestaurantResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'DetailRestaurantResponse(error: $error, message: $message, restaurant: $restaurant)';

  @override
  bool operator ==(covariant DetailRestaurantResponse other) {
    if (identical(this, other)) return true;

    return other.error == error &&
        other.message == message &&
        other.restaurant == restaurant;
  }

  @override
  int get hashCode => error.hashCode ^ message.hashCode ^ restaurant.hashCode;
}

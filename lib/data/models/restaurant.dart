import 'dart:convert';

import 'package:flutter/foundation.dart' hide Category;

import 'category.dart';
import 'customer_review.dart';
import 'menus.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? city,
    String? address,
    String? pictureId,
    List<Category>? categories,
    Menus? menus,
    double? rating,
    List<CustomerReview>? customerReviews,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      city: city ?? this.city,
      address: address ?? this.address,
      pictureId: pictureId ?? this.pictureId,
      categories: categories ?? this.categories,
      menus: menus ?? this.menus,
      rating: rating ?? this.rating,
      customerReviews: customerReviews ?? this.customerReviews,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'address': address,
      'pictureId': pictureId,
      'categories': categories.map((x) => x.toMap()).toList(),
      'menus': menus.toMap(),
      'rating': rating,
      'customerReviews': customerReviews.map((x) => x.toMap()).toList(),
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      pictureId: map['pictureId'] as String,
      categories: List<Category>.from(
        (map['categories'] as List<dynamic>).map<Category>((x) => Category.fromMap(x as Map<String, dynamic>)),
      ),
      menus: Menus.fromMap(map['menus'] as Map<String, dynamic>),
      rating: (map['rating'] as num).toDouble(),
      customerReviews: List<CustomerReview>.from(
        (map['customerReviews'] as List<dynamic>).map<CustomerReview>(
          (x) => CustomerReview.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) => Restaurant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Restaurant(id: $id, name: $name, description: $description, city: $city, address: $address, pictureId: $pictureId, categories: $categories, menus: $menus, rating: $rating, customerReviews: $customerReviews)';
  }

  @override
  bool operator ==(covariant Restaurant other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.city == city &&
        other.address == address &&
        other.pictureId == pictureId &&
        listEquals(other.categories, categories) &&
        other.menus == menus &&
        other.rating == rating &&
        listEquals(other.customerReviews, customerReviews);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        city.hashCode ^
        address.hashCode ^
        pictureId.hashCode ^
        categories.hashCode ^
        menus.hashCode ^
        rating.hashCode ^
        customerReviews.hashCode;
  }
}

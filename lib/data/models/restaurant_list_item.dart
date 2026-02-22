import 'dart:convert';

class RestaurantListItem {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  RestaurantListItem({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  RestaurantListItem copyWith({
    String? id,
    String? name,
    String? description,
    String? pictureId,
    String? city,
    double? rating,
  }) {
    return RestaurantListItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pictureId: pictureId ?? this.pictureId,
      city: city ?? this.city,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }

  factory RestaurantListItem.fromMap(Map<String, dynamic> map) {
    return RestaurantListItem(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      pictureId: map['pictureId'] as String,
      city: map['city'] as String,
      rating: (map['rating'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantListItem.fromJson(String source) =>
      RestaurantListItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RestaurantListItem(id: $id, name: $name, description: $description, pictureId: $pictureId, city: $city, rating: $rating)';

  @override
  bool operator ==(covariant RestaurantListItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.pictureId == pictureId &&
        other.city == city &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        pictureId.hashCode ^
        city.hashCode ^
        rating.hashCode;
  }
}

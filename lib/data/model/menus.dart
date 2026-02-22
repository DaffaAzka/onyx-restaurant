import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'drink.dart';
import 'food.dart';

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;
  Menus({required this.foods, required this.drinks});

  Menus copyWith({List<Food>? foods, List<Drink>? drinks}) {
    return Menus(foods: foods ?? this.foods, drinks: drinks ?? this.drinks);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foods': foods.map((x) => x.toMap()).toList(),
      'drinks': drinks.map((x) => x.toMap()).toList(),
    };
  }

  factory Menus.fromMap(Map<String, dynamic> map) {
    return Menus(
      foods: List<Food>.from((map['foods'] as List<dynamic>).map<Food>((x) => Food.fromMap(x as Map<String, dynamic>))),
      drinks: List<Drink>.from(
        (map['drinks'] as List<dynamic>).map<Drink>((x) => Drink.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Menus.fromJson(String source) => Menus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Menus(foods: $foods, drinks: $drinks)';

  @override
  bool operator ==(covariant Menus other) {
    if (identical(this, other)) return true;

    return listEquals(other.foods, foods) && listEquals(other.drinks, drinks);
  }

  @override
  int get hashCode => foods.hashCode ^ drinks.hashCode;
}

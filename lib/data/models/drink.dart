import 'dart:convert';

class Drink {
  final String name;
  Drink({required this.name});

  Drink copyWith({String? name}) {
    return Drink(name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name};
  }

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(name: map['name'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Drink.fromJson(String source) =>
      Drink.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Drink(name: $name)';

  @override
  bool operator ==(covariant Drink other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

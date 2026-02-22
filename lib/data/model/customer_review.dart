import 'dart:convert';

class CustomerReview {
  final String name;
  final String review;
  final String date;
  CustomerReview({required this.name, required this.review, required this.date});

  CustomerReview copyWith({String? name, String? review, String? date}) {
    return CustomerReview(name: name ?? this.name, review: review ?? this.review, date: date ?? this.date);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'review': review, 'date': date};
  }

  factory CustomerReview.fromMap(Map<String, dynamic> map) {
    return CustomerReview(name: map['name'] as String, review: map['review'] as String, date: map['date'] as String);
  }

  String toJson() => json.encode(toMap());

  factory CustomerReview.fromJson(String source) => CustomerReview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CustomerReview(name: $name, review: $review, date: $date)';

  @override
  bool operator ==(covariant CustomerReview other) {
    if (identical(this, other)) return true;

    return other.name == name && other.review == review && other.date == date;
  }

  @override
  int get hashCode => name.hashCode ^ review.hashCode ^ date.hashCode;
}

import 'dart:convert';

class Person {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;
  Person({
    required this.id,
    required this.popularity,
    required this.name,
    required this.profileImg,
    required this.known,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'popularity': popularity,
      'name': name,
      'profileImg': profileImg,
      'known': known,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id']?.toInt() ?? 0,
      popularity: map['popularity']?.toDouble() ?? 0.0,
      name: map['name'] ?? '',
      profileImg: map['profileImg'] ?? '',
      known: map['known'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));
}

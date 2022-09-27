import 'dart:convert';

class Person {
  final int id;
  final double? popularity;
  final String? name;
  final String? profileImg;
  final String? known;
  Person({
    required this.id,
     this.popularity,
     this.name,
     this.profileImg,
     this.known,
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
      profileImg: map['profile_path'] ?? '',
      known: map['known_for_department'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(dynamic source) => Person.fromMap(source);
}

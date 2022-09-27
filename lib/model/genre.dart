import 'dart:convert';
class Genre {
  final int id;
  final String name;

  Genre(this.id,
         this.name);


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      map['id']?.toInt() ?? 0,
      map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Genre.fromJson(dynamic source) => Genre.fromMap(source);
}

import 'dart:convert';

class Cast {
  final int? id;
  final String? character;
  final String? name;
  final String? img;
  Cast({
    this.id,
    this.character,
    this.name,
    this.img,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'character': character,
      'name': name,
      'img': img,
    };
  }

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      id: map['cast_id']?.toInt(),
      character: map['character'],
      name: map['name'],
      img: map['profile_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cast.fromJson(dynamic source) => Cast.fromMap(source);
}

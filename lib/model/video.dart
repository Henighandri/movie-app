import 'dart:convert';

class Video {
  final String? id;
  final String? key;
  final String? name;
  final String? site;
  final String? type;
  Video({
    this.id,
    this.key,
    this.name,
    this.site,
    this.type,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'site': site,
      'type': type,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id'],
      key: map['key'],
      name: map['name'],
      site: map['site'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(dynamic source) => Video.fromMap(source);
}

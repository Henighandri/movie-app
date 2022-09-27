import 'dart:convert';

import 'package:movie_app/model/genre.dart';

class MovieDetail {
  final int? id;
  final bool? adult;
  final int? budget;
  final List<Genre>? genres;
  final String? releaseData;
  final int? runtime;
  MovieDetail({
     this.id,
    this.adult,
    this.budget,
    this.genres,
    this.releaseData,
    this.runtime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adult': adult,
      'budget': budget,
      'genres': genres?.map((x) => x.toMap()).toList(),
      'release_Data': releaseData,
      'runtime': runtime,
    };
  }

  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    return MovieDetail(
      id: map['id']?.toInt() ,
      adult: map['adult'],
      budget: map['budget']?.toInt(),
      genres: map['genres'] != null ? List<Genre>.from(map['genres']?.map((x) => Genre.fromMap(x))) : null,
      releaseData: map['release_date'],
      runtime: map['runtime']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetail.fromJson(dynamic source) => MovieDetail.fromMap(source);
}

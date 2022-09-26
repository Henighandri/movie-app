import 'dart:convert';

import 'package:movie_app/model/genre.dart';

class GenreResponse {
  final List<Genre> genres;
  final String error;
  GenreResponse({
    required this.genres,
    required this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'genres': genres.map((x) => x.toMap()).toList(),
      'error': error,
    };
  }

  factory GenreResponse.fromMap(Map<String, dynamic> map) {
    return GenreResponse(
      genres: List<Genre>.from(map['genres']?.map((x) => Genre.fromMap(x))),
      error: map['error'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GenreResponse.fromJson(String source) => GenreResponse.fromMap(json.decode(source));
  
  GenreResponse.withError(
    String errorvalue,
  )   : genres = [],
        error = errorvalue;
}

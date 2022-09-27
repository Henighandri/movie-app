import 'dart:convert';

import 'package:movie_app/model/movie_detail.dart';

class MovieDetailResponse {
  final MovieDetail? movieDetail;
  final String error;
  
  MovieDetailResponse({
    required this.movieDetail,
    required this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'movieDetail': movieDetail!.toMap(),
      'error': error,
    };
  }

  factory MovieDetailResponse.fromMap(Map<String, dynamic> map) {
    return MovieDetailResponse(
      movieDetail: MovieDetail.fromJson(map),
      error: map['error'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetailResponse.fromJson(dynamic source) => MovieDetailResponse.fromMap(source);

   MovieDetailResponse.withError(String errorValue)
      : movieDetail=null,
        error = errorValue;
}

import 'dart:convert';

import 'package:movie_app/model/cast.dart';

class CastResponse {
  final List<Cast>? casts;
  final String? error;
  
  CastResponse({
    this.casts,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'casts': casts?.map((x) => x.toMap()).toList(),
      'error': error,
    };
  }

  factory CastResponse.fromMap(Map<String, dynamic> map) {
    return CastResponse(
      casts: map['casts'] != null ? List<Cast>.from(map['casts']?.map((x) => Cast.fromMap(x))) : null,
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CastResponse.fromJson(String source) => CastResponse.fromMap(json.decode(source));

   CastResponse.withError(String errorValue)
      : casts = null,
        error = errorValue;
}

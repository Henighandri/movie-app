import 'dart:convert';

import 'package:movie_app/model/video.dart';

class VideoResponse {
  final List<Video>? videos;
  final String? error;
  VideoResponse({
    this.videos,
    this.error,
  });


  Map<String, dynamic> toMap() {
    return {
      'videos': videos?.map((x) => x.toMap()).toList(),
      'error': error,
    };
  }

  factory VideoResponse.fromMap(Map<String, dynamic> map) {
    return VideoResponse(
      videos: map['results'] != null ? List<Video>.from(map['results']?.map((x) => Video.fromMap(x))) : null,
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoResponse.fromJson(dynamic source) => VideoResponse.fromMap(source);
  
 
  VideoResponse.withError(
    String errorvalue,
  )   : videos = null,
        error = errorvalue;
}

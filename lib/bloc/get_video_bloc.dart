


import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:rxdart/rxdart.dart';

import '../repository/repository.dart';

class MovieVideosBloc{
  final MovieRepository _repository =MovieRepository();
  final BehaviorSubject<VideoResponse?> _subject= BehaviorSubject<VideoResponse>();

  getMovieVideos(int id)async{
    VideoResponse response =await _repository.getMovieVideos(id);
    _subject.sink.add(response);
  }

 void drainStream(){_subject.value = null;}
 @mustCallSuper
 void dispose()async{
  await _subject.drain();
  _subject.close();
 }
  BehaviorSubject<VideoResponse?> get subject=>_subject;

}
final movieVideosBloc=MovieVideosBloc();
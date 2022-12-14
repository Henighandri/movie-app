import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc{
  final MovieRepository _repository =MovieRepository();
  final BehaviorSubject<MovieResponse> _subject= BehaviorSubject<MovieResponse>();

  getTopRatedMovies()async{
    MovieResponse response =await _repository.getTopRatedMovies();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject=>_subject;

}
final topMoviesBloc=MoviesListBloc();
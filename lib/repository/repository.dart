import 'package:dio/dio.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/person_response.dart';

class MovieRepository{
  final String apiKey='b077961a1abdb78536fac340c943094d';
  static String mainUrl="https://api.themoviedb.org/3";

  final Dio _dio=Dio();

  var getPopularUrl="$mainUrl/movie/top_rated";
  var getMoviesUrl="$mainUrl/discover/movie";
  var getPlayingUrl="$mainUrl/movie/now_playing";
  var getGenresUrl="$mainUrl/genre/movie/list";
  var getPersonsUrl="$mainUrl/trending/person/week";

  Future<MovieResponse> getMovies()async{
    var params={
      "api_key":apiKey,
      "language":"en-US",
     
    };

    try{
      Response response=await _dio.get(getPopularUrl,queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch (error,stacktracer){
       print("exeption occured : $error stacktracer : $stacktracer");
       return  MovieResponse.withError("$error");

    }
   

  }
  
  Future<MovieResponse> getPlayingMovies()async{
    var params={
      "api_key":apiKey,
      "language":"en-US",
      "page":1
    };

    try{
      Response response=await _dio.get(getPlayingUrl,queryParameters: params);
     
      return MovieResponse.fromJson(response.data);
    }catch (error,stacktracer){
       print("exeption occured : $error stacktracer : $stacktracer");
       return  MovieResponse.withError("$error");

    }
   

  }
  Future<MovieResponse> getMovieByGenre(int id)async{
    var params={
      "api_key":apiKey,
      "language":"en-US",
      "page":1,
      "with_genres":id
    };

    try{
      Response response=await _dio.get(getMoviesUrl,queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch (error,stacktracer){
       print("exeption occured : $error stacktracer : $stacktracer");
       return  MovieResponse.withError("$error");

    }
   

  }
  
  Future<PersonResponse> getPersons()async{
    var params={
      "api_key":apiKey,
     
    };

    try{
      Response response=await _dio.get(getPersonsUrl,queryParameters: params);
      
      return PersonResponse.fromJson(response.data);
    }catch (error,stacktracer){
       print("exeption occured : $error stacktracer : $stacktracer");
       return  PersonResponse.withError("$error");

    }
   

  }
  
  Future<GenreResponse> getGenres()async{
    var params={
      "api_key":apiKey,
     
    };

    try{
      Response response=await _dio.get(getGenresUrl,queryParameters: params);
      return GenreResponse.fromJson(response.data);
    }catch (error,stacktracer){
       print("exeption occured : $error stacktracer : $stacktracer");
       return  GenreResponse.withError("$error");

    }
   

  }
}
import 'package:dio/dio.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie_detail_response.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/person_response.dart';
import 'package:movie_app/model/video_response.dart';

class MovieRepository{
  final String apiKey='b077961a1abdb78536fac340c943094d';
  static String mainUrl="https://api.themoviedb.org/3";

  final Dio _dio=Dio();

  var gettopRatedUrl="$mainUrl/movie/top_rated";
  var getMoviesUrl="$mainUrl/discover/movie";
  var getPlayingUrl="$mainUrl/movie/now_playing";
  var getGenresUrl="$mainUrl/genre/movie/list";
  var getPersonsUrl="$mainUrl/trending/person/week";
  var movieUrl ='$mainUrl/movie';

  Future<MovieResponse> getTopRatedMovies()async{
    var params={
      "api_key":apiKey,
      "language":"en-US",
     
    };

    try{
      Response response=await _dio.get(gettopRatedUrl,queryParameters: params);
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

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params={
       "api_key":apiKey,
        "language":"en-US",
    };
    try{
      Response response=await _dio.get('$movieUrl/$id',queryParameters: params);
    //  print(response);
      return MovieDetailResponse.fromJson(response.data );
      }catch (error,stacktracer){
        print("exeption occured : $error stacktracer : $stacktracer");
       return  MovieDetailResponse.withError("$error");
      }
  }
  
  Future<CastResponse> getCasts(int id) async {
    var params={
       "api_key":apiKey,
        "language":"en-US",
    };
    try{
      Response response=await _dio.get('$movieUrl/$id/credits',queryParameters: params);
     
      return CastResponse.fromJson(response.data );
      }catch (error,stacktracer){
        print("exeption occured : $error stacktracer : $stacktracer");
       return  CastResponse.withError("$error");
      }
  }
   Future<MovieResponse> getSimilarMovies(int id) async {
    var params={
       "api_key":apiKey,
        "language":"en-US",
    };
    try{
      Response response=await _dio.get('$movieUrl/$id/similar',queryParameters: params);
     // print(response);
      return MovieResponse.fromJson(response.data );
      }catch (error,stacktracer){
        print("exeption occured : $error stacktracer : $stacktracer");
       return  MovieResponse.withError("$error");
      }
  }
   Future<VideoResponse> getMovieVideos(int id) async {
    var params={
       "api_key":apiKey,
        "language":"en-US",
    };
    print(id);
    try{
      Response response=await _dio.get('$movieUrl/$id/videos',queryParameters: params);
     // print(response);
      return VideoResponse.fromJson(response.data );
      }catch (error,stacktracer){
        print("exeption occured : $error stacktracer : $stacktracer");
       return  VideoResponse.withError("$error");
      }
  }
}
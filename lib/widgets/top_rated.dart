

import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movies_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/widgets/movies_widget.dart';
import '../style/theme.dart' as Style;

class TopRated extends StatefulWidget {
  const TopRated({Key? key}) : super(key: key);

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Padding(padding: EdgeInsets.only(top: 10,left: 10),
        child: Text("TOP RATED"
        ,style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Style.Colors.titleColor),
        ),),
       const SizedBox(height: 5,),
        SizedBox(
          height: 250,
          child: MoviesWidget(
            getMovieList: () {
             topMoviesBloc.getTopRatedMovies();
            },
            stream: topMoviesBloc.subject.stream,
          ),
        )
        



      ],
    );
    
  }
}
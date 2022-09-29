import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movie_similar_bloc.dart';
import 'package:movie_app/widgets/movies_widget.dart';
import '../style/theme.dart' as Style;

class SimilarMovies extends StatelessWidget {
  const SimilarMovies({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "SIMILAR",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Style.Colors.titleColor),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 250,
          child: MoviesWidget(
            getMovieList: () {
              similarMoviesBloc.getSimilarMovies(id);
            },
            stream: similarMoviesBloc.subject.stream,
          ),
        )
      ],
    );
  }
}

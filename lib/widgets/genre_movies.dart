import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../style/theme.dart' as Style;
import 'package:movie_app/bloc/get_movies_byGenre_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';

class GenrsMovies extends StatefulWidget {
  GenrsMovies({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;
  @override
  State<GenrsMovies> createState() => _GenrsMoviesState();
}

class _GenrsMoviesState extends State<GenrsMovies> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesByGenreBloc.getMovieByGenre(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: moviesByGenreBloc.subject.stream,
      builder: (context ,AsyncSnapshot<MovieResponse?> snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.error.isNotEmpty){
              return _buildErrorWidget(snapshot.data!.error);

            }
            return _buildMoviesWidget(snapshot.data!);
          }else if(snapshot.hasError){
            return _buildErrorWidget(snapshot.error.toString());
          }else{
            return _buildLoadingWidget();
          }
      });
    
  }
  
  Widget _buildLoadingWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
               valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
            ),
          )

      ]),
    );
  }
   Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error",style: const TextStyle(color: Colors.white,fontSize: 20),),
      ],
    ));
  }

  Widget _buildMoviesWidget(MovieResponse data){
    List<Movie> movies=data.movies;
   
    if(movies.isEmpty){
    return const Text(
                "No Movies",
                style: TextStyle(color: Colors.white),
              );

   }else{
    return Container(
      
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(top: 10,right: 10),
            child: Column(
              children: [
                movies[index].poster==null?
                Container(
                  width: 120,
                  height: 180,
                  decoration: const BoxDecoration(
                   color: Style.Colors.secondColor,
                   borderRadius: BorderRadius.all(Radius.circular(2)),
                   shape: BoxShape.rectangle
                  ),
                  child: Column(
                    children: const [
                      Icon(EvaIcons.filmOutline,color: Colors.white,size: 50,)
                    ],
                  ),
                )
                : Container(
                  width: 120,
                  height: 180,
                  decoration:  BoxDecoration(
                   color: Style.Colors.secondColor,
                   borderRadius: BorderRadius.all(Radius.circular(2)),
                   shape: BoxShape.rectangle,
                   image: DecorationImage(
                    image:NetworkImage("https://image.tmdb.org/t/p/w200/${movies[index].poster}" 
                    ) )
                  ),
                 
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 100,
                  
                  child: Text(
                    movies[index].title!,
                  
                    maxLines: 1,
                    style: const TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
               const SizedBox(height: 5,),
               SizedBox(
                width: 100,
                 child: Row(
                  children:[
                    Text(movies[index].rating!.toString(),style: const TextStyle( 
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(width: 5,),
                    RatingBar.builder(
                      itemSize: 8,
                      initialRating:movies[index].rating!/2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2),
                      
                      itemBuilder: (context,index){
                        return const Icon(EvaIcons.star,color: Style.Colors.secondColor,);
                      },
                       onRatingUpdate: (rating){
                        print(rating);
                       })
                  ]
                 ),
               )
 
              ],
            ),
          );
        }),
    );

   }
  }
}
  
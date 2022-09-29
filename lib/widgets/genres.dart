import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_genres_bloc.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/widgets/genres_list.dart';


class Genres extends StatefulWidget {
   const Genres({Key? key}) : super(key: key);

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {

     
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   genresBloc.getGenres();
  }
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //movieVideosBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: genresBloc.subject.stream,
      builder: (context ,AsyncSnapshot<GenreResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.error.isNotEmpty){
              return _buildErrorWidget(snapshot.data!.error);

            }
            return _buildGenreWidget(snapshot.data!);
          }else if(snapshot.hasError){
            return _buildErrorWidget(snapshot.error.toString());
          }else{
            return _buildLoadingWidget();
          }
      });
    
  }
  
  Widget _buildLoadingWidget(){
    return  SizedBox(
           height: 220,
           width:  MediaQuery.of(context).size.width,
      child: const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
             valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 4.0,
          ),
        ),
      ),
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

  Widget _buildGenreWidget(GenreResponse data){
    List<Genre> genres= data.genres!;
   if(genres.isEmpty){
    return const Text(
                "No More Movies",
                style: TextStyle(color: Colors.white),
              );

   }else{
    return GenresList(genres: genres,);

   }
  }


}
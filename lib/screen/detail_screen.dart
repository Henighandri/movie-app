
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_video_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/video.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:movie_app/widgets/casts.dart';
import 'package:movie_app/widgets/movie_detail_widget.dart';
import 'package:movie_app/widgets/movie_info.dart';
import 'package:movie_app/widgets/similar_movies.dart';


import '../style/theme.dart' as Style;

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieVideosBloc.getMovieVideos(widget.movie.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //movieVideosBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      body: StreamBuilder<VideoResponse?>(
          stream: movieVideosBloc.subject.stream,
          builder: (context ,AsyncSnapshot<VideoResponse?> snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.error!=null && snapshot.data!.error!.isNotEmpty){
                  return _buildErrorWidget(snapshot.data!.error!);

                }
                return _buildVideoWidget(snapshot.data!);
              }else if(snapshot.hasError){
                return _buildErrorWidget(snapshot.error.toString());
              }else{
                return _buildLoadingWidget();
              }
          }),
      
     
    );
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

  Widget _buildVideoWidget(VideoResponse data){
    List<Video> videos=data.videos!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           MovieDetailWidget(movie: widget.movie,videos: videos,),
           MovieInfo(id: widget.movie.id),
           CastsWidget(id: widget.movie.id),
           SimilarMovies(id: widget.movie.id)
    
           
        ],
      ),
    );
  }
}


import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/video.dart';
import 'package:movie_app/screen/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../style/theme.dart' as Style;

class MovieDetailWidget extends StatelessWidget {
  const MovieDetailWidget({
    Key? key, required this.movie, required this.videos,

  }) : super(key: key);
final Movie movie;
final List<Video> videos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height:250 ,
          
          child: Stack(
            children: [
               Hero(
                            tag: movie.id,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 220.0,
                              decoration:  BoxDecoration(
                                shape: BoxShape.rectangle,
                                image:  DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original/${movie.backPoster}")),
                              ),
                              child: Container(decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5)
                              )),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.9),
                                    Colors.black.withOpacity(0),
                                  ]
                                )
                              ),
                          
                            ),
                          ),
             
                 Positioned(
                  bottom: 50,
                 left: 0,
                 right: 0,
                   child: Center(
                     child: Text(movie.title!.length > 40
                          ?movie.title!.substring(0,37)+"..."
                          :movie.title!,
                          style: const TextStyle(fontSize:20,fontWeight: FontWeight.bold ,color: Colors.white,),
                         
                          ),
                   ),
                 ),
                 Positioned(
                  bottom: 0,
                  right: 30,
                   child: GestureDetector(
                    onTap: (){
                       Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              videos: videos,
            ),
          ),
        );
                    },
                     child: Container(
                            width: 60,
                            height: 60,
                            decoration:  BoxDecoration(
                             color:  Style.Colors.secondColor,
                             //borderRadius: BorderRadius.all(Radius.circular(2)),
                             border: Border.all(color: Colors.white,width: 2),
                             shape: BoxShape.circle
                            ),
                            child: const Center(child: Icon(Icons.play_arrow,color: Colors.white,size: 30,)),
                          ),
                   ),
                 ),
                 Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
                  onPressed: (){Navigator.pop(context);},))
            ],
          ),
        ),
         Padding(
           padding: const EdgeInsets.only(left: 10 ),
           child: Row(
            children:[
              Text(movie.rating!.toString(),style: const TextStyle( 
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(width: 5,),
              RatingBar.builder(
                itemSize: 12,
                initialRating:movie.rating!/2,
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
         ),
        const Padding(padding: EdgeInsets.only(top: 20,left: 10),
        child: Text("OVERVIEW"
        ,style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Style.Colors.titleColor),
        ),),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            movie.overview!,
            style: const TextStyle(color: Colors.white,fontSize: 12,height: 1.5),
          ),
        )
        ,
       
      ],
    );
  }
}
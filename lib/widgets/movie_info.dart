
import '../style/theme.dart' as Style;
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movie_detail_bloc.dart';
import 'package:movie_app/model/movie_detail.dart';
import 'package:movie_app/model/movie_detail_response.dart';

class MovieInfo extends StatefulWidget {
  const MovieInfo({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetailBloc.getMovieDetail(widget.id);
  }
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //movieVideosBloc.drainStream();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailResponse?>(
          stream: movieDetailBloc.subject.stream,
          builder: (context ,AsyncSnapshot<MovieDetailResponse?> snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.error!=null && snapshot.data!.error.isNotEmpty){
                  return _buildErrorWidget(snapshot.data!.error);

                }
                return _buildMovieInfoWidget(snapshot.data!);
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
  Widget _buildMovieInfoWidget(MovieDetailResponse data){
   MovieDetail movieDetail=data.movieDetail!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text("BUDGET"
                   ,style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 15,
                         color: Style.Colors.titleColor),
                   ),
                  const SizedBox(height: 10,),
                   Text("${movieDetail.budget}\$",
                   style: const TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 15,
                         color: Style.Colors.secondColor),
                   ),
                 ],
               ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text("DURATION"
                   ,style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 15,
                         color: Style.Colors.titleColor),
                   ),
                    const SizedBox(height: 10,),
                   Text("${movieDetail.runtime} min"
                   ,style: const TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 15,
                         color: Style.Colors.secondColor),
                   ),
                 ],
               ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text("RELEASE DATE"
                   ,style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 15,
                         color: Style.Colors.titleColor),
                   ),
                    const SizedBox(height: 10,),
                   Text(movieDetail.releaseData!
                   ,style: const TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 15,
                         color: Style.Colors.secondColor),
                   ),
                 ],
               ),


            ],
          ),
          SizedBox(height: 10,),
            const Text("GENRES"
               ,style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 15,
                     color: Style.Colors.titleColor),
               ),
               const SizedBox(height: 10,),
               SizedBox(
                height: 30,
                 child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount:movieDetail.genres!.length ,
                  separatorBuilder: ((context, index) => SizedBox(width: 8,)),
                  itemBuilder: (context,index){
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Style.Colors.titleColor,width: 2)),
                      child: Center(child: Text(movieDetail.genres![index].name,
                      style: const TextStyle(color: Style.Colors.titleColor,fontWeight: FontWeight.w500),)),
                    );
                  }),
               )
        ],
      ),
      
    );
  }
}
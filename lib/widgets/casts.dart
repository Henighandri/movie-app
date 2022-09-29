
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_casts_bloc.dart';
import 'package:movie_app/model/cast.dart';
import 'package:movie_app/model/cast_response.dart';
import '../style/theme.dart' as Style;
class CastsWidget extends StatefulWidget {
  const CastsWidget({Key? key, required this.id}) : super(key: key);
final int id;
  @override
  State<CastsWidget> createState() => _CastsWidgetState();
}

class _CastsWidgetState extends State<CastsWidget> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    castsBloc.getCasts(widget.id);
  }
   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //movieVideosBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
       const SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("CASTS"
                 ,style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 15,
                       color: Style.Colors.titleColor),
                 ),
          ),
         const SizedBox(height: 5,),
      StreamBuilder(
    stream: castsBloc.subject.stream,
    builder: (context ,AsyncSnapshot<CastResponse?> snapshot){
        if(snapshot.hasData){
          if(snapshot.data!.error!=null && snapshot.data!.error!.isNotEmpty){
            return _buildErrorWidget(snapshot.data!.error!);

          }
          return _buildPersonsWidget(snapshot.data!);
        }else if(snapshot.hasError){
          return _buildErrorWidget(snapshot.error.toString());
        }else{
          return _buildLoadingWidget();
        }
    })
      ],
    );
    
  }
  
  Widget _buildLoadingWidget(){
    return  SizedBox(
           height: 150,
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

  Widget _buildPersonsWidget(CastResponse data){
    List<Cast>? casts=data.casts;
   
    if(casts==null ||casts.isEmpty){
    return const Text(
                "No Persons",
                style: TextStyle(color: Colors.white),
              );

   }else{
    return Container(
      height: 150,
      
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        itemBuilder: (context,index){
         
          return Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10,right: 10),
            child: Column(
              children: [
                casts[index].img==null?
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                   color:  Color.fromARGB(255, 46, 56, 69),
                   //borderRadius: BorderRadius.all(Radius.circular(2)),
                   shape: BoxShape.circle
                  ),
                  child: const Center(child: Icon(EvaIcons.filmOutline,color: Colors.white,size: 50,)),
                )
                : Container(
                  width: 80,
                  height: 80,
                  decoration:  BoxDecoration(
                   color: Style.Colors.secondColor,
                   shape: BoxShape.circle,
                   image: DecorationImage(
                    image:NetworkImage("https://image.tmdb.org/t/p/w200${casts[index].img}" ,),
                    fit: BoxFit.cover )
                  ),
                 
                ),
                const SizedBox(height: 10,),
               SizedBox(
                width: 100,
                 child: Text(
                        casts[index].name!,
                        maxLines: 1,
                        overflow:TextOverflow.ellipsis ,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
               ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "${casts[index].character}",
                        maxLines: 1,
                        overflow:TextOverflow.ellipsis ,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            height: 1.4,
                            color: Style.Colors.titleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                    ),
 
              ],
            ),
          );
        }),
    );

   }
  }
}
  
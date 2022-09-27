import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:movie_app/bloc/get_persons_bloc.dart';
import 'package:movie_app/model/person.dart';
import 'package:movie_app/model/person_response.dart';

import '../style/theme.dart' as Style;

import 'package:flutter/material.dart';

class Persons extends StatefulWidget {
  const Persons({Key? key}) : super(key: key);

  @override
  State<Persons> createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personsListBloc.getPersons();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Padding(padding: EdgeInsets.only(top: 10,left: 10),
        child: Text("TRENDING PERSONS ON THIS WEEK"
        ,style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Style.Colors.titleColor),
        ),),
       const SizedBox(height: 5,),
        StreamBuilder(
      stream: personsListBloc.subject.stream,
      builder: (context ,AsyncSnapshot<PersonResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.error.isNotEmpty){
              return _buildErrorWidget(snapshot.data!.error);

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

  Widget _buildPersonsWidget(PersonResponse data){
    List<Person> persons=data.persons!;
   
    if(persons.isEmpty){
    return const Text(
                "No Persons",
                style: TextStyle(color: Colors.white),
              );

   }else{
    return Container(
      height: 150,
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: persons.length,
        itemBuilder: (context,index){
         
          return Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10,right: 10),
            child: Column(
              children: [
                persons[index].profileImg==''?
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
                    image:NetworkImage("https://image.tmdb.org/t/p/w200${persons[index].profileImg}" ,),
                    fit: BoxFit.cover )
                  ),
                 
                ),
                const SizedBox(height: 10,),
               Text(
                      persons[index].name!,
                      maxLines: 2,
                      style: const TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      "Trending for ${persons[index].known!}",
                      maxLines: 2,
                      style: const TextStyle(
                          height: 1.4,
                          color: Style.Colors.titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 7.0),
                    ),
 
              ],
            ),
          );
        }),
    );

   }
  }
}
  
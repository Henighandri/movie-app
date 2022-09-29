import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movies_byGenre_bloc.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/widgets/movies_widget.dart';
import '../style/theme.dart' as Style;

class GenresList extends StatefulWidget {
  GenresList({Key? key, required this.genres}) : super(key: key);
  final List<Genre> genres;

  @override
  State<GenresList> createState() => _GenresListState();
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: widget.genres.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
              controller: _tabController,
              indicatorColor: Style.Colors.secondColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              unselectedLabelColor: Style.Colors.titleColor,
              labelColor: Colors.white,
              isScrollable: true,
              tabs: widget.genres.map((Genre genre) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 15, top: 10),
                  child: Text(
                    genre.name.toUpperCase(),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 250,
              child: TabBarView(
          controller: _tabController,
          physics:const NeverScrollableScrollPhysics(),
          children:widget.genres.map((genre) => MoviesWidget(
            getMovieList: (){
               moviesByGenreBloc.getMovieByGenre(genre.id);
            },
            stream: moviesByGenreBloc.subject.stream,
            )).toList() ,
        ),
            ),
          

      ],
    );
    
  }
}

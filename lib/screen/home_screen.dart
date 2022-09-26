import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/widgets/now_playing.dart';
import '../style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Style.Colors.mainColor ,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          centerTitle:true,
          leading: const Icon(EvaIcons.menu2Outline,color: Colors.white,),
          title: const Text("Movie App"),
          actions: const [
            IconButton(onPressed: null, icon: Icon(EvaIcons.searchOutline,color: Colors.white,))
          ],
        ),
        body: ListView(children: [
          NowPlaying()

        ]),

    );
    
  }
}
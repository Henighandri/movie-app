import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../style/theme.dart' as Style;

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({
    Key? key,
    required this.videos,
  }) : super(key: key);

  final List<Video> videos;
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  int current_index = 0;
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videos[current_index].key!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Stack(
                children: <Widget>[
                  Center(
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                    ),
                  ),
                  Positioned(
                    top: 40.0,
                    right: 20.0,
                    child: IconButton(
                        icon: const Icon(
                          EvaIcons.closeCircle,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // SizedBox(
              //   height: 30,
              //   child: ListView.separated(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: widget.videos.length,
              //       separatorBuilder: ((context, index) => const SizedBox(
              //             width: 8,
              //           )),
              //       itemBuilder: (context, index) {
              //         return GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               _controller = YoutubePlayerController(
              //                 initialVideoId: widget.videos[current_index].key!,
              //                 flags: const YoutubePlayerFlags(
              //                   autoPlay: true,
              //                   mute: false,
              //                 ),
              //               );
              //               current_index = index;
              //             });
              //           },
              //           child: Container(
              //             padding:
              //                 EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(5),
              //                 border: Border.all(
              //                     color: current_index == index
              //                         ? Style.Colors.secondColor
              //                         : Style.Colors.titleColor,
              //                     width: 2)),
              //             child: Center(
              //                 child: Text(
              //               widget.videos[index].type!,
              //               style: const TextStyle(
              //                   color: Style.Colors.titleColor,
              //                   fontWeight: FontWeight.w500),
              //             )),
              //           ),
              //         );
              //       }),
              // )
            ],
          )),
    );
  }
}

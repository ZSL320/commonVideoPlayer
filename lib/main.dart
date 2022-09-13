import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import 'flick_video/flick_video_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlickManager? flickManager;
  Widget? player;
  bool? isPlaying;
  bool? videoFinished;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isPlaying!) {
            flickManager!.flickControlManager!.pause();
          } else {
            flickManager!.flickControlManager!.play();
          }
        },
        child: videoFinished ?? false
            ? const Icon(Icons.play_arrow)
            : isPlaying ?? false
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///如果不满意设计的ui可以根据返回的ui自己设计控件，不影响性能的情况下可以隐藏
            IgnorePointer(
              ignoring: false,
              child: Opacity(
                  opacity: 1.0,
                  child: Container(
                    height: 360,
                    child: CommonVideoPlayer(
                      showArrow: false,
                      controller: (value) {
                        flickManager = value;
                        if (flickManager != null) {
                          flickManager!.flickVideoManager!.addListener(() {
                            videoFinished =
                                flickManager!.flickVideoManager!.isVideoEnded;
                            isPlaying =
                                flickManager!.flickVideoManager!.isPlaying;
                            setState(() {});
                          });
                        }
                      },
                      playerWidget: (value) {
                        player = value;
                      },
                      videoPath:
                          "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
                    ),
                  )),
            ),
            const SizedBox(
              height: 13,
            ),
            const Text("播放ui，控件可根据返回的controller自定义"),
            const SizedBox(
              height: 13,
            ),
            player ?? Container(),
            const SizedBox(
              height: 38,
            ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CommonVideoPlayer(
                      videoPath:
                          "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
                    );
                  }));
                },
                child: const Text("点击进入视频播放"),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

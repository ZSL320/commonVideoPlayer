import 'dart:io';

import 'package:CommonVideoPlayer/flick_video/video_state.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';

class VideoPortraitControls extends StatelessWidget {
  const VideoPortraitControls(
      {Key? key,
      this.iconSize = 28,
      this.fontSize = 16,
      this.progressBarSettings,
      required this.flickManager})
      : super(key: key);

  final double iconSize;
  final double fontSize;
  final FlickManager flickManager;
  final FlickProgressBarSettings? progressBarSettings;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: FlickShowControlsAction(
            child: FlickSeekVideoAction(
              child: Center(
                child: FlickVideoBuffer(
                  child: FlickAutoHideChild(
                    showIfVideoNotInitialized: false,
                    child: FlickPlayToggle(
                      size: 30,
                      color: Colors.black,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlickVideoProgressBar(
                    flickProgressBarSettings: progressBarSettings,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlickPlayToggle(
                        size: iconSize,
                      ),
                      SizedBox(
                        width: iconSize / 2,
                      ),
                      FlickSoundToggle(
                        size: iconSize,
                      ),
                      SizedBox(
                        width: iconSize / 2,
                      ),
                      Row(
                        children: <Widget>[
                          FlickCurrentPosition(
                            fontSize: fontSize,
                          ),
                          FlickAutoHideChild(
                            child: Text(
                              ' / ',
                              style: TextStyle(
                                  color: Colors.white, fontSize: fontSize),
                            ),
                          ),
                          FlickTotalDuration(
                            fontSize: fontSize,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      FlickSubtitleToggle(
                        size: iconSize,
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry>[
                            PopupMenuItem(
                              onTap: () {
                                flickManager.flickControlManager!
                                    .setPlaybackSpeed(0.5);
                              },
                              child: Text(
                                "0.5X",
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                flickManager.flickControlManager!
                                    .setPlaybackSpeed(0.75);
                              },
                              child: Text(
                                "0.75X",
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                flickManager.flickControlManager!
                                    .setPlaybackSpeed(1.0);
                              },
                              child: Text(
                                "1X",
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                flickManager.flickControlManager!
                                    .setPlaybackSpeed(1.25);
                              },
                              child: Text(
                                "1.25X",
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                flickManager.flickControlManager!
                                    .setPlaybackSpeed(1.5);
                              },
                              child: Text(
                                "1.5X",
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                flickManager.flickControlManager!
                                    .setPlaybackSpeed(2.0);
                              },
                              child: Text(
                                "2X",
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ];
                        },
                      ),
                      SizedBox(
                        width: iconSize / 2,
                      ),
                      InkWell(
                        onTap: () {
                          VideoState.isFullScreen = false;
                          flickManager.flickDisplayManager!
                              .hidePlayerControls();
                          AutoOrientation.portraitAutoMode();
                          // iOS13+横屏时，状态栏自动隐藏，可自定义：https://juejin.cn/post/7054063406579449863
                          if (Platform.isAndroid) {
                            ///关闭状态栏，与底部虚拟操作按钮
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.manual,
                                overlays: SystemUiOverlay.values);
                          }
                        },
                        child: Icon(
                          Icons.fullscreen_exit,
                          size: iconSize,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

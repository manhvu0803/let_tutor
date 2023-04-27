import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/future_widget.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CustomVideoPlayer({super.key, this.videoUrl = "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoController;
  late Future<void> _videoFuture;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl);
    _videoFuture = _videoController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 200
      ),
      decoration: const BoxDecoration(
        color: Colors.black
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Colors.white),
        child: FutureWidget(
          customErrorMessage: "Can't load video playback",
          fetchData: () => _videoFuture,
          buildWidget: (context, data) {
            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
                FloatingActionButton(
                  onPressed: () => setState(() {
                    if (_videoController.value.isPlaying) {
                      _videoController.pause();
                    }
                    else {
                      _videoController.play();
                    }
                  }),
                  child: Icon(_videoController.value.isPlaying? Icons.pause : Icons.play_arrow),
                ),
              ]
            );
          }
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  final String title;
  final String subtitle;

  AudioPlayerWidget(
      {required this.url, required this.title, required this.subtitle});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Future<void> dispose() async {
    super.dispose(); //change here
    await audioPlayer.stop();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  Future setAudio() async {
    audioPlayer.setSourceUrl(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'lib/assets/note.png',
                width: double.infinity,
                height: 250,
              )),
          const SizedBox(height: 190),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              activeColor: Colors.blue,
              secondaryActiveColor: Colors.blue,
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                // setState(() {
                // audioPlayer.seek(Duration(seconds: value.toInt()));
                // });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position),
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text(formatTime(duration - position),
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue[300],
                  child: IconButton(
                    icon: Icon(Icons.fast_rewind_rounded),
                    iconSize: 35,
                    onPressed: () async {
                      await audioPlayer
                          .seek(Duration(seconds: position.inSeconds - 10));
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.blue[300],
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                    ),
                    iconSize: 50,
                    onPressed: () async {
                      if (isPlaying) {
                        setState(() {
                          isPlaying = false;
                        });
                        await audioPlayer.pause();
                      } else {
                        setState(() {
                          isPlaying = true;
                        });
                        await audioPlayer.resume();
                      }
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue[300],
                  child: IconButton(
                    icon: Icon(Icons.fast_forward_rounded),
                    iconSize: 35,
                    onPressed: () async {
                      await audioPlayer
                          .seek(Duration(seconds: position.inSeconds + 10));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State {
  bool isPlaying = false;
  Duration _duration = const Duration();
  Timer? _timer;

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _startTimer();
      } else {
        _stopTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration += const Duration(seconds: 1);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 50.0,
                ),
                onPressed: _togglePlayPause,
              ),
              const SizedBox(height: 20.0),
              Text(
                '${_duration.inHours.toString().padLeft(2, '0')}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

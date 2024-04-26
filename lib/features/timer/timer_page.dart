import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  bool isPlaying = false;
  Duration _duration = const Duration();
  Timer? _timer;
  late AnimationController _animationController;
  late AnimationController _animationTextController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _textScaleAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
    _animationTextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1000),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _textScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationTextController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationTextController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _startTimer();
        _animationController.stop();
        _animationTextController.repeat();
      } else {
        _stopTimer();
        _animationController.repeat(reverse: true);
        _animationTextController.stop();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _duration = const Duration();
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ScaleTransition(
                scale: _textScaleAnimation,
                child: Text(
                  '${_duration.inHours.toString().padLeft(2, '0')}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
              ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

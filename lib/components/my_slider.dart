import 'dart:async';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double _value = 0.0;
  Timer? _timer;
  bool _showSlider = true;

  void _startTimer() {
    _timer = Timer(Duration(seconds: 5), () {
      setState(() {
        _showSlider = false;
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _startTimer();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        setState(() {
          _showSlider = true;
          _resetTimer();
        });
      },
      onPanCancel: () {
        setState(() {
          _showSlider = false;
        });
      },
      child: Opacity(
        opacity: _showSlider ? 0.8 : 0.2,
        child: Slider(
          value: _value,
          onChanged: (newValue) {
            setState(() {
              _value = newValue;
            });
          },
          min: 0.0,
          max: 100.0,
        ),
      ),
    );
  }
}

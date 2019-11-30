import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TimerButton extends StatefulWidget {
  final int seconds;
  final Function onStart;
  final Function onFinish;
  final double fontSize;
  TimerButton({this.seconds: 75, this.onStart, this.onFinish, this.fontSize});
  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  Timer _timer;
  int _start;

  @override
  void initState() {
    // TODO: implement initState
    _start = widget.seconds;
    super.initState();
    startTimer();
    if (widget.onStart != null) widget.onStart();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            _timer.cancel();
            if (widget.onFinish != null) widget.onFinish();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Column(
      children: <Widget>[
        Text(
          "${(_start / 60).toInt() < 10 ? '0' : ''}${(_start / 60).toInt()}:${_start % 60 < 10 ? '0' : ''}${_start % 60}",
          style: TextStyle(
              fontSize: widget.fontSize != null
                  ? widget.fontSize
                  : tablet ? hp(5) : hp(4.3),
              fontWeight: FontWeight.w600,
              color: AppColors.TermsGray),
        )
      ],
    );
  }
}
